run_analysis <- function(includeType=TRUE){
  #function to tidy data from source and export tidied up dataset:
  #   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  #   Data source license:
  #   ========
  #    Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
  #    [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
  #    This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
  #    Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
  
  
  #Overview of steps:
  # *	Merges the training and the test sets to create one data set.
  # *	Appropriately labels the data set with descriptive variable names. 
  # * Uses descriptive activity names to name the activities in the data set
  # *	Extracts only the measurements on the mean and standard deviation for each measurement. 
  # *	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # * Write tidy dataset to txt file (tidydataset.txt)
  
  library(plyr)
  library(dplyr)
  
  
  ##### DOWNLOAD ZIP AND EXTRACT #####
  # only download and extract if extraction folder not yet exists (download is slow)
  work_dir<-getwd()                                           # save working dir to reset on the end of function
  if (!file.exists("UCI HAR Dataset")){
      download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "accelerometers.zip")
      unzip("accelerometers.zip",exdir=work_dir)
  }
  
  #############################################
  # Merges the training and the test sets to create one data set (accelerometer)
  # Also are added the type(test/train), activity name and subject_id. Match on row order. 
  
  # Get column- and variable labels
  setwd(paste0(work_dir,"/UCI HAR Dataset/"))
  activity_labels <- read.table("activity_labels.txt",header= FALSE) #get activity labels and add variable names
  names(activity_labels)<-c("activity_id","activity_name")
  
  features_labels <- read.table("features.txt",header= FALSE)        #get feature labels and add variable names
  names(features_labels)<-c("feature_id","feature_name")
  
  #*** Get Test set ***
  setwd(paste0(work_dir,"/UCI HAR Dataset/test"))
  test_results <- read.table("X_test.txt",header= FALSE)        #get outcomes. Each row is a outcome of a certain activity
  test_activities<- read.table("y_test.txt", header=FALSE)      #get activity numbers. The row number corresponds to item in outcome table
  names(test_activities)<-"activity_id"
  test_subjects<- read.table("subject_test.txt", header=FALSE)  #get subjects. This are test subjects 1:30. People who have done the test (test set)
  test_type <- data.frame(type="test")                          #variable type = test or train (used for merging)
  
  
  #*** Get Train set ***
  setwd(paste0(work_dir,"/UCI HAR Dataset/train"))
  train_results <- read.table("X_train.txt",header= FALSE)      #table with outcomes. Each row is a outcome of a certain activity
  train_activities<- read.table("y_train.txt", header=FALSE)    #get activity numbers. The row number corresponds to item in outcome table
  names(train_activities)<-"activity_id"
  train_subjects<- read.table("subject_train.txt", header=FALSE)#get subjects. This are train subjects 1:30. People who have done the test (training set)
  train_type <- data.frame(type="train")                        #variable type = test or train (used for merging)

  # Combine tables
  test<-cbind(test_type, test_activities,test_subjects,test_results)        #combine all test tables to one test table (every rows corresponds)
  train<-cbind(train_type, train_activities,train_subjects,train_results)   #combine all train tables to one train table (every rows corresponds)
  accelerometer<-rbind(test,train)                                          #add rows of training to test 
  
  
  
  #############################################
  # Appropriately labels the data set with descriptive variable names.
  
  # Make a vector of names
  column_names <- c("type","activity_id","subject_id", as.character(features_labels[,2]))
  
  # change some of the labels to make them more descriptive
  column_names <- gsub("tBody", "timeBody", column_names)
  column_names <- gsub("fBody", "frequencyBody", column_names) 
  column_names <- gsub("tGravity", "timeData", column_names)
  column_names <- gsub("fGravity", "frequencyData", column_names)
  column_names <- gsub("mad()", "medianAbsDev", column_names)
  column_names <- gsub("irq()", "interQuartalRange", column_names)
  column_names <- gsub("sma()", "signalMagnitudeArea", column_names)
  column_names <- gsub("arcoeff()", "AutoRegrCoeff", column_names)
  column_names <- gsub("maxInds()", "IndexMaxMagnitude", column_names)
  
  
  #assign to table
  names(accelerometer)<- column_names                           #set variable names of all columns
  
  
  #############################################
  # Uses descriptive activity names to name the activities in the data set
  accelerometer <- accelerometer[,!grepl("(.*bandsEnergy().*)",names(accelerometer))] #remove these columns as they return warning (and we do not need them for end result)
  accelerometer <- merge(accelerometer,activity_labels,by.x="activity_id",by.y="activity_id") #merge on activity id (column is added in last position)
  accelerometer <- accelerometer[, c(grep("activity_name", names(accelerometer)), (1:ncol(accelerometer)-1))]  #move activity name to the front
  
  
  ############################################
  # Extracts only the measurements on the mean and standard deviation for each measurement.
  # Although not explicitly mentioned in the assignment, I also added the type (test|train), activity_name and subject_id. Otherwise the dataset would be less useable)
  # type selection can be selected or unselected via function parameter includeType. Default = selected. 
    if (includeType==TRUE){ 
      typestring<-"(type)|"
    }else{
      typestring<-""
    }
    accelerometer <- accelerometer[,grep(paste0(typestring,"(activity_name)|(subject_id)|(.*[Mm]ean.*)|(.*[Ss]td.*)"),names(accelerometer))]
  
  
  ##############################################
  #From the data set in step 4 (previous line), creates a second, 
  #independent tidy data set with the average of each variable for each activity and each subject.
  #this gets a table with activity_name, subject_id, type (test|train) and all mean values for all other variables. 
  #Note that type is excluded (subject is in test or train group) if includeType=TRUE (otherwise not part of dataset)
  #PS. I added type although not mentioned explicitly in the assignment. I think this is needed to know if person is in test or train group. 
    if (includeType==TRUE){   
      tidydata <- aggregate(. ~ activity_name+subject_id-type, data=accelerometer, mean)  #average all values (=.) by grouping activity_name and subject_id.
    }else{
      tidydata <- aggregate(. ~ activity_name+subject_id, data=accelerometer, mean)  #average all values (=.) by grouping activity_name and subject_id. Excl type
    }
  
  #############################################
  # produce tidy data set as text file to upload to coursera. 
  setwd(work_dir) #return work dir to old work dir.
  write.table(tidydata, file="tidydataset.txt", row.name=FALSE) 
  
  print("data analysis finished, file tidydataset.txt is exported to working directory")
}