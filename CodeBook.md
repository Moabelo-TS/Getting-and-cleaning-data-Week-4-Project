The codeBook


The data set that this code book pertains to is located in the tidy_data.txt file of this repository.

README.md file in this repository contains background information on this data set.

The structure of the data set is described as follows: 

##Data
The tidy_data.txt data file is a text file, containing space-separated values.

The first row contains the names of the variables, which are listed and described in the Variables section, and the following rows contain the values of these variables.

##Variables
Each row contains, for a given subject and activity, 79 averaged signal measurements.

##Identifiers
 -subject

 Subject identifier, integer, ranges from 1 to 30.

## activity

Activity identifier, string with 6 possible values:

-WALKING: subject was walking
-WALKING_UPSTAIRS: subject was walking upstairs
-WALKING_DOWNSTAIRS: subject was walking downstairs
-SITTING: subject was sitting
-STANDING: subject was standing
-LAYING: subject was laying
-Average of measurements
-All measurements are floating-point values, normalised and bounded within [-1,1].

Prior to normalisation, acceleration measurements (variables containing Accelerometer) were made in g's (9.81 m.s⁻²) and gyroscope measurements (variables containing Gyroscope) were made in radians per second (rad.s⁻¹).

Magnitudes of three-dimensional signals (variables containing Magnitude) were calculated using the Euclidean norm.

The following are two domains were measurement were classified:

Time-domain signals (variables prefixed by timeDomain), resulting from the capture of accelerometer and gyroscope raw signals.

Frequency-domain signals (variables prefixed by frequencyDomain), resulting from the application of a Fast Fourier Transform (FFT) to some of the time-domain signals.

##Measurement Means
All variables are the mean of a measurement for each subject and activity. This is indicated by the initial Mean in the variable name. All values are floating point numbers.

#Source Files
The source files we use to create the tidy data set from the extrated data archive are:

features_info.txt: Shows information about the variables used on the feature vector.
features.txt: List of all features.
activity_labels.txt: Links the class labels with their activity name.
train/X_train.txt: Training set.
train/y_train.txt: Training labels.
test/X_test.txt: Test set.
test/y_test.txt: Test labels.

##Transformations

The following transformations were applied to the source data:

1. The training and test sets were merged to create one data set.

2. The measurements on the mean and standard deviation (i.e. signals containing the strings mean and std) were extracted for each measurement, and the others were discarded.

3.The activity identifiers (originally coded as integers between 1 and 6) were replaced with descriptive activity names (see Identifiers section).

4. The variable names were replaced with descriptive variable names (e.g. tBodyAcc-mean()-X was expanded to timeDomainBodyAccelerometerMeanX), using the following set of rules:
Special characters (i.e. (, ), and -) were removed
The initial f and t were expanded to frequencyDomain and timeDomain respectively.
Acc, Gyro, Mag, Freq, mean, and std were replaced with Accelerometer, Gyroscope, Magnitude, Frequency, Mean, and StandardDeviation respectively.
Replaced (supposedly incorrect as per source's features_info.txt file) BodyBody with Body.

5. From the data set in step 4, the final data set was created with the average of each variable for each activity and each subject.

