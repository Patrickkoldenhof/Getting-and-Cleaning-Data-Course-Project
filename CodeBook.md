# Code Book
This file contains the code book for the run_analysis.R file. This assignment is done as a part of the Getting and Cleaning Data Course Project. 

## Stepwise code guide
1. Dataset downloaded 
    Dataset is extracted and unzipped in the folder UCI HAR Datset
    
2. Each datafile is assigned to a variable with the read.table() function and a dataframe is made accordingly with the data.frame() function
    Features = Features.txt - Columnnames = n and features
    X_test = X_test.txt - Columnnames = features accesed from Features 
    Y_test = Y_test.txt - Columnnames = labels
    Subject_test = subject_test.txt - Columnames = subjects 
    test_dataframe = A dataframe of X_test, Y_test and Subject_test
    X_train = X_train.txt - Columnnames = features accesed from Features
    Y_train = Y_train.txt - Columnnames = labels
    Subject_train = subject_train.txt - Columnames = subjects 
    train_dataframe = A dataframe of X_train, Y_train and Subject_train

3. Datasets are merged using the rbind() function
    Obtained: Mergeddataset = train_dataframe & test_dataframe 

4. Only the measurements on the mean and the standard deviation are obtained with the select function of the dplyr package
   Select only the columns: subjects, labels and columns that contain the word mean or std
   Obtained: Mean_STD_data

5. Descriptive names from the activities dataset are used to name the activities in the datset using the merge() and the select() function
    First the activities dataset is loaded:
    activities = activity_labels.txt - Columnnames = labels and activity
    Both the datasets are merged based on the columnname labels, after which the labels column is removed by using the selec function()
    Obtained: Joinedset
    
6. The columns are appropriately labeled using the gsub() function
   t at the beginning becomes Time
   Freq becomes Frequency
   f at the beginning becomes Frequency
   -freq becomes Frequency
   () is removed
   Acc becomes Accelerometer
   Gyro becomes Gyroscope
   .mean becomes Mean
   .std becomes STD
   Mag becomes Magnitude
   BodyBody becomes Body
   angle becomes Angle
   gravity becomes Gravity
   subject becomes Subjects
   activity becomes Activity
   .tBody becomes TimeBody
   ...X becomes X
   ...Y becomes Y
   ...Z becomes Z
   Obtained: Final_dataset
   
7. The tidydataset with the average of each variable for each activity and subject is generated with the group_by() function and the summarise() function
   The dataset is written in a table called Tidy_set_PatrickKoldenhof 
   Obtained: Tidy_dataset & Tidy_set_PatrickKoldenhof.txt 

## Data in R
Activities: 6obs of 2 variables
Features: 561obs of 2 variables
Final_dataset: 10299obs of 88 variables
joinedset: 10299obs of 88 variables
Mean_STD_data: 10299obs of 88 variables
Mergeddataset: 10299obs of 88 variables
subject_test: 2947obs of 1 variable
subject_train: 7352obs of 1 variable
test_dataframe: 2947obs of 563 variables
Tidy_dataset: 180obs of 88 variables
train_dataframe: 7352obs of 563 variables
X_test: 2947obs of 561 variables
X_train: 7352obs of 561 variables
Y_test: 2947obs of 1 variable
Y_train: 7352obs of 1 variable

## Variables
Below you can find all the measured variables 
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these values are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.  

For the purpose of this course only the mean() and the std() were used
 
   
