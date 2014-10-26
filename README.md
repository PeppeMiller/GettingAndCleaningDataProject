# Getting and Cleaning Data Project
### Processing motion data from the S2

The run_analysis.R script contains all code needed to process the source file.  It assumes that https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has been expanded and the the content files in the "UCI HAR Dataset" folder have been copied into the same folder as run_analysis.R.  To generate the results.txt output, run run_analysis in the folder that contains the contents of the zipped folder "UCI HAR Dataset".

This analysis assumes that we are interested in readings that end in a mean() or std(), as the projects asks to measure the mean and standard deviation of the readings.

The data is processed as follows:
1. Load source data.
2. Build a list of columns we're interested in by finding all columns that contain std() or mean().
3. Rename the columns on the data to change from V1, V2... to the actual variable name.
4. Create indices for all of the data so that we can merege it later.
5. Reshape the data so that there is one column that contains the variable name and another with the value, to facilitate later calculations on the data.
6. Merge the data with the subject ids and the activity names.
7. Combine the test and train data.
8. Remove unneeded columns.
9. Calculate the average values.
10. Write out the results.

