#README.md

This repo is created in fulfillment of Coursera Getting and Clean Data, course project. May 6, 2014.  

The project utilizes the data contained in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

An script for accomplishing the project run_analysis.R can be sourced.

The data are 561 features extracted from accelerometer and gyroscope readings in fixed time windows during six activities performed by 30 subjects divided into test and train groups

Data is contained in 3 files for each group 
The assignment is
You should create one R script called run_analysis.R that does the following. 
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names. 
 5. Creates a second, independent tidy data set with the average of each variable for each activity     
    and each subject. 

file.show("./UCI HAR Dataset/features_info.txt")
file.show("./UCI HAR Dataset/README.txt")

Activities are coded 1 through 6 for six activities in activity_labels.txt

The names of 561 descriptive and summary measurements are found in features.txt.
From these names, those containing the text "mean()" or "std()" were selected for processsing
according to the project instructions.  The text "mean" does appear without "()" but these
appear to be features that are derived from means.

The feature names were made more readable by deleting punctuation. It was decided to
keep capital letters because making them lowercase would eliminate the break in the names

The feature data for the two subject groups were read, desired features extracted and then combined with subject and activity vectors.  These were then concatenated.

Mean values for each feature for each activity for each subject were calculated and the 
activity code then replaced with descriptive activity labels to make a tidy data set.

Finally, both the combination data and the tidy data were written to .csv files.
