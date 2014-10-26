run_analysis <- function() {
    # Load the required libraries
    library(plyr)

    # Load in the data
    testX <- read.table("test/X_test.txt")
    testY <- read.table("test/y_test.txt")
    testSubject <- read.table("test/subject_test.txt")
    trainX <- read.table("train/X_train.txt")
    trainY <- read.table("train/Y_train.txt")
    trainSubject <- read.table("train/subject_train.txt")
    
    # Load and process the features table for use
    features <- read.table("features.txt")    

    # Build the list of columsn that we're interested in
    columnIndicesToKeep <- c(grep("mean()", features[,2], fixed = TRUE), grep("std()", features[,2], fixed = TRUE))    
    
    # Rename the columns on the X values to match real column names
    # These will introduce duplicate column names, but we're going to
    # trim those out, so that's ok, we don't need any of the duplicates.
    names(trainX) <- features[, 2]
    names(testX) <- features[, 2]
    
    # Remove the columns we don't need
    trainX <- trainX[, columnIndicesToKeep]
    testX <- testX[, columnIndicesToKeep]
    
    # Rename the Y's V1 column to ActivityIndex.
    testY <- rename(testY, c("V1" = "ActivityIndex"))
    trainY <- rename(trainY, c("V1" = "ActivityIndex"))
    
    # Rename the subject's V1 column to Subject
    testSubject <- rename(testSubject, c("V1" = "Subject"))
    trainSubject <- rename(trainSubject, c("V1" = "Subject"))
    
    # Generate indices for the data to faciliate joining
    testX$Id <- seq(along.with = testX[,1])
    testY$Id <- seq(along.with = testY[,1])
    testSubject$Id <- seq(along.with = testSubject[,1])
    trainX$Id <- seq(along.with = trainX[,1])
    trainY$Id <- seq(along.with = trainY[,1])
    trainSubject$Id <- seq(along.with = trainSubject[,1])
    
    # Reshape the data
    trainX <- melt(trainX, id = c("Id"), measure.vars = features[columnIndicesToKeep, 2])
    testX <- melt(testX, id = c("Id"), measure.vars = features[columnIndicesToKeep, 2])
    
    # Merge the X values and Y values together
    testJoined <- merge(x = testX, y = testY, by = "Id")
    testJoined <- merge(x = testJoined, y = testSubject, by = "Id")
    trainJoined <- merge(x = trainX, y = trainY, by = "Id")
    trainJoined <- merge(x = trainJoined, y = trainSubject, by = "Id")
    
    # Merge the test data and the training data
    data <- rbind(testJoined, trainJoined)
    
    # Load and assign the labels
    labels <- read.table("activity_labels.txt")
    labels <- rename(labels, c("V1" = "Index", "V2" = "Activity"))
    data <- merge(x = data, y = labels, by.x = "ActivityIndex", by.y = "Index")
    
    # Remove the Id and ActivityIndex, those aren't requested for the final output
    data <- subset(data, select = -c(Id, ActivityIndex))
    
    # Calculate the average for each activity and subject
    data <- ddply(data, .(Subject, Activity, variable), summarize, Average = mean(value))
    
    # Pretty up the names just a little
    data <- rename(data, c("variable" = "Variable"))

    # Write out the final data to the file
    write.table(data, "results.txt", row.names = FALSE)
}
