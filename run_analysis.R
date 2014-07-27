run_analysis <- function() {
        
        ## Read in data files from working directory using read.table()
        ## See codebook for details regarding data files
        X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
        X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
        y_test <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
        y_train <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")
        subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
        subject_train <- read.table(
                ".\\UCI HAR Dataset\\train\\subject_train.txt")
        
        ## ASSIGNMENT STEP ONE:
        ## Combine primary data frames X_test and X_train using rbind
        merged_data <- rbind(X_test, X_train)

        ## ASSIGNMENT STEP TWO:
        ## Extract only mean and standard deviation measurements.
        ## I opted to identify the columns manually from the codebook 
        ## (rather than programatically) because the format made the manual 
        ## process simple and the operation only had to be performed once.
        good_lines <- c(1:6, 41:46, 81:86, 121:126, 
                        161:166, 201:202, 214:215, 227:228,
                        240:241, 253:254, 266:271, 345:350, 
                        424:429, 503:504, 516:517, 529:530, 
                        542:543)
        md2 <- merged_data[,good_lines]
        
        ## ASSIGNMENT STEP THREE:
        ## Create a new column of data from y_test and y_train.  Add this
        ## column to the main data set (md3) to show the specific activity that
        ## generated the data.  Use the replace function (and the original
        ## data's codebook) to convert these activity integers (e.g., 1,4,5)
        ## into descriptive activity names (e.g., WALKING, SITTING, STANDING).
        merged_activity <- rbind(y_test, y_train)
        md3 <- cbind(md2, merged_activity)
        md3[67] <- replace(md3[67], md3[67]==1, "WALKING")
        md3[67] <- replace(md3[67], md3[67]==2, "WALKING_UPSTAIRS")
        md3[67] <- replace(md3[67], md3[67]==3, "WALKING_DOWNSTAIRS")
        md3[67] <- replace(md3[67], md3[67]==4, "SITTING")
        md3[67] <- replace(md3[67], md3[67]==5, "STANDING")
        md3[67] <- replace(md3[67], md3[67]==6, "LAYING")
        
        ## ASSIGNMENT STEP FOUR:
        ## Read "features.txt" into R and subset with good_lines to keep
        ## only the relevant data labels.  Iterate over the resulting vector
        ## (data_labels) to manipulate the strings into better labels.
        ## Note: I tried to follow the lecture guidelines on variables names,
        ## but obviously all lowercase wasn't an option with such long names.
        ## I settled on lowercase camelback, then extended abbreviations and
        ## removed symbols.
        ## Two examples: "timeBodyAccelerationMeanX" "frequencyBodyGyroMeanX"
        
        data_labels <- read.table(".\\UCI HAR Dataset\\features.txt")
        data_labels <- data_labels[good_lines,2]
        labels2 <- sub("t","time", data_labels)
        labels2 <- sub("f", "frequency", labels2)
        labels2 <- sub("Acc", "Acceleration", labels2)
        labels2 <- gsub("-","", labels2)
        labels2 <- sub("\\(\\)","", labels2)
        labels2 <- sub("mean", "Mean", labels2)
        labels2 <- sub("std", "Std", labels2)
        labels2 <- sub("timed", "Timed", labels2)
        labels2[67] <- "activityName"
        names(md3) <- labels2
        
        
        ## ASSIGNMENT STEP FIVE:
        ## Read in subject data and add it to primary data frame (md#).
        ## Use aggregate() to split data into averages for each user and
        ## activity combination
        subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
        subject_train <- read.table(
                ".\\UCI HAR Dataset\\train\\subject_train.txt")
        merged_subjects <- rbind(subject_test, subject_train)
        md4 <- cbind(md3,merged_subjects)
        
        ## Adding variable name to new column
        labels2[68] <- "subject"
        names(md4) <- labels2
        
        ## Creating, re-naming, and sorting tidy data set
        tidy_data <- aggregate(md4, by=list(md4$subject, md4$activityName),
                               FUN=mean, na.rm=TRUE)
        tidy_data <- tidy_data[, 1:68]
        names(tidy_data)[names(tidy_data) == "Group.1"] <- "subject"
        names(tidy_data)[names(tidy_data) == "Group.2"] <- "activityName"
        ##tidy_data <- tidy_data[
        ##        order(tidy_data$subject, tidy_data$activityName), ]
        write.csv(tidy_data, ".\\result.txt")
        
}