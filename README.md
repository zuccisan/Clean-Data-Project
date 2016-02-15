Clean-Data-Project
The files in this repository are for Getting and Cleaning Data Course Project

The R script is in run_analysis.R file and it does the following:

1. Get the required files for analysis if they do not already exist in the working directory
2. Acquire the labels for activities (walking, walking_upstairs, walking_downstairs, sitting, standing and laying) and features (accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ)
3. Load database
4. Merges the training and the test sets to create one data set.
5. Extracts only the measurements on the mean and standard deviation for each measurement.
6. Uses descriptive activity names to name the activities in the data set
7. Appropriately labels the data set with descriptive variable names.
8. Finally create a new dataset based on the refined and combined dataset with the average of each variable for each activity and each subject.
