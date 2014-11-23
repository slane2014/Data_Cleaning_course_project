run_analysis <- function() {

    ## This R script, called run_analysis.R, does the following:
    ## 1.) Merges the training and the test sets to create one data set.
    ## 2.) Extracts only the measurements on the mean and standard deviation for each 
    ##      measurement. 
    ## 3.) Uses descriptive activity names to name the activities in the data set.
    ## 4.) Appropriately labels the data set with descriptive variable names. 
    ## 5.) From the data set in step 4, creates a second, independent tidy data set with the 
    ##      average of each variable for each activity and each subject.
    
    ## This R script performs these steps in the order described above.

    ## Before the first step can be performed, the working directory is set, the data is 
    ## downloaded from the data resposity, the data is unzipped in place, and the data
    ## files are read into memory for the R program to use.

    ## This R script creates a data frame, called aggr, that follows the data design
    ## structure described here: 
    ## https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369
        
    ## Set the working directory
    setwd("~/datasciencecoursera/Getting_and_Cleaning_Data/project")
    
    ## Create a subdirectory for the data, if none exists
    if (!file.exists("./data")) {dir.create("./data")}
    
    ## Assign the URL to the location of the data 
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    ## Download and time stamp the zip file, if it doesn't already exist
    if (!file.exists("./data/Dataset.zip")) {
        download.file(fileURL, destfile="./data/Dataset.zip", method="curl", temp)
        dateDownloaded <- date()
        dateDownloaded
    }
    ## Unzip the package in place
    unzip("./data/Dataset.zip", overwrite = TRUE, exdir = "./data/")
    
    ## Read raw data files into memory
    X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
    y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")

    X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
    
    subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
    subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
    features <- read.table("data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
    
    
    ## =================================================================================
    ## STEP 1
    ## 1.) Merge the training and the test sets to create one data set.
    
    ## Aggregate all training and test data together into a data.frame.
    ## Bind all of the train and test rows together using several rbind commands
    aggr <- rbind(X_train, X_test)
    subject_aggr <- rbind(subject_train, subject_test)
    y_aggr <- rbind(y_train, y_test)
    
    ## Bind all of the columns togetherusing several cbind commands
    aggr <- cbind(aggr, subject_aggr)
    aggr <- cbind(aggr, y_aggr)
    
    ## The result of STEP 1 is a 10299 x 563 data frame, called aggr.
    
    
    ## =================================================================================
    ## STEP 2
    ## Extract only the measurements on the mean and standard deviation for 
    ## each measurement.
    
    ## We first need to know which columns contain mean and standard deviation
    ## data. For this project, we are assuming that all variables that contain the string
    ## "mean" are mean variables and variables that contain the string "std" are standard
    ## deviation variables. We also label the subject and activity columns 
    ## appropriately as well.
    
    ## First, remove the redundant column of data in features
    features <- subset(features, select = -c(1) )
       
    ## Set the aggr column names to the labels in features.txt    
    features_array <- c(do.call("cbind", features))
    colnames(aggr) <- features_array
    
    ## Label the last two columns "subject" and "activity"
    colnames(aggr)[ncol(aggr)-1] <- c("subject")   
    colnames(aggr)[ncol(aggr)] <- c("activity")

    ## Now include all columns that are only related to mean and standard 
    ## deviation
    select_columns <- grepl("mean|std", features_array)
    aggr <- aggr[select_columns == TRUE]
    
    ## The result of STEP 2 is a 10299 x 81 data frame, called aggr, that contains
    ## only the mean and standard deviation data.
    
    
    ## ================================================================================   
    ## STEP 3
    ## Use descriptive activity names to name the activities in the data set. 
    
    ## The activity names that we want to use are in activity_labels.txt.
    ## Remove the redundant column
    activity_labels <- subset(activity_labels, select = -c(1) )
    
    ## Replace the number in the activity column with the matching activity. 
    ## description in activity_labels. We also reduce the text to lower case to better
    ## match the variable text.
    activity_labels_array <- c(do.call("cbind",activity_labels)) 
    activity_labels_array <- tolower(activity_labels_array)
    for (i in 1:nrow(aggr)) {aggr$activity[i] <- activity_labels_array[as.integer(aggr$activity[i])]}
 
    ## The result of STEP 3 is a 10299 x 81 data frame, called aggr, with descriptive 
    ## activity names.
    
    
    ## ================================================================================   
    ## STEP 4
    ## Appropriately label the data set with descriptive variable names.  
    
    ## The data set aggr already has descriptive variable names; however, I will
    ## improve them a bit for readability.
    ## Remove the parenthesis in the variable names
    names(aggr) <- gsub("\\(", "", names(aggr),)    
    names(aggr) <- gsub("\\)", "", names(aggr),)
    
    ## Replace the comma in the ",gravity..." string with a dash "-gravity..." 
    names(aggr) <- gsub(",gravity", "-gravity", names(aggr),)
    
    ## Remove the double word "BodyBody" and replace with one "Body" 
    names(aggr) <- gsub("BodyBody", "Body", names(aggr),)
    
    ## Replace the 't' or 'f' prefix with "time" or "force", respectively 
    names(aggr) <- gsub("tG", "timeG", names(aggr))    
    names(aggr) <- gsub("tB", "timeB", names(aggr))
    names(aggr) <- gsub("fB", "forceB", names(aggr))
    
    # Save the column names of the reduced data set for later use
    select_names <- names(aggr)
    
    ## The result of STEP 4 is a 10299 x 81 data frame, called aggr, with cleaned and
    ## descriptive variable names.     
    
       
    ## ================================================================================   
    ## STEP 5
    ## From the data set in step 4, create a second, independent tidy data 
    ## set with the average of each variable for each activity and each subject.
    
    ## Sort aggr and activities list first. This ensures that we are collecting the 
    ## correct raw data as we calculate the mean for each subject and activity.
    sorted_aggr <- arrange(aggr, subject, activity)
    sorted_activities <- sort(activity_labels_array)
    
    ## Create a new tidy data set from the original
    aggr_mean = data.frame()
    for (i in 1:30) {
        for (j in seq_along(sorted_activities)) {
            aggr_for_subject_activity <- aggr[(aggr$subject == i & aggr$activity == sorted_activities[j]),]
            size <- ncol(aggr_for_subject_activity)
            means <- lapply(aggr_for_subject_activity[1:(size-2)], mean)
            temp <- data.frame(i, sorted_activities[j], means, stringsAsFactors = FALSE)
            aggr_mean <- rbind(aggr_mean, temp)
        }
    }
    ## Set column names to new data set
    colnames(aggr_mean) <- c("subject","activity", select_names[1:(size-2)])
    
    ## The result of STEP 5 is a 180 x 81 data frame, called aggr_mean, with that contains
    ## a mean of each variable for each activity and subject.


    ## ================================================================================   

    ## Write the aggr_mean data frame out to a text file for posting to Coursera
    write.table(aggr_mean, file = "aggr_mean.txt", row.names = FALSE) 

}