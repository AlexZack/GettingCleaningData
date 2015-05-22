prj01 <- function() {
##Course Project *************************************************************************************
## The goal of this Course Project is to prepare tidy data that can be used for later analysis. 
## The data linked to the course website represent data collected from the accelerometers of 
## the Samsung Galaxy S smartphone. 
## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## This R script called run_analysis.R does the following: 
## 1.	Merges the training and the test sets to create one data set.
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.	Uses descriptive activity names to name the activities in the data set
## 4.	Appropriately labels the data set with descriptive variable names. 
## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each
##    variable for each activity and each subject.
##*****************************************************************************************************
      ##Loading and installing "reshape2" library
      setInternet2(use = TRUE)
      install.packages("reshape2") 
      library(reshape2)

      ## 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET ##############################
      
      ## 1.1) READING TEST SET ADDING LABEL AND SUBJECT COLUMNS ---------------------------------------  
      
      ## Read TEST SET and create dataframe test_data
      test_data <- read.table("./X_test.txt")
      ## Dimensions of test_data: nrow = 2947 ; ncol = 561
            
      ## Read TEST LABEL SET and create dataframe label_test
      label_test <- read.table("./y_test.txt")
      ## Dimensions of label_data: nrow = 2947 ; ncol = 1

      ## Add column to test_data with the "labels" contained in label_test (column)
      ## "label" for each measure is referred to the "activity"
      test_data$Label <- label_test[,1]
      
      ## Read SUBJECT TEST set and create dataframe sub_test
      sub_test <- read.table("./subject_test.txt")
      ## Dimensions of sub_data: nrow = 2947 ; ncol = 1

      ## Add column to test_data with the content of sub_test (column)
      ## sub_test contains the Subject for each measure
      test_data$Subject <- sub_test[,1]

      ## 1.2 READING TRAINING SET ADDING LABEL AND SUBJECT COLUMNS -------------------------------------  

      ## Read TRAINING SET and create dataframe train_data
      train_data <- read.table("./X_train.txt")
      ## Dimensions of train_data: nrow = 7352 ; ncol = 561
        
      ## Read TRAINING LABEL set and create dataframe label_train
      label_train <- read.table("./y_train.txt")
      ## Dimensions of train_label: nrow = 7352 ; ncol = 1

      ## Add column to train_data with the "label" contained in label_train
      ## The "label" for each measure is referred to the "activity"
      train_data$Label <- label_train[,1]

      ## Read SUBJECT TRAIN set and create dataframe
      sub_tr <- read.table("./subject_train.txt")
      ## Dimensions of sub_tr: nrow = 7352 ; ncol = 1

      ## Add column to train_data with the content of sub_tr
      ## sub_tr contains the Subject for each measure
      train_data$Subject <- sub_tr[,1]

      ## 1.3) RBINDING BETWEEN 2 DATA SET (train_full and test_full) TO OBTAIN ONE DATA SET ----------- 
      full_data <- rbind(test_data, train_data)
      ## Dimensions of full_data: [10.299 x 563]. Full_data contains all measurements from training 
      ## and test data set. For each measure (infull_data) is available the Subject and the Activity 
      ## related to.
            
      ## 1.4) NAMING DATAFRAME FULL_DATA WITH DESCRIPTIVE "VARIABLE" NAMES ----------------------------
      ## Create dataframe "h_features" with data from features.txt
      h_features <- read.table("./features.txt")  ## 561 rows
      h_features$V2 <- as.character(h_features$V2)
      ## Put names from features.txt into full_data dataframe
      names(full_data)[1:561] <- c(h_features$V2)

      ## 2. EXTRACTION ONLY MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT #####
      ## On full_data are selected only columns that contains in their names the string "-mean" or "-std" 
      pos_mean <- grep("-mean",h_features$V2) 
      pos_std <- grep("-std",h_features$V2)
      pos_full <- c(pos_mean, pos_std, 562, 563)   ## 46+33+2(Label/Subject) = 81 occurrences
      pos_full <- sort(pos_full)                   
      ## Sort of the pos_full dataframe. Pos_full contains the position of columns with "-mean" or "-std" 
      ## in the name.
      full_data <- full_data[c(pos_full)]

      ## 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET ###################
      
      ## 3.1) Read ACTIVITY LABEL set and create dataframe -------------------------------------------
      act_lbl <- read.table("./activity_labels.txt")
      names(act_lbl) <- c("Label","Activity")

      ## 3.2) MERGE THE FULL DATAFRAME WITH TEST & TRAIN SETS WITH ACTIVITY LABEL DATA SET -----------
      full_data <- merge(full_data, act_lbl, by="Label")       

      ## 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE "VARIABLE" NAMES ###################### 
      ## Already done in step 1.4)
 
      ## 5. FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE 
      ## OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT #########################################
      
      ## 5.1) Deleting column named "Label" because it is not useful for next processing and 
      ## it's better remove it to simplify the dataframe "full_data" ---------------------------------
      full_data <- full_data[,-1]

      ## 5.2) Melt() on dataframe full_data. Each row contains the measure corresponding to an "Activity" 
      ## and a "Subject" (one measure for all possible combinations of Subject and Activity. 
      ## To get rid of NA by using na.rm = TRUE in the call to melt.
      ## The new dataframe named "last_data" has 813.621 rows ; 4 columns
      last_data <- melt(full_data, id = c("Activity", "Subject"), na.rm = TRUE)
 
      ## 5.3) Cast() on dataframe full_data. ----------------------------------------------------------- 
      last_data <- dcast(last_data, Activity + Subject ~ variable , mean)    
    
      ## 5.4) Write content of full_data on last_full_data.txt -----------------------------------------
      write.table(last_data, "last_full_data.txt", sep = " ", row.name=FALSE)  
 
}


