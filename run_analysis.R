library (dplyr)

# Check to see if files have been downloaded
file_name <- "UCI HAR Dataset"
if (!file.exists(file_name)){
  file_source <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(file_source, "source_file.zip", method="curl")
  unzip("source_file.zip")
}  

# Load activity_labels and features
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])
features_needed <- grep(".*mean.*|.*std.*", features[,2])
features_needed_names <- features[features_needed,2]

# Load datasets
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt")
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt")

# Merges the training and the test sets to create one data set
subject_combined <- rbind(subjectTrain, subjectTest)
activity_combined <- rbind(activityTrain, activityTest)
features_combined <- rbind(featuresTrain, featuresTest)
combined_data <- cbind(subject_combined, activity_combined, features_combined)

# Extracts only the measurements on the mean and standard deviation for each measurement
combined_data_refined <- combined_data[,c(1, 2, features_needed+2)]

# Uses descriptive activity names to name the activities in the data set
combined_data_refined[,2] <- factor(combined_data_refined[,2], levels = activitylabels[,1], labels = activitylabels[,2])

# Appropriately labels the data set with descriptive variable names
names(combined_data_refined) <- c("subject", "activity", features_needed_names)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
new_tidy_table <- group_by(combined_data_refined, subject, activity) %>%
summarise_each (funs(mean)) %>%
write.table("tidy.txt", row.names = FALSE, quote = FALSE)
