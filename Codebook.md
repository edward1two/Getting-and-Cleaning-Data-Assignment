## The Data:


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The Variables and Transformations


# Installation of required packages

# Set Filename and URL based on the given link

# Download and Unzip the File

# Set Working Directory

# Read Training Dataset
s_trn <- Reads the subject train file in table format and creates a data frame
x_trn <- Reads the x train file in table format and creates a data frame
y_trn <- Reads the y train file in table format and creates a data frame


# Read Test Dataset
s_tst <- Reads the subject test file in table format and creates a data frame
x_tst <- Reads the x test file in table format and creates a data frame
y_tst <- Reads the y test file in table format and creates a data frame

# Read Descriptive Name in Features
feat <- Reads the features file in table format and creates a data frame
features <- convert the descriptive name into character

# Read Activity Labels 
act <- Reads the activity file in table format and creates a data frame

# Lookup y_test and y_train values in activity_labels using sqldf package
# Uses descriptive activity names to name the activities in the data set

# Merge Test and Train Dataset
train_all <- combines s_trn,y_train, and x_trn by columns
test_all <- combines s_tst,y_test, and x_tst  by columns
all_data < -combines train_all and test_all by rows

# Add labels subject_id ,activity_name ,and features to all_data

# Extracts only the measurements on the mean and standard deviation for each measurement.
feat_columns <- Extracts only the measurements on the mean and standard deviation
new_alldata <- feat_columns combines with subject_id and activity_name

# Appropriately labels the data set with descriptive variable names
Change "Acc" to  "Accelerometer"
Change "BodyBody" to "Body"
Change "Gyro" to "Gyroscope"
Change "Mag" to "Magnitude"
Change "^t" to "Time"
Change "^f" to "Frequency"
Change "tBody" to "TimeBody"
Change "-mean()" to "Mean"
Change "-std()" to "STD"
Change "-freq()" to "Frequency"
Change "angle" to "Angle"
Change "gravity" to "Gravity"

# From the data set abouve, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
all_tidy <-  tidy data set with the average of each variable for each activity and each subject.


# Write the tidy data set into a file
