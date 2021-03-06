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
 * subject_train.txt
 * subject_test.txt
3. Feature files - 'X' prefix files
 * X_test.txt
 * X_train.txt

### Merge the datasets into one dataset
Sample rows of each type of dataset
#### Activty
```
'data.frame':	10299 obs. of  1 variable:
 $ activity: int  5 5 5 5 5 5 5 5 5 5 ...
```

#### Subject
```
'data.frame':	10299 obs. of  1 variable:
 $ subject: int  2 2 2 2 2 2 2 2 2 2 ...
```
 
#### Features
```
'data.frame':	10299 obs. of  561 variables:
 $ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
 $ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 $ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 $ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 $ tBodyAcc-std()-Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
```

#### Combined datasets
```
'data.frame':	10299 obs. of  563 variables:
 $ tBodyAcc-mean()-X                   : num  0.257 0.286 0.275 0.27 0.275 ...
 $ tBodyAcc-mean()-Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ tBodyAcc-mean()-Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 $ tBodyAcc-std()-X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 $ tBodyAcc-std()-Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 $ tBodyAcc-std()-Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
```

### Subset out only the mean and std columns
```
'data.frame':	10299 obs. of  68 variables:
 $ tBodyAcc-mean()-X          : num  0.257 0.286 0.275 0.27 0.275 ...
 $ tBodyAcc-mean()-Y          : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ tBodyAcc-mean()-Z          : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.129
 $ subject                    : int  2 2 2 2 2 2 2 2 2 2 ...
 $ activity                   : int  5 5 5 5 5 5 5 5 5 5 ...
```

### Associate activity names, and relabel columns names with more descriptiive titles
The result is a tidy daset
```
'data.frame':	10299 obs. of  69 variables:
 $ activityNum                                   : int  1 1 1 1 1 1 1 1 1 1 ...
 $ activity                                      : chr  "walking" "walking" "walking" "walking" ...
 $ timeBodyAccelerometer-mean()-X                : num  0.231 0.331 0.376 0.233 0.236 ...
 $ timeBodyAccelerometer-mean()-Y                : num  -0.0177 -0.0185 -0.0247 -0.0345 -0.0144 ...
 $ timeBodyAccelerometer-mean()-Z                : num  -0.122 -0.17 -0.157 -0.105 -0.124 ...
 $ timeBodyAccelerometer-std()-X                 : num  -0.419 -0.145 -0.107 -0.175 -0.21 ...
 $ timeBodyAccelerometer-std()-Y                 : num  -0.13923 -0.09825 0.06609 0.00431 -0.07492 ...
 $ timeBodyAccelerometer-std()-Z                 : num  -0.3862 -0.0239 -0.1973 -0.3154 -0.247 ...
 $ timeGravityAccelerometer-mean()-X             : num  0.965 0.962 0.966 0.965 0.962 ...
 $ timeGravityAccelerometer-mean()-Y             : num  -0.128 -0.12 -0.126 -0.124 -0.119 ...
 $ timeGravityAccelerometer-mean()-Z             : num  0.1084 0.1275 0.0901 0.06 0.0665 ...
```

### Save to file
Save the data to a tab delimited file named: tidydata.txt

 
### Reproducing the Project
0. Review the markdown for how the script works at [run_analysis.md](https://github.com/schuang29/GettingAndCleaningDataProject/blob/master/run_analysis.md)
1. Open the R script `run_analysis.R` using your favorite IDE or text editor
2. Change your workding directory in the script 'setwd()' to be where R script is saved, and save
3. Run the script