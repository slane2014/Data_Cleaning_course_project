## README file for the Getting and Cleaning Data course project

This document is the README file for the Getting and Cleaning Data course project. It 
contains:
<ol><li>Details of the course project problem statement</li>
<li>A description of the documents included in the GitHub folder</li>
<li>A detailed description of what the run_analysis.R script is doing</li>
</ol>

### Problem Statement

The purpose of this project is to demonstrate your ability to collect, work with, and 
clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
You will be graded by your peers on a series of yes/no questions related to the project. 
You will be required to submit:
<ol><li>a tidy data set as described below,</li>
<li>a link to a Github repository with your script for performing the analysis, and </li>
<li>a code book that describes the variables, the data, and any transformations or work that you performed to 
clean up the data called CodeBook.md. </li></ol>
You should also include a README.md in the repo 
with your scripts. This repo explains how all of the scripts work and how they are 
connected. 


One of the most exciting areas in all of data science right now is wearable 
computing - see for example
http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/. 

<br>
Companies like Fitbit, Nike, and Jawbone Up 
are racing to develop the most advanced algorithms to attract new users. The data linked 
to from the course website represent data collected from the accelerometers from the 
Samsung Galaxy S smartphone. A full description is available at the site where the data 
was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
 
This R script, called run_analysis.R, does the following:
<ol><li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement. </li>
<li>Uses descriptive activity names to name the activities in the data set.</li>
<li>Appropriately labels the data set with descriptive variable names. </li>
<li>From the data set in step 4, creates a second, independent tidy data set with the 
   average of each variable for each activity and each subject.</li>
</ol>

### Documents included

This GitHub repository is located at [https://github.com/slane2014/Data_Cleaning_course_project](https://github.com/slane2014/Data_Cleaning_course_project).
It contains three documents:
<ol><li>This README file, README.md.</li>
<li>A code book that describes the data that was used and created in this assignment, CodeBook.md.</li>
<li>The script that takes the raw data and performs the five steps described in
the Problem Statement section, run_analysis.R. </li>
</ol>

### Description of solution as programming in run_analysis.R

This R script, run_analysis.R, performs the five steps described in the Problem Statement
section in the listed order. I have described the details in each of these five steps 
below.

Before the first step can be performed, the working directory is set, the data is 
downloaded from the online data resposity, the data is unzipped in place, and the data
files are read into memory for the R program to use.

run_analysis.R script creates a data frame, called aggr, that follows the data design
structure described [here](https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369).
        
The following raw files are read into the following data frames, listed by name:         
<ul><li>X_test: "UCI HAR Dataset/test/X_test.txt"</li>
<li>y_test: "UCI HAR Dataset/test/y_test.txt"</li>
<li>X_train: "UCI HAR Dataset/train/X_train.txt"</li>
<li>y_train: "UCI HAR Dataset/train/y_train.txt"</li>
<li>subject_test: "UCI HAR Dataset/test/subject_test.txt"</li>
<li>subject_train: "UCI HAR Dataset/train/subject_train.txt"</li>
<li>features: "UCI HAR Dataset/features.txt"</li>
<li>activity_labels: "UCI HAR Dataset/activity_labels.txt"</li>
</ul>

The following steps describe the five sections within run_analysis.R that correspond to the
five requirements of this programming assignment.

##### STEP 1
Step 1 merges the training and the test sets to create one data set. It aggregates all 
training and test data together into a data.frame, called aggr. The step also binds all 
of the train and test rows together using several rbind commands. It also binds all of 
the columns together using several cbind commands. The result of STEP 1 is a 10299 x 563 
data frame, called aggr.

##### STEP 2
Step 2 extracts only the measurements on the mean and standard deviation for each 
measurement. It first needs to know which columns contain mean and standard deviation
data.  We also label the subject and activity columns appropriately as well.
    
First, we remove the redundant column of data in "features". We then set the aggr column 
names to the labels in "features". We label the last two columns "subject" and "activity".
Next, we include all columns that are ONLY related to mean and standard. For this project, 
we are assuming that all variables that contain the string "mean" are mean variables and 
variables that contain the string "std" are standard deviation variables. The result of 
STEP 2 is a 10299 x 81 data frame, called aggr, that contains only the mean and standard 
deviation data.
    
##### STEP 3
Step 3 uses descriptive activity names to name the activities in the data set. The activity 
names that we want to use are in "activity_labels". 

First, we remove the redundant column of data in activity_labels. Next, we replace the 
number in the activity column with the matching activity. We also reduce the text to lower 
case to better match the case used in variable names. The result of STEP 3 is a 10299 x 81 
data frame, called aggr, with descriptive activity names.
    
##### STEP 4
Step 4 appropriately labels the data set with descriptive variable names.  The data set 
aggr already has descriptive variable names; however, this step improves the labels a bit 
for readability and consistency.

First, we remove the open and close parenthesis in the variable names. The use of 
parenthesis in variable names can be confusing since this is typical syntax for functions.
Next, we next replace the comma in the ",gravity..." string with a dash "-gravity...". The 
comma is used to describe the rance in some of the variables, such 
as fBodyAcc-bandsEnergy()-1,8. Next, the string "BodyBody" appears in some variable names, 
so we change these occurrences to "Body". Finally, for variables that start with a "f" or
"t", we replace these strings with "frequency" and "time", respectively. The result of STEP 4 
is a 10299 x 81 data frame, called aggr, with cleaned and descriptive variable names.     
    
##### STEP 5
From the data set in step 4, step 5 creates a second, independent tidy data 
set with the average of each variable for each activity and each subject.
    
First, we sort the aggr and activities lists. This ensures that we are collecting the 
correct raw data as we calculate the mean for each subject and activity. Next, we create 
a new tidy data set, called aggr_mean. We iterate through the data in aggr, selecting only
sections of aggr that correspond to each subject and activity. We average each of the sets of
variables by using the lapply() function and then bind it to aggr_mean using the rbind
command. Finally, we set our column names to aggr_mean. We have 30 subjects that each
perform 6 activities, so we expect aggr_mean to have 30 * 6 = 180 observations, each
observation containing the averaged measurements.
    
The result of STEP 5 is a 180 x 81 data frame, called aggr_mean, that contains
a mean of each variable for each activity and subject.

Finally, the script needs to output aggr_mean data frame to a text file. It creates a 
text file called "aggr_mean.txt" in the folder where the run_analysis.R file is located.


