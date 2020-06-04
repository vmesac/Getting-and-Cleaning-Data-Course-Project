

# CODEBOOK - Getting and Cleaning Data Course Project

This codebook describes the variables, the data, and any transformations or work performed to clean up the data from the "Human Activity Recognition Using Smartphones" experiment to get a tidy data set.


## Data transformation

The zip file containing the source of original data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

the R script called `run.analysis.R` is used to transformed this original data set in the final tidy data set following the next steps:

* Merge the training and the test sets to create one data set.

the dataframe is created by merging `train` and `test` tables using `cbind()` function

* Extract only the measurements on the mean and standard deviation for each measurement.

a second dataframe is created by subsetting from the first dataset, selecting only columns: `subject`, `id` and the measurements on the `mean` and `standard deviation` (std) for each measurement

* Use descriptive activity names to name the activities in the data set

names in `id` column are replaced with corresponding activity taken from second column of the `activities` table

* Appropriately labels the data set with descriptive variable names.

* Create a second, independent tidy data set with the average of each variable for each activity and each subject.

the final data set is created by sumarizing `DataSet_2` taking the means of each variable for each activity and each subject, after groupped by subject and activity.

## Variables
Each row contains, for subject and activity, 79 averaged signal measurements.

###Identifiers

**`subject`:**

Subject identifier, integer.

**`activity`:**

Activity identifier, string:

* `WALKING`
* `WALKING_UPSTAIRS`
* `WALKING_DOWNSTAIRS`
* `SITTING`
* `STANDING`
* `LAYING`

