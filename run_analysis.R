##This is the Rscript for the Getting and Cleaning Data course project
## Author = Patrick Koldenhof 

## First step is to download the zip file and to unzip the data in my
## working directory

fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "UCI HAR Dataset.zip", mode = "wb" )
unzip("UCI HAR Dataset.zip")

##check if files indeed have been unzipped
setwd("UCI HAR Dataset")
list.files()

##Now it is time to load the files into Rstudio. I will use the read.table function
##and assign all headers to be FALSE (I will name the columnnames later) 
##First the Features
Features <- read.table("features.txt", sep = " ", header = FALSE)
colnames(Features) <- c("n", "features")

##Then the test data
X_test <- read.table("./test/X_test.txt", header = FALSE)
colnames(X_test) <- Features$features
Y_test <- read.table("./test/y_test.txt", header = FALSE)
colnames(Y_test) <- "labels"
subject_test <- read.table("./test/subject_test.txt", header = FALSE)
colnames(subject_test) <- "subjects"

## Lets create a dataframe of the testdata. I think the names are okay.
test_dataframe <- data.frame(subject_test, Y_test, X_test)

##Then the train data 
X_train <- read.table("./train/X_train.txt", header = FALSE)
colnames(X_train) <- Features$features
Y_train <- read.table("./train/y_train.txt", header = FALSE)
colnames(Y_train) <- "labels"
subject_train <- read.table("./train/subject_train.txt", header = FALSE)
colnames(subject_train) <- "subjects"

##Creating a dataframe of the traindata. 
train_dataframe <- data.frame(subject_train, Y_train, X_train)

##.1 Merge the training and the test sets to create one dataset 
Mergeddataset <- rbind(train_dataframe, test_dataframe)

##.2 Extracts only the measurements on the mean and standard deviation for each measurement
## I use the dplyr package, but I believe grepl will work just as well
library(dplyr)
Mean_STD_data <- Mergeddataset %>% select(subjects, labels, contains("mean"), contains ("std"))
View(Mean_STD_data)

##.3 Use descriptive activity names to name the activities in the dataset 
## What you want is renaming the "labels" column 
##First I read the activity_labels set, then i join the datasets on labels.
## Finally I remove the labels column (Can be done much easier I think, but it totally works)
activities <- read.table("activity_labels.txt", header = FALSE)
colnames(activities) <- c("labels", "activity")
joinedset <- merge(activities, Mean_STD_data, by = "labels")
joinedset <- joinedset %>% select(subjects, activity, contains("mean"), contains ("std"))

##.4 Appropriately label the data set with descriptive variable names.
## Renaming the columnnames with the gsub function
renamed <- names(joinedset)
renamed <- gsub("^t", "Time", renamed)
renamed <- gsub("Freq", "Frequency", renamed)
renamed <- gsub("^f", "Frequency", renamed)
renamed <- gsub("-freq", "Frequency", renamed)
renamed <- gsub("()", "", renamed)
renamed <- gsub("Acc", "Accelerometer", renamed)
renamed <- gsub("Gyro", "Gyroscope", renamed)
renamed <- gsub(".mean", "_Mean_", renamed)
renamed <- gsub(".std", "_STD_", renamed)
renamed <- gsub("Mag", "Magnitude", renamed)
renamed <- gsub("BodyBody", "Body", renamed)
renamed <- gsub("angle", "Angle", renamed)
renamed <- gsub("gravity", "Gravity", renamed)
renamed <- gsub("subjects", "Subjects", renamed)
renamed <- gsub("activity", "Activity", renamed)
renamed <- gsub(".tBody", "TimeBody", renamed)
renamed <- gsub("...X", "X", renamed)
renamed <- gsub("...Y", "Y", renamed)
renamed <- gsub("...Z", "Z", renamed)
##Final step is renaming it back
names(joinedset) <- renamed
Final_dataset <- joinedset

##5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
## Using a combination of the group_by function and the summarize function
## this is done very easily

Tidy_dataset <- Final_dataset %>% group_by(Subjects, Activity) %>% summarise_all(mean)
write.table(Tidy_dataset, "Tidy_set_PatrickKoldenhof.txt", row.names = FALSE)


##This is the end of the script. In the repository you find a codebook and a README.md.




