#uses sqldf and dplyr packages.
library(sqldf)
library(dplyr)
#Merges the training and the test sets to create one data set.
# Set Filename and URL
filename<-"dataset.zip"
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Download and Unzip the File
download.file(url,filename)
#unzip("dataset.zip")

#Set Working Directory
setwd("UCI HAR Dataset")

#Read Training Dataset
s_trn <- read.table("train/subject_train.txt")
x_trn <- read.table("train/X_train.txt")
y_trn <- read.table("train/y_train.txt")

#Read Test Dataset
s_tst <- read.table("test/subject_test.txt")
x_tst <- read.table("test/X_test.txt")
y_tst <- read.table("test/y_test.txt")

#Read Descriptive Name in Features
feat<-read.table("features.txt")
features<-as.character(feat[,2])

#Read Activity Labels 
act<-read.table("activity_labels.txt")

#Lookup y_test and y_train values in activity_labels using sqldf package
#Uses descriptive activity names to name the activities in the data set
library(sqldf)
y_train<-sqldf("select act.V2 from y_trn left join act on y_trn.V1=act.V1")
y_test<-sqldf("select act.V2 from y_tst left join act on y_tst.V1=act.V1")

#Merges the training and the test sets to create one data set
train_all<-cbind(s_trn,y_train,x_trn)
test_all<-cbind(s_tst,y_test,x_tst)
all_data<-rbind(train_all,test_all)

names(all_data)<-c("subject_id","activity_name",features)

#Extracts only the measurements on the mean and standard deviation for each measurement.

feat_columns <- grep(".*Mean.*|.*Std.*", names(all_data), ignore.case=TRUE)
new_alldata <- all_data[,c( 1, 2,feat_columns)]

#Appropriately labels the data set with descriptive variable names
names(new_alldata)<-gsub("Acc", "Accelerometer", names(new_alldata))
names(new_alldata)<-gsub("BodyBody", "Body", names(new_alldata))
names(new_alldata)<-gsub("Gyro", "Gyroscope", names(new_alldata))
names(new_alldata)<-gsub("Mag", "Magnitude", names(new_alldata))
names(new_alldata)<-gsub("^t", "Time", names(new_alldata))
names(new_alldata)<-gsub("^f", "Frequency", names(new_alldata))
names(new_alldata)<-gsub("tBody", "TimeBody", names(new_alldata))
names(new_alldata)<-gsub("-mean()", "Mean", names(new_alldata), ignore.case = TRUE)
names(new_alldata)<-gsub("-std()", "STD", names(new_alldata), ignore.case = TRUE)
names(new_alldata)<-gsub("-freq()", "Frequency", names(new_alldata), ignore.case = TRUE)
names(new_alldata)<-gsub("angle", "Angle", names(new_alldata))
names(new_alldata)<-gsub("gravity", "Gravity", names(new_alldata))

#From the data set above(new_alldata), creates a second, independent tidy data set with the average of each variable for each activity and each subject.
all_tidy <- new_alldata %>%
  group_by(subject_id, activity_name) %>%             
  summarize_all(mean) 

#Generate tidy file
write.table(file="all_tidy.txt", all_tidy, row.names = FALSE)
