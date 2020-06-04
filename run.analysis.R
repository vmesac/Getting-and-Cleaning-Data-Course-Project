#load dplyr library
library(dplyr)

#-----------------------
#Download and unzip file:
#-----------------------

file <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, file, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}
#----------------------------------
#Read data and change column names:
#----------------------------------

#Reading features info and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))

#Reading test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "id")

#reading train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "id")

#--------------------------------------------------------------
# Merge the training and the test sets to create one data set:
#--------------------------------------------------------------

#bind test table
test<-cbind(subject_test, x_test, y_test)

#bind train table
train<-cbind(subject_train, x_train, y_train)

#Merging both tables
DataSet<-rbind(test, train)

#----------------------------------------------------------------------------------------
# Extract only the measurements on the mean and standard deviation for each measurement:
#----------------------------------------------------------------------------------------

DataSet_2 <- select(DataSet, subject, id, contains("mean"), contains("std"))

#-----------------------------------------------------------------------
# Use descriptive activity names to name the activities in the data set:
#-----------------------------------------------------------------------

DataSet_2$code <- activities[DataSet_2$id, 2]

#------------------------------------------------------------------
#Appropriately labels the data set with descriptive variable names:
#------------------------------------------------------------------

names(DataSet_2)[2] = "activity"
names(DataSet_2)<-gsub("Acc", "Accelerometer", names(DataSet_2))
names(DataSet_2)<-gsub("Gyro", "Gyroscope", names(DataSet_2))
names(DataSet_2)<-gsub("BodyBody", "Body", names(DataSet_2))
names(DataSet_2)<-gsub("Mag", "Magnitude", names(DataSet_2))
names(DataSet_2)<-gsub("^t", "Time", names(DataSet_2))
names(DataSet_2)<-gsub("^f", "Frequency", names(DataSet_2))
names(DataSet_2)<-gsub("tBody", "TimeBody", names(DataSet_2))
names(DataSet_2)<-gsub("-mean()", "Mean", names(DataSet_2))
names(DataSet_2)<-gsub("-std()", "STD", names(DataSet_2))
names(DataSet_2)<-gsub("-freq()", "Frequency", names(DataSet_2))
names(DataSet_2)<-gsub("angle", "Angle", names(DataSet_2))
names(DataSet_2)<-gsub("gravity", "Gravity", names(DataSet_2))

str(DataSet_2)

#-----------------------------------------------------------------------------------------------------------------
#creates a second, independent tidy data set with the average of each variable for each activity and each subject:
#-----------------------------------------------------------------------------------------------------------------

#the independent dataset will be called DataSet_3
DataSet_3<-DataSet_2 %>% group_by(subject, activity) %>% 
summarise_all(funs(mean))


dim(dataSet_3)
str(DataSet_3)
head(DataSet_3)

#export final DataSet
write.table(DataSet_3, file = "tidyDataset.txt")



