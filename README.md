C3Project
=========

Course Project for "Getting and Cleaning Data" class, part of JHU/Coursera Data Science certification series.


==========
ORIGIN
==========
This project is based on the datasets and information published in the following article:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


==========
FILES
==========
This dataset contains the following relevant files:

UCI HAR Dataset -- Original dataset, "Human Activity Recognition Using Smartphones Dataset"

run_analysis.R -- R script that cleans, reshapes, and summarizes the original data set

result.txt -- Output data from run_analysis.R


==========
SCRIPT
==========
The run_analysis.R script performs 5 general steps listed below.  See script code for specific functions and comments
that provide further explanation.

1) Combines test and train data sets into a single data frame
2) Extracts only the 'mean' and 'standard deviation' columns from the new master data set
3) Adds the activity type that generated the activity data in the master data set
4) Re-labels the variable names found in the original dataset for readability by removing symbols and expanding
abbreviations.
5) Adds the subject identity that generated the activity data in the master data set.  Also creates a summary data set,
displaying the mean of each column for every subject/activity combination.
