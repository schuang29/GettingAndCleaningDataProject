CodeBook
===========
This is the code book that describes the variables, data, and any transformations or work that was performed to tidy the source dataset.

## Data Source
Description and details of the data set
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Files
[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## The Tidying Process

### Sourcing the data
1. Create a local folder to receive the data
2. Define the url source of the dataset, and download the file
3. Unzip the downloaded file to the target data folder

### Inspect the data files
The relevant data for this project can be found in three type of files
1. Activity Files - 'Y' prefix files
 * Y_test.txt
 * Y_train.txt
2. Subject Files - 'subject' prefix files
3. Feature files - 'X' prefix files


1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Project Outputs
* Tidy dataset file `tidydata.txt`

### Reproducing the Project
1. Open the R script `run_analysis.R` using your favorite IDE or text editor
2. Change your workding directory to be where R script is saved, and save
3. Run the script