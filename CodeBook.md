## CodeBook for the Getting and Cleaning Data course project

This document is the CodeBook file for the Getting and Cleaning Data course project. It 
contains details related to the raw data that is both read and written by run_analysis.R.

### Data details and dictionary for the course project
This section contains a list of the variables, the data, and any transformations or work 
that was performed to clean up the data. See the README.md file for details of what the
script does with the data at each step. run_analysis.R script creates a data frame that 
follows the data design structure described [here](https://class.coursera.org/getdata-009/forum/thread?thread_id=58#comment-369).

The script run_analysis.R was created read the raw data, conduct data analysis and transformation,
and output the averaged data as required. 

The script downloaded the online zip file located 
at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
It read in only a subset of the raw data listed by name:         
<ul><li>X_test: "UCI HAR Dataset/test/X_test.txt"</li>
<li>y_test: "UCI HAR Dataset/test/y_test.txt"</li>
<li>X_train: "UCI HAR Dataset/train/X_train.txt"</li>
<li>y_train: "UCI HAR Dataset/train/y_train.txt"</li>
<li>subject_test: "UCI HAR Dataset/test/subject_test.txt"</li>
<li>subject_train: "UCI HAR Dataset/train/subject_train.txt"</li>
<li>features: "UCI HAR Dataset/features.txt"</li>
<li>activity_labels: "UCI HAR Dataset/activity_labels.txt"</li>
</ul>
No inertial signal data was read or used by this script.


The output of the script is a text file of the average values by subject and activity. It is
a 180 x 81 data frame that contains an average of each variable for each activity and subject. 

The first column title of the resultant data frame is "subject" which contains a number from 1 to 30
that corresponds to each specific subject in this study. The second column title is "activity"
which contains an activity name from the list below:
<ul><li>laying</li>
<li>sitting</li>
<li>standing</li>
<li>walking</li>
<li>walking_downstairs</li>
<li>walking_upstairs</li>
</ul>
These activities have been converted from upper case to lower case to better match the case
used in the variable strings.
Each subject has data that corresponds to each of these activities. Since there are 30 subjects
and 6 activities, there are exactly (6 * 30) 180 rows of data. 

The remaining 79 columns correspond to the 79 data that are averaged for each subject/activity 
pair. Those 79 variables are the subset of total 561 variables that contain mean and standard 
deviation variables. For this project, we assume that all variables that contain the string
"mean" are mean variables and variables that contain the string "std" are standard
deviation variables. The 79 variables included in the final text data file are, in order:
<ul><li>timeBodyAcc-mean-X</li>
<li>timeBodyAcc-mean-Y </li>
<li>timeBodyAcc-mean-Z </li>
<li>timeBodyAcc-std-X </li>
<li>timeBodyAcc-std-Y </li>
<li>timeBodyAcc-std-Z </li>
<li>timeGravityAcc-mean-X </li>
<li>timeGravityAcc-mean-Y </li>
<li>timeGravityAcc-mean-Z </li>
<li>timeGravityAcc-std-X </li>
<li>timeGravityAcc-std-Y </li>
<li>timeGravityAcc-std-Z </li>
<li>timeBodyAccJerk-mean-X </li>
<li>timeBodyAccJerk-mean-Y </li>
<li>timeBodyAccJerk-mean-Z </li>
<li>timeBodyAccJerk-std-X </li>
<li>timeBodyAccJerk-std-Y </li>
<li>timeBodyAccJerk-std-Z </li>
<li>timeBodyGyro-mean-X </li>
<li>timeBodyGyro-mean-Y </li>
<li>timeBodyGyro-mean-Z </li>
<li>timeBodyGyro-std-X </li>
<li>timeBodyGyro-std-Y </li>
<li>timeBodyGyro-std-Z </li>
<li>timeBodyGyroJerk-mean-X </li>
<li>timeBodyGyroJerk-mean-Y </li>
<li>timeBodyGyroJerk-mean-Z </li>
<li>timeBodyGyroJerk-std-X </li>
<li>timeBodyGyroJerk-std-Y </li>
<li>timeBodyGyroJerk-std-Z </li>
<li>timeBodyAccMag-mean </li>
<li>timeBodyAccMag-std </li>
<li>timeGravityAccMag-mean </li>
<li>timeGravityAccMag-std </li>
<li>timeBodyAccJerkMag-mean </li>
<li>timeBodyAccJerkMag-std </li>
<li>timeBodyGyroMag-mean </li>
<li>timeBodyGyroMag-std </li>
<li>timeBodyGyroJerkMag-mean </li>
<li>timeBodyGyroJerkMag-std </li>
<li>frequencyBodyAcc-mean-X </li>
<li>frequencyBodyAcc-mean-Y </li>
<li>frequencyBodyAcc-mean-Z </li>
<li>frequencyBodyAcc-std-X </li>
<li>frequencyBodyAcc-std-Y </li>
<li>frequencyBodyAcc-std-Z </li>
<li>frequencyBodyAcc-meanfreq-X </li>
<li>frequencyBodyAcc-meanfreq-Y </li>
<li>frequencyBodyAcc-meanfreq-Z </li>
<li>frequencyBodyAccJerk-mean-X </li>
<li>frequencyBodyAccJerk-mean-Y </li>
<li>frequencyBodyAccJerk-mean-Z </li>
<li>frequencyBodyAccJerk-std-X </li>
<li>frequencyBodyAccJerk-std-Y </li>
<li>frequencyBodyAccJerk-std-Z </li>
<li>frequencyBodyAccJerk-meanFreq-X </li>
<li>frequencyBodyAccJerk-meanFreq-Y </li>
<li>frequencyBodyAccJerk-meanFreq-Z </li>
<li>frequencyBodyGyro-mean-X </li>
<li>frequencyBodyGyro-mean-Y </li>
<li>frequencyBodyGyro-mean-Z </li>
<li>frequencyBodyGyro-std-X </li>
<li>frequencyBodyGyro-std-Y </li>
<li>frequencyBodyGyro-std-Z </li>
<li>frequencyBodyGyro-meanFreq-X </li>
<li>frequencyBodyGyro-meanFreq-Y </li>
<li>frequencyBodyGyro-meanFreq-Z </li>
<li>frequencyBodyAccMag-mean </li>
<li>frequencyBodyAccMag-std </li>
<li>frequencyBodyAccMag-meanFreq</li>
<li>frequencyBodyAccJerkMag-mean </li>
<li>frequencyBodyAccJerkMag-std </li>
<li>frequencyBodyAccJerkMag-meanFreq </li>
<li>frequencyBodyGyroMag-mean </li>
<li>frequencyBodyGyroMag-std </li>
<li>frequencyBodyGyroMag-meanFreq </li>
<li>frequencyBodyGyroJerkMag-mean </li>
<li>frequencyBodyGyroJerkMag-std </li>
<li>frequencyBodyGyroJerkMag-meanFreq</li>
</ul>

Each of these values in the output text file contain the averages of the raw values associated 
with each subject and activity pair. The raw values and averaged values are normalized values 
in the range [-1, 1]. These variable names are slightly different from their raw values in that 
they have been cleaned for better readability. Specifically, all occurrences of parenthesis and commas have been removed. 
Variables that begin with "t" or "f" have been replaced with "time" and "frequency", respectively.


### Human Activity Recognition Using Smartphones Dataset - Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws - http://www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket 
of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have 
been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the 
training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise 
filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap 
(128 readings/window). The sensor acceleration signal, which has gravitational and body 
motion components, was separated using a Butterworth low-pass filter into body acceleration 
and gravity. The gravitational force is assumed to have only low frequency components, 
therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 
features was obtained by calculating variables from the time and frequency domain. See 
'features_info.txt' for more details. 

For each record it is provided:
*Triaxial acceleration from the accelerometer (total acceleration) and the estimated 
body acceleration.
*Triaxial Angular velocity from the gyroscope. 
*A 561-feature vector with time and frequency domain variables. 
*Its activity label. 
*An identifier of the subject who carried out the experiment.

The downloaded dataset includes the following files:
<ul><li>'README.txt'</li>
<li>'features_info.txt': Shows information about the variables used on the feature vector.</li>
<li>'features.txt': List of all features.</li>
<li>'activity_labels.txt': Links the class labels with their activity name.</li>
<li>'train/X_train.txt': Training set.</li>
<li>'train/y_train.txt': Training labels.</li>
<li>'test/X_test.txt': Test set.</li>
<li>'test/y_test.txt': Test labels.</li>
</ul>

The following files are available for the train and test data. Their descriptions are 
equivalent:
<ul><li>'train/subject_train.txt': Each row identifies the subject who performed the activity 
for each window sample. Its range is from 1 to 30. </li>
<li>'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the 
smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 
element vector. The same description applies for the 'total_acc_x_train.txt' and 
'total_acc_z_train.txt' files for the Y and Z axis. </li>
<li>'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by 
subtracting the gravity from the total acceleration. </li>
<li>'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by 
the gyroscope for each window sample. The units are radians/second. </li>
</ul>

### Notes
<ul><li>Features are normalized and bounded within [-1,1].</li>
<li>Each feature vector is a row on the text file.</li>
</ul>

For more information about this dataset contact: activityrecognition@smartlab.ws

### License
Use of this dataset in publications must be acknowledged by referencing the following 
publication [1].

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support 
Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be 
addressed to the authors or their institutions for its use or misuse. Any commercial use 
is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial 
raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) 
were captured at a constant rate of 50 Hz. Then they were filtered using a median filter 
and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration 
signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter 
with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these 
three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, 
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. 
(Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

<ul><li>tBodyAcc-XYZ</li>
<li>tGravityAcc-XYZ</li>
<li>tBodyAccJerk-XYZ</li>
<li>tBodyGyro-XYZ</li>
<li>tBodyGyroJerk-XYZ</li>
<li>tBodyAccMag</li>
<li>tGravityAccMag</li>
<li>tBodyAccJerkMag</li>
<li>tBodyGyroMag</li>
<li>tBodyGyroJerkMag</li>
<li>fBodyAcc-XYZ</li>
<li>fBodyAccJerk-XYZ</li>
<li>fBodyGyro-XYZ</li>
<li>fBodyAccMag</li>
<li>fBodyAccJerkMag</li>
<li>fBodyGyroMag</li>
<li>fBodyGyroJerkMag</li>
</ul>

The set of variables that were estimated from these signals are: 
<ul><li>mean(): Mean value</li>
<li>std(): Standard deviation</li>
<li>mad(): Median absolute deviation </li>
<li>max(): Largest value in array</li>
<li>min(): Smallest value in array</li>
<li>sma(): Signal magnitude area</li>
<li>energy(): Energy measure. Sum of the squares divided by the number of values.</li> 
<li>iqr(): Interquartile range </li>
<li>entropy(): Signal entropy</li>
<li>arCoeff(): Autorregresion coefficients with Burg order equal to 4</li>
<li>correlation(): correlation coefficient between two signals</li>
<li>maxInds(): index of the frequency component with largest magnitude</li>
<li>eanFreq(): Weighted average of the frequency components to obtain a mean frequency</li>
<li>skewness(): skewness of the frequency domain signal </li>
<li>kurtosis(): kurtosis of the frequency domain signal </li>
<li>bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.</li>
<li>angle(): Angle between to vectors.</li>
</ul>

Additional vectors obtained by averaging the signals in a signal window sample. 
These are used on the angle() variable:
<ul><li>gravityMean</li>
<li>tBodyAccMean</li>
<li>tBodyAccJerkMean</li>
<li>tBodyGyroMean</li>
<li>tBodyGyroJerkMean</li>
</ul>

The complete list of variables of each feature vector is available in 'features.txt'.