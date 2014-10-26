# Project 1 Code Book
## Definition of results.txt file

The data in results.txt is generated from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  This data is processed by groupping by subject, activity, and variable name.  The resulting groups ared averaged using the mean function.  The units have not been changed from the source material, details can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  The list of variable names are a subset of the original to included the mean and standard deviations columns from the source data.

* Subject - Integer Factor
  * The identifier of the volunteer who generated this reading
  * Range of values from 1 to 30
* Activity - String Factor
  * The action that the subject is performming for this reading
  * WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* Variable - String Factor
  * The name of the sensor signal that is being averaged for this subject, activity, and reading.  These are mean and standard deviation's of variables.
  * The variable's pulled from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones that end with mean() or std()
* Average - Numeric
  * The mean value of that variable from the given activity and subject
  * Range from 0-1
