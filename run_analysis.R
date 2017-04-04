
#download the file
if(!file.exists("./Course3Week4Assign1")){dir.create("./Course3Week4Assign1")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Course3Week4Assign1/Course3Week4Assign1.zip", mode = "wb")

#unzip the file
unzip("./Course3Week4Assign1/Course3Week4Assign1.zip", exdir = "./Course3Week4Assign1")
    
#get list of files unzipped
path_rf <- file.path("./Course3Week4Assign1" , "UCI HAR Dataset")
path_rf
files<-list.files(path_rf, recursive=TRUE)
files

#1. Merges the training and the test sets to create one data set.

#Read the Activity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
View(dataActivityTest)
View(dataActivityTrain)

#Read the Subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
View(dataSubjectTrain)
View(dataSubjectTest)

#Read Features files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
View(dataFeaturesTest)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
View(dataFeaturesTrain)

#Merge datasets
dataActivity <- rbind(dataActivityTest, dataActivityTrain)
dataSubject <- rbind(dataSubjectTest, dataSubjectTrain)
dataFeatures <- rbind(dataFeaturesTest, dataFeaturesTrain)
View(dataActivity)
View(dataSubject)
View(dataFeatures)

#Name the cols
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
View(dataSubject)
View(dataActivity)
names(dataFeatures)

#combine the subject, activity, and feature data
dataCombine <- cbind(dataSubject, dataActivity)
View(dataCombine)
dim(dataCombine)
dim(dataFeatures)
Data <- cbind(dataFeatures, dataCombine)
View(Data)
dim(Data)
dataTbl <- tbl_df(Data)

#get the list of cols that has mean or std.
#also include subject and activity
subdataFeatureNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
selectedNames <- c(as.character(subdataFeatureNames), "subject", "activity")
selectedNames

#Subset the data fram Data by the cols that have mean or standard
subData <- subset(Data, select = selectedNames)
View(subData)
str(subData)


#Name the activities in the data set
#First get the activity labels
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
setNames(activityLabels, c("activityNum", "activity"))
?setNames
names(activityLabels) <- c("activityNum", "activity")

#set the activity to lowercase
activityLabels$activity <- tolower(activityLabels$activity)

View(activityLabels)
str(activityLabels)


relabeledData <- merge(activityLabels, subData, by.x = "activityNum", by.y = "activity")
View(relabeledData)

#sort
relabeledData <- arrange(relabeledData, subject, activity)


#Label the dataset with descriptive variable names
names(relabeledData)<-gsub("^t", "time", names(relabeledData))
names(relabeledData)<-gsub("^f", "frequency", names(relabeledData))
names(relabeledData)<-gsub("Acc", "Accelerometer", names(relabeledData))
names(relabeledData)<-gsub("Gyro", "Gyroscope", names(relabeledData))
names(relabeledData)<-gsub("Mag", "Magnitude", names(relabeledData))
names(relabeledData)<-gsub("BodyBody", "Body", names(relabeledData))
names(relabeledData)


#From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and 
#each subject.
library(plyr)
AveragedData<-aggregate(. ~subject + activity, relabeledData, mean)
AveragedData<-AveragedData[order(AveragedData$subject,AveragedData$activity),]
View(AveragedData)
write.table(AveragedData, file = "tidydata.txt",row.name=FALSE)



