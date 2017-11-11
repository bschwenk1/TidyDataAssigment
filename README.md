title: "README Samsung dataset analysis and conversion"
author: "schwenk1"

## What is this about?
Accelerometer data from the Samsung Galaxy S smartphone was recorded in a dataset.
As the final assignment of the Coursera "Getting and Cleaning Data Course Project" it is required to analyse and clean the provided data set to result in a tidy dataset that is exported. 


## Data analysis files
There are two main files needed to run this analysis and data conversion.
1. Samsung Accelerometer data (accelerometers.zip).[1]
2. R script that converts the Samsung data to tidy dataset (run_analysis.R)
   run_analysis has an optional parameter to specify if type is to be included in the tidydataset or not. For me it was not clear if this information was implicitly required or not. In dataset uploaded dataset I chose to not add the type column in tidydataset_without type.txt. 

Options for includeType are:
includeType = FALSE --> not include variable (uploaded to coursera)
includeType = TRUE  --> include variable (test or train group)(also available on GitHub: tidydataset.txt)

## How this works?
1. If the run_analysis script is run, it will extract the Samsung Accelerometer data into the working directory.
2. The script will clean and select the required data from the dataset according to the assignment
3. A file named "tidydataset.txt" is written to the working directory. It contains the cleaned output that can be used for further analysis.

## further info
* CodeBook: gives info on analysis and output data, resulting in the tidydataset.txt file
* Inside Accelerometer zipfile there is additional information about the orginal dataset.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.)


