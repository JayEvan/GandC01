# Coursera Getting and Cleaning Data Course Project
## JayEvan created May 7, 2014
## UCI HAR Dataset
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly 
## Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
## Vitoria-Gasteiz, Spain. Dec 2012

## Data and experiment are described in four files.
file.show("./UCI HAR Dataset/features_info.txt")
file.show("./UCI HAR Dataset/README.txt")

## activity_labels are coded 1 through 6 for six activities
activity_labels <- read.table("~/Desktop/GandC01/UCI HAR Dataset/activity_labels.txt", header = FALSE)
## creates data.frame of 6 obs of 2 variables

## accelerometer and gyroscope data were processed to extract 561 descriptive and summary
## measurements within a time window. These features are tallied in features.txt
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
## creates data.frame of feature numbers and names for 561 features

## only want mean() and std() features, so find in feature names.
## 
select1 <- grep("mean()", features$V2, fixed = TRUE) #get feature numbers with "mean" in name
select2 <- grep("std()", features$V2, fixed = TRUE) # get feature numbers with "std" in name
select3 <- sort(c(select1, select2))
featuresub <- features[select3,] # wanted features data.frame
featurecolumns <- featuresub[,1]
featurenames <- featuresub[,2]
## make the featurenames more readable

#gsub()

# there are two groups of subjects, test and train
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) <- "subject"
table(subject_test)  ## data.frame for 2947 obs of subject numeric ID for nine subjects 
subject_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/subject_train.txt")
names(subject_test) <- "subject"
table(subject_train) ## creates data.frame for 7352 obs of subject numeric ID for 21 subjects

Y_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/Y_test.txt") ## index of activity numbers
names(Y_test) <- "activitycode"
table(Y_test)
Y_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/Y_train.txt")  ## index of activity numbers
names(Y_train) <- "activitycode"
table(Y_train)

# accelerometer and gyroscope data were processed to extract 561 descriptive and summary
# measurements within a time window 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
## creates data.frame of 2947 observations of 561 variables.
X_test <- X_test[,featurecolumns]  ## shrink to desired 66 features
names(X_test) <- featurenames  ## set the featurenames
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
## creates data.frame of 7352 observations of 561 variables
X_train <- X_train[,featurecolumns]  ## shrink to desired 66 features
names(X_test) <- featurenames  ## set the featurenames

myProject <- function(x) {
  #activity_labels.txt - six levels for decoding activities
  activity_labels <- read.table("~/Desktop/GandC01/UCI HAR Dataset/activity_labels.txt")
  print(activity_labels)
  str(activity_labels)
  #file.show("~/Desktop/GandC01/UCI HAR Dataset/features_info.txt")

  subject_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/subject_test.txt")
  
  subject_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/subject_train.txt")
  
  X_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/X_test.txt")
  X_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/X_train.txt")
  
  Y_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/Y_test.txt")
  Y_train <- read.table("~/Desktop/GandC01/UCI HAR Dataset/train/Y_train.txt")
  
  ## total_acc_x_test <- read.table("~/Desktop/GandC01/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
  ##m1 <- rowMeans(total_acc_x_test)
  ## use apply to calculate rowMeans
  #m1 <- apply(tx, 1, mean)
  #sd1 <- apply(tx, 1, sd)

  str(activity_labels)
  str(subject_test)
  str(X_test)
  str(Y_test)

  return(Y_test)
}

