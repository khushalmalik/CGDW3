setup working directory 
read dataset X_train into trainf (total number of columns = 561) 
read dataset Y_train (txt dataset with single column) into column 562 of trainf (additional column) 
read subject_train (txt dataset with single column) into column 563 of trainf (additional column) 
read dataset X_test into testf (total number of columns = 561) 
read dataset Y_test (txt dataset with single column) into column 562 of testf 
read dataset subject_test (txt dataset with single column) into column 563 of testf 
read dataset activity_labels into actlbl 
Read dataset features into features Merge the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
keep the subjectID and activity columns remove unnecessary i.e. keeping columns we need Add the column names (features) to mdset create a dataset with average of each variable for each activity and each subject
The mean of activities and subjects are created into a separate tidy data set which is exported into the Project folder as txt file
