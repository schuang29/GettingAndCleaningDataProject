run_analysis
===========
This is the walk through of the script

## Set Up Environment
### Load required packages
```R
library(plyr)
```

### Create folder structure
```R
if(!file.exists("./Course3Week4Assign1")){dir.create("./Course3Week4Assign1")}
```

## Source the data
### Download file
```R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Course3Week4Assign1/Course3Week4Assign1.zip", mode = "wb")
```
### Unzip
```R
unzip("./Course3Week4Assign1/Course3Week4Assign1.zip", exdir = "./Course3Week4Assign1")
```

## Inspect the data
Define path to get to the data files we're interested in
```R
path_rf <- file.path("./Course3Week4Assign1" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
```
There are three types of data sets, and we merge each respectively
1. Activity Files - 'Y' prefix files
2. Subject Files - 'subject' prefix files
3. Feature files - 'X' prefix files

## Load the data to begin process
### Load Activity Files, test and train
```R
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
```
### Load Subject Files, test and train
```R
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
```
### Load Feature Files, test and train
```R
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
```

## Combine respective datasets by type
Activity by activity, Subject by subject, and Features by features
```R
dataActivity <- rbind(dataActivityTest, dataActivityTrain)
dataSubject <- rbind(dataSubjectTest, dataSubjectTrain)
dataFeatures <- rbind(dataFeaturesTest, dataFeaturesTrain)

## Name the column headers
```R
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2
```

## Combine the datasets all into one table
The approach is to merge two first, and then merge the result with the last dataset
```R
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)
```

## Create a working dataset that has only the Average and Standard Deviation columns
Any column names that have the text 'mean' or 'std' in them
### Identify the interested columns
```R
subdataFeatureNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
```
### Include Subject and Activity
We need them as the key for the measures
```R
selectedNames <- c(as.character(subdataFeatureNames), "subject", "activity")
```
### Source only the interested columns
```R
subData <- subset(Data, select = selectedNames)
```

### Attribute the Activity
Activity is currently represented as a numeric. It would be more valuable to represent as the textual description.
Source activity labels, set to lower case for consistency, and replace in the dataset
```R
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
setNames(activityLabels, c("activityNum", "activity"))
names(activityLabels) <- c("activityNum", "activity")
activityLabels$activity <- tolower(activityLabels$activity)
```
Merge the description of the label with the tidy dataset
```R
relabeledData <- merge(activityLabels, subData, by.x = "activityNum", by.y = "activity")
```
Sort the dataset by subject and activity
```R
relabeledData <- arrange(relabeledData, subject, activity)
```

## Improve the attribution the Mean and Standard Dev columns
* time
* frequency
* accelerometer
* gyro
* magnitude
* body

```R
names(relabeledData)<-gsub("^t", "time", names(relabeledData))
names(relabeledData)<-gsub("^f", "frequency", names(relabeledData))
names(relabeledData)<-gsub("Acc", "Accelerometer", names(relabeledData))
names(relabeledData)<-gsub("Gyro", "Gyroscope", names(relabeledData))
names(relabeledData)<-gsub("Mag", "Magnitude", names(relabeledData))
names(relabeledData)<-gsub("BodyBody", "Body", names(relabeledData))
```

## Create tidy dataset that is the average of averages and std
Summarize by subject and activity
```R
AveragedData<-aggregate(. ~subject + activity, relabeledData, mean)
AveragedData<-AveragedData[order(AveragedData$subject,AveragedData$activity),]
```

## Save the dataset to a file
```R
write.table(AveragedData, file = "tidydata.txt",row.name=FALSE)
```