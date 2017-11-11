title: "Codebook Samsung dataset analysis and conversion"
author: "schwenk1"

## What is this about?
Accelerometer data from the Samsung Galaxy S smartphone was recorded in a dataset.
As the final assignment of the Coursera "Getting and Cleaning Data Course Project" it is required to analyse and clean the provided data set to result in a tidy dataset that is exported. 

Note: more information about the Samsung Accelerometer data is available in the accelerometers.zip file[1]
Information in this file describes the transformation process.

## Conversion steps in run_analysis.R
1. first the zip is extracted (if this was not already done) into the workingdirectory
2. Merges the training and the test sets to create one data set.
	- includes merge of training and test sets (X_train/X_test) and with subject ids (subject_train/subject_test) and activity id's (y_train/y_test). Also the activity names and column name files are loaded.
3. Appropriately labels the data set with descriptive variable names. 
	- assign column names in features file to the columns
	- See notes below with changes made in comparison with original Samsung codebook[1]
4. Uses descriptive activity names to name the activities in the data set
5. Extracts only the measurements on the mean and standard deviation for each measurement. 
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
7. Write tidy dataset to txt file

## What is visible in the tidydataset.txt file
Following columns:
* activity_name: WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING
, STANDING, LAYING
 
* subject_id: id of the person that participated in measurements
* type: person was in test or train group. Note that adding type in the dataset is optional, as I think this is variable also important information for further analysis. Default = show it. It can be removed by parameter 'includeType = FALSE'. 
* AVERAGE Mean and AVERAGE Standard Deviation (STD) variables on e.g. body, gravity positions X,Y,Z. Grouped by: subject and activity. There are variables for mean/std: 
  + XYZ: "XYZ' is used to denote 3-axial signals in the X, Y and Z directions."[1]
  + time or frequency
  + Gyro or Acceleration (Acc)	
  + Magnitude (Mag) and/or Jerk (sudden movements) 	
  
 Complete set includes at the bottom:

See original Samsung documentation for more information on the meaning of the variables[1]
Note that the following changes where made to the variable names to enhance readability:
* t/f prefixes to Body / Gravity where renamed to respectively: time / frequency
* other name changes where also made, but these are not visible in the tidydataset.txt file (but are available in accelerometer variable in R script). See see script lines 75-83 for details.



[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.)

Variables: 
activity_name" "subject_id" "timeBodyAcc-mean()-X" "timeBodyAcc-mean()-Y" "timeBodyAcc-mean()-Z" "timeBodyAcc-std()-X" "timeBodyAcc-std()-Y" "timeBodyAcc-std()-Z" "timeDataAcc-mean()-X" "timeDataAcc-mean()-Y" "timeDataAcc-mean()-Z" "timeDataAcc-std()-X" "timeDataAcc-std()-Y" "timeDataAcc-std()-Z" "timeBodyAccJerk-mean()-X" "timeBodyAccJerk-mean()-Y" "timeBodyAccJerk-mean()-Z" "timeBodyAccJerk-std()-X" "timeBodyAccJerk-std()-Y" "timeBodyAccJerk-std()-Z" "timeBodyGyro-mean()-X" "timeBodyGyro-mean()-Y" "timeBodyGyro-mean()-Z" "timeBodyGyro-std()-X" "timeBodyGyro-std()-Y" "timeBodyGyro-std()-Z" "timeBodyGyroJerk-mean()-X" "timeBodyGyroJerk-mean()-Y" "timeBodyGyroJerk-mean()-Z" "timeBodyGyroJerk-std()-X" "timeBodyGyroJerk-std()-Y" "timeBodyGyroJerk-std()-Z" "timeBodyAccMag-mean()" "timeBodyAccMag-std()" "timeDataAccMag-mean()" "timeDataAccMag-std()" "timeBodyAccJerkMag-mean()" "timeBodyAccJerkMag-std()" "timeBodyGyroMag-mean()" "timeBodyGyroMag-std()" "timeBodyGyroJerkMag-mean()" "timeBodyGyroJerkMag-std()" "frequencyBodyAcc-mean()-X" "frequencyBodyAcc-mean()-Y" "frequencyBodyAcc-mean()-Z" "frequencyBodyAcc-std()-X" "frequencyBodyAcc-std()-Y" "frequencyBodyAcc-std()-Z" "frequencyBodyAcc-meanFreq()-X" "frequencyBodyAcc-meanFreq()-Y" "frequencyBodyAcc-meanFreq()-Z" "frequencyBodyAccJerk-mean()-X" "frequencyBodyAccJerk-mean()-Y" "frequencyBodyAccJerk-mean()-Z" "frequencyBodyAccJerk-std()-X" "frequencyBodyAccJerk-std()-Y" "frequencyBodyAccJerk-std()-Z" "frequencyBodyAccJerk-meanFreq()-X" "frequencyBodyAccJerk-meanFreq()-Y" "frequencyBodyAccJerk-meanFreq()-Z" "frequencyBodyGyro-mean()-X" "frequencyBodyGyro-mean()-Y" "frequencyBodyGyro-mean()-Z" "frequencyBodyGyro-std()-X" "frequencyBodyGyro-std()-Y" "frequencyBodyGyro-std()-Z" "frequencyBodyGyro-meanFreq()-X" "frequencyBodyGyro-meanFreq()-Y" "frequencyBodyGyro-meanFreq()-Z" "frequencyBodyAccMag-mean()" "frequencyBodyAccMag-std()" "frequencyBodyAccMag-meanFreq()" "frequencyBodyBodyAccJerkMag-mean()" "frequencyBodyBodyAccJerkMag-std()" "frequencyBodyBodyAccJerkMag-meanFreq()" "frequencyBodyBodyGyroMag-mean()" "frequencyBodyBodyGyroMag-std()" "frequencyBodyBodyGyroMag-meanFreq()" "frequencyBodyBodyGyroJerkMag-mean()" "frequencyBodyBodyGyroJerkMag-std()" "frequencyBodyBodyGyroJerkMag-meanFreq()" "angle(timeBodyAccMean,gravity)" "angle(timeBodyAccJerkMean),gravityMean)" "angle(timeBodyGyroMean,gravityMean)" "angle(timeBodyGyroJerkMean,gravityMean)" "angle(X,gravityMean)" "angle(Y,gravityMean)" "angle(Z,gravityMean)"

