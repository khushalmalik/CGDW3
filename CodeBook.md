trainf stores the X_train.txt + subject_train + X_test files data (total number of columns = 561 +1+1 = 563)
testf stores the X_test + Y_test + subject_test files data (total number of columns = 561 +1+1 = 563)
actlbl stores activity_labels.txt file data
features stores features.txt file data

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
Status API Training Shop Blog About Help

