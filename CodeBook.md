# Getting and Cleaning Data Course Project #
# Code Book #
This Code Book contains information about:  

- the variables in the row data set;
- the summary choices that I made;
- the approach to study design that I used.

# BACKGROUND #
The purpose of this data analysis is to prepare tidy data that can be used for later analysis related to weareable computing.   
The row data are collected from the accelerometers and gyroscope of the Samsung Galaxy S smartphone.   
The experiments (from which raw data are derived) have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.   
Each person performed six activities:   
- **WALKING  
- WALKING\_UPSTAIRS  
- WALKING\_DOWNSTAIRS  
- SITTING  
- STANDING  
- LAYING**  
People wearing a smartphone Samsung Galaxy S II on the waist.  
       
The source (raw) data for the project is available on the following url:     
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Using embedded accelerometer and gyroscope within the smartphone of the 30 subjects, have been captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).   

The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
  
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
                                                       
The dataset obtained has been randomly partitioned into two sets, where	70% of the volunteers was selected for generating the TRAINING data and 30% the TEST data.  
    
For each record in the dataset is provided:  
- ***Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration  
- Triaxial Angular velocity from the gyroscope  
- A 561-feature vector with time and frequency domain variables  
- Its activity label  
- An identifier of the subject who carried out the experiment.***
    
# RAW DATA COLLECTION #
The list of raw data is the following:  
- **activity\_labels.txt**: links the class labels to the  activity name  
- **features.txt**: list of all features  
- **subject\_test.txt**: list of the subjects related to TEST data  
- **subject\_train.txt**: list of the subjects related to TRAIN data                                                         
- **X\_test.txt**: Test set  
- **y\_test.txt**: Test labels   
- **X\_train.txt**: Training set  
- **y\_train.txt**: Training labels                             

# FEATURES VARIABLES #
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

The features are normalized and bounded within [-1,1] and each feature vector is a row on the text file.

The signals used to estimate variables of the feature vector for each pattern are ('-XYZ' is used to denote 3-axial signals in the X, Y and Z directions):

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are:   

- **mean(): mean value**  
- **std(): standard deviation** 
- mad(): Median absolute deviation   
- max(): Largest value in array  
- min(): Smallest value in array  
- sma(): Signal magnitude area  
- energy(): Energy measure. Sum of the squares divided by the number of values.   
- iqr(): Interquartile range  
- entropy(): Signal entropy  
- arCoeff(): Autorregresion coefficients with Burg order equal to 4  
- correlation(): correlation coefficient between two signals  
- maxInds(): index of the frequency component with largest magnitude  
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
- skewness(): skewness of the frequency domain signal   
- kurtosis(): kurtosis of the frequency domain signal   
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window 
- angle(): Angle between to vectors 

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

**IN THE TIDY DATA HAVE BEEN CONSIDERED ONLY FEATURES WITH "MEAN VALUE" AND "STANDARD DEVIATION" BECAUSE STEP 2) OF THE COURSE PROJECT EXPECTED TO MANAGE ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.**

# PROCEEDING AND SUMMARY CHOICES #
## 1.Merges the training and the test sets to create one data set ##
1.1 I create dataframe "test\_data" with Test Data Set (source: X\_test.txt) and add to it the columns "Label" (source: y\_test.txt) and "Subjects" (source: subject_test.txt). The "Label" for each single measurement is the key that provides link to the related "Activity" (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING).  

1.2 I create dataframe "train\_data" with Train Data Set (source: X\_train.txt) and add to it the columns "Label" (source: y\_train.txt) and "Subjects" (source: subject\_train.txt). The "Label" is the key that provides link of each single measurement with the related "Activity" (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING).  
    
1.3 I execute rbind() between "test\_data" and "train\_data" for obtaining one data set called "full\_data". Dimensions of full_data dataframe are [10.299 rows x 563 columns].   
Full\_data contains all measurements from training and test data set.   
For each measure (within full\_data) is available the Subject and the Activity related to.

1.4 I apply descriptive labels into "full\_data" for naming variables (name of columns) of full_data dataframe. The descriptive labels are taken from the file features.txt. 
    
## 2.	Extracts only the measurements on the mean and standard deviation for each measurement.  ##
2.1 I searched and kept track of the variable names containing the string "-mean" or "-std" using the statement grep().    

2.2 I subsetting dataframe "full_data" extracting only variables (columns) related to measurement on the mean and standard deviation **plus** variables  Activities and Subjects.
	
## 3.	Uses descriptive activity names to name the activities in the data set  ##
3.1 I apply a new column to full_data dataframe with data of the activity\_labels.txt and named it "Activity".
	
## 4.	Appropriately labels the data set with descriptive variable names.  ##
I already done in step 1.4)

## 5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##
5.1 I Delete column named "Label" from full\_data dataframe because it is not useful for next processing and it's better remove it to simplify and "lightening" the dataframe "full\_data".   

5.2 Using statement melt() on dataframe full_data I obtained the new dataframe last_data where each row contains the measure corresponding to an "Activity" and a "Subject" (then, one measure for all possible combinations of Subject and Activity). To get rid of NA I used na.rm = TRUE in the call to melt(). The new dataframe named "last\_data" has 813.621 rows ; 4 columns.

5.3 Using statement dcast() on dataframe last_data I obtained a new dataframe where **in each row**, **for each pair of Activity + Subject**, I have the **mean value (average) of each variable extract previously in the step 2)**. I have used in the call to dcast(), **Activity + Subject ~ variable** as casting formula and **fun.aggregate = mean**. 

5.4 I write content of last_data on last\_full\_data.txt using statement write.table() with option row.name=FALSE

