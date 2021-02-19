#Getting and cleaning data Week 4 Project - run_analysis.R
# Author: Moabelo -TS
# See README.md for datails


#Set working directory
getwd()
setwd("C:/Users/Tumelo/Desktop/data Science/Getting and cleaning data/Week4/Getting and cleaning data week 4 Project")

# Load required packages
library(dplyr)
library(data.table)

# Download the data set and unzip
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
download.file(fileurl, destfile = "C:/Users/Tumelo/Desktop/data Science/Getting and cleaning data/Week4/Getting and cleaning data week 4 Project/Dataset.Zip")
unzip("dataset.zip")


# reading training data
trainingSubjects <- read.table(file.path("UCI HAR Dataset", "train", "subject_train.txt"))
trainingValues <- read.table(file.path("UCI HAR Dataset", "train", "X_train.txt"))
trainingActivity <- read.table(file.path("UCI HAR Dataset", "train", "y_train.txt"))

# read test data
testSubjects <- read.table(file.path("UCI HAR Dataset", "test", "subject_test.txt"))
testValues <- read.table(file.path("UCI HAR Dataset", "test", "X_test.txt"))
testActivity <- read.table(file.path("UCI HAR Dataset", "test", "y_test.txt"))

# read features
features <- read.table(file.path("UCI HAR Dataset", "features.txt"), as.is = TRUE)

# read activity labels
activities <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")



#1. Merge the training and the test sets to create one data set


# combine individual data tables to make one data table and then after remove indididual data tables
humanActivity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)


rm(trainingSubjects, trainingValues, trainingActivity, 
   testSubjects, testValues, testActivity)

# name columns from the combined datatable
colnames(humanActivity) <- c("subject", features[, 2], "activity")



# 2. Extract only the measurements on the mean and standard deviation
#          for each measurement


# Use column name to determine which column to keep 
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))

# ... and keep data in these columns only
humanActivity <- humanActivity[, columnsToKeep]



# 3. Use descriptive activity names to name the activities in the data
#          set


# Substitute activity values with named factor levels

humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])


# 4. Appropriately label the data set with descriptive variable names

# get column names of humanActivity data table
humanActivityCols <- colnames(humanActivity)

# remove special unnecessary characters
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

# Replace abbreviations with full names 
humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

# correct wording
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

# use new labels as column names
colnames(humanActivity) <- humanActivityCols



# 5. Create a second, independent tidy set with the average of each
#          variable for each activity and each subject



humanActivityMeans <- humanActivity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

# output to file "tidy_data.txt"
write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

