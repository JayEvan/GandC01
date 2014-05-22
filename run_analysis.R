# Coursera Getting and Cleaning Data Course Project
## JayEvan created May 7, 2014
## UCI HAR Dataset
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
## Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
## Vitoria-Gasteiz, Spain. Dec 2012

library(doBy)
library(plyr)
library(reshape2)

## Data and experiment are described in four files.
file.show("./UCI HAR Dataset/features_info.txt")
file.show("./UCI HAR Dataset/README.txt")

## activity_labels are coded 1 through 6 for six activities
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
names(activity_labels) <- c("code", "activity")  # creates data.frame of 6 obs of 2 variables

## accelerometer and gyroscope data were processed to extract 561 descriptive and summary
## measurements within a time window. These features are tallied in features.txt
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)  # creates data.frame of feature numbers and names for 561 features

## only want "mean()" and "std()" features, so find these strings in feature names.
## some uncertainty in assignment about other features derived from mean and std statistics.
## also mean and std are referred to as measurements on measurements, which is ambiguous
select1 <- grep("mean()", features$V2, fixed = TRUE) #get feature numbers with "mean" in name
select2 <- grep("std()", features$V2, fixed = TRUE) # get feature numbers with "std" in name
select3 <- sort(c(select1, select2))
featuresub <- features[select3,] # desired features data.frame
featurecolumns <- featuresub[,1]  # just the column numbers
featurenames <- featuresub[,2]  # just the feature names

## make the featurenames more readable
## - and () are ugly and unnecessary
## caps are OK but could use tolower()
featurenames <- gsub(pattern = "-", replacement = "", x = featurenames)
featurenames <- gsub(pattern = "\\(\\)", replacement = "", x = featurenames)

# there are two groups of subjects, test and train.  Read the indices of subjects
# each subject ID is repeated for multiple measurement intervals
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
table(subject_test)  ## data.frame for 2947 obs of subject numeric ID for nine subjects 
subject_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/subject_train.txt")
names(subject_train) <- "subject"
table(subject_train) ## creates data.frame for 7352 obs of subject numeric ID for 21 subjects

# read the indices of activity codes
# the activity codes are repeated for multiple measurement intervals
Y_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/Y_test.txt") ## index of activity numbers
names(Y_test) <- "activity"
table(Y_test)
Y_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/Y_train.txt")  ## index of activity numbers
names(Y_train) <- "activity"
table(Y_train)

# accelerometer and gyroscope data were processed to extract 561 descriptive and summary
# measurements within time windows 
# only want measurements of mean() and std() features
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE) ## data.frame of 2947 observations of 561 variables.
X_test <- X_test[,featurecolumns]  ## shrink to desired 66 features
names(X_test) <- featurenames  ## set the featurenames
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)## data.frame of 7352 observations of 561 variables
X_train <- X_train[,featurecolumns]  ## shrink to desired 66 features
names(X_train) <- featurenames  ## set the featurenames

## make one dataset
###combine subject, activity, and selected feature tables for test and train
tmp1 <- cbind(subject_test, Y_test, X_test)
tmp2 <- cbind(subject_train, Y_train, X_train)
### combine indexed test and train
combo <- rbind(tmp1, tmp2)

# calculate mean feature for each subject and activity
melt1 <- melt(combo, id=c("subject", "activity"))
tidy <- dcast(melt1, formula = subject + activity ~ variable, mean)
# results in tidy are sorted by subject and activity code
#replace activity code with activity by simple assignment
tidy$activity <- activity_labels[,2]

# output the combined data set
write.csv(combo, file = "./combo.csv")
# output the summary data set with average of each variable for each variable for each subject
write.csv(tidy, file = "./tidy.csv")
