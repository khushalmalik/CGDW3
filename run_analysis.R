## setup working directory
setwd("~/Desktop/Data Science/Getting and Cleaning Data/Assignment Dataset week 3")

## read dataset X_train into trainf (total number of columns = 561)
trainf = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)

## read dataset Y_train (txt dataset with single column) into column 562 of trainf
trainf[,562] = read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)

## read subject_train (txt dataset with single column) into column 563 of trainf
trainf[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)

## read dataset X_test into testf (total number of columns = 561)
testf = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)

## read dataset Y_test (txt dataset with single column) into column 562 of testf
testf[,562] = read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)

## read dataset subject_test (txt dataset with single column) into column 563 of testf
testf[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

## read dataset activity_labels into actlbl
actlbl = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)

## Read dataset features into features 
features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

## removing unwanted symbols

features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

## 1. Merges the training and the test sets to create one data set.
mdset = rbind(trainf, testf)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colsel <- grep(".*Mean.*|.*Std.*", features[,2])

## features table <- column we selected
features <- features[colsel,]

## keep the subjectID and activity columns
colsel <- c(colsel, 562, 563)

## remove unnecessary i.e. keeping columns we need from mdset
mdset <- mdset[,colsel]

## Add the column names (features) to mdset
colnames(mdset) <- c(features$V2, "Activity", "Subject")
colnames(mdset) <- tolower(colnames(mdset))

counter = 1 ## initialize counter and run while loop pattern matching and replacement

 while (CALabel in actlbl$V2) {
   mdset$activity <- gsub(counter, CALabel, mdset$activity)
   counter <- counter + 1
 }

mdset$activity <- as.factor(mdset$activity)
mdset$subject <- as.factor(mdset$subject)

tidy = aggregate(mdset, by=list(activity = mdset$activity, subject=mdset$subject), mean)

write.table(tidy, "tidy.txt", sep=" ",row.names=FALSE)
