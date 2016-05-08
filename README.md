# Data
All of the data can be found in the UCI HAR Dataset folder.  This can also be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The data folder must be in the same directory as the scripts.
# Analysis
These tasks are accomplised by the run_analysis.R script.

First, the files containing the subject's identifying numbers, the associated activity, and all of the reading are put together. This is done for both the "trainig" and "test" data sets seperately. The data was arbitratily seperated by the study's authors.  These two different sets are then assembled into one set. This set then has the data labels, slightly cleaned up, attached, along with labels for subject and activity. This data is then made into a table with just the subject, activity, and any measurements of mean or standard deviation. In the raw data, the activity is defined by a number, with a key found in activity_labls.txt. The script uses this file to replace the number with the associated text string.

Finally, the data is grouped so that each subject doing a given activity makes a single observation. For each row that is the same subjectr and activity, the mean of each measurement is calculated.  The script then writes the simplified table to a file named "tidy.txt"
# Codebook
