run_analysis <- function() {
    ## This function does two primary things:
    ## 1.) It merges the training and test sets to create one data set, and 
    ## 2.) Extracts only the measurements on the mean and standard deviation
    ##      for each Measurement.
    
    ## Part 1.) Merge the training and test sets to create one data set
    
    ## Set the working directory
    setwd("~/datasciencecoursera/Getting_and_Cleaning_Data/project")
    
    ## First, collect all of the needed data
    ## Create a subdirectory for the data, if none exists
    if (!file.exists("./data")) {dir.create("./data")}
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    ## Download the zip file, if it doesn't already exist
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
    
    
    ## STEP 1
    ## Merge the training and the test sets to create one data set.
    
    ## Aggregate all training and test data together into a master data.frame 
    ## called "aggr". 
    ## Bind all of the train and test rows together
    aggr <- rbind(X_train, X_test)
    subject_aggr <- rbind(subject_train, subject_test)
    y_aggr <- rbind(y_train, y_test)
    
    ## Bind all of the columns together
    aggr <- cbind(aggr, subject_aggr)
    aggr <- cbind(aggr, y_aggr)
    
    
    ## STEP 2
    ## Extract only the measurements on the mean and standard deviation for 
    ## each measurement.
    
    ## We first need to know which columns contain mean and standard deviation
    ## data. Let's go ahead and lable the subject and activity columns 
    ## appropriately as well.
    
    ## First, I need to remove the redundant column of data in features
    features <- subset(features, select = -c(1) )
       
    features_array <- c(do.call("cbind", features))
    colnames(aggr) <- features_array
    
    ## Label the last to columns "subject" and "activity"
    colnames(aggr)[ncol(aggr)-1] <- c("subject")   
    colnames(aggr)[ncol(aggr)] <- c("activity")

    ## Now, include all columns that are only related to mean and standard 
    ## deviation.
    select_columns <- grepl("mean|std", features_array)
    aggr <- aggr[select_columns == TRUE]
    
    
    
    ## STEP 3
    ## Use descriptive activity names to name the activities in the data set. 
    
    ## The activity names that we want to use are in activity_labels. 
    ## Remove the redundant column.
    activity_labels <- subset(activity_labels, select = -c(1) )
    
    ## Replace the number in the activity column with the matching activity 
    ## description in activity_labels.
    activity_labels_array <- c(do.call("cbind",activity_labels)) 
    activity_labels_array <- tolower(activity_labels_array)
    for (i in 1:nrow(aggr)) {aggr$activity[i] <- activity_labels_array[as.integer(aggr$activity[i])]}
 
    
    ## STEP 4
    ## Appropriately label the data set with descriptive variable names.  
    
    ## The data set aggr already has descriptive variable names; however, I will
    ## improve them a bit for readability
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
    
    
    
    ## STEP 5
    ## From the data set in step 4, create a second, independent tidy data 
    ## set with the average of each variable for each activity and each subject.
    
    ## Create a new tidy data set from the original
    
    ## Need to sort aggr and the activities list first
    sorted_aggr <- arrange(aggr, subject, activity)
    sorted_activities <- sort(activity_labels_array)
    
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
    
    write.table(aggr_mean, file = "aggr_mean.txt", row.names = FALSE) 
    
#     
# #     Step 0: read all the files : listed along with dimensions
# #     
# #     features.txt # 561x2
# #     X_train.txt  # 7352x561
#     X_test.txt  # 2947x561
#     subject_train.txt # 7352x1
#     subject_test.txt # 2947x1
#     Y_train.txt # 7532x1
#     Y_test.txt # 2947x1
#     
#     1. rbind xtrain and xtest  # 10299x561
#     
#     2. filter mean cols # 10299x46
#     
#     3. set table headers using features 
#     
#     5. a) rbind subject train and subject test, and set the subject col names # 10299x1
# 
# b) rbind ytrain with ytest, and set the activity col names  # 10299x1
# 
# c) cbind xtrain mean cols from 2  with ytrain /test from 5b) .   # 10299x47
# 
# cbind the result with subject trains/test from 5a)    # 10299x48
# 
# 4. replace the activity with readable name. (Yes! I did 4 after 5)
# 

}