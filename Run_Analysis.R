# set our work directory
setwd ("/Coursera_CleaningData/UCI HAR Dataset/UCI HAR Dataset")
getwd ()
# we already extracted the zipped files
library(plyr)
# Step 1
# Merge the training and test sets to create one data set
###############################################################################
XTrain <- read.table("train/X_train.txt")
YTrain <- read.table("train/y_train.txt")
SubjTrain <- read.table("train/subject_train.txt")



XTest <- read.table("test/X_test.txt")
YTest <- read.table("test/y_test.txt")
SubjTest <- read.table("test/subject_test.txt")

#combine X data 

XData <- rbind (XTest, XTrain)

#combine Y data
YData <- rbind (YTest,YTrain)


#Combine Subject data
SubjData <- rbind (SubjTest, SubjTrain)




# read the features
Features <- read.table("features.txt")


# read the activities
Activities <- read.table("activity_labels.txt")


# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################

# get only columns with mean() or std() in their names we are going to exclude mean Freq and so on
MeanStdFeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# Get the desired columns from Xdata
XData <- XData[, MeanStdFeatures]

# correct the column names
names(XData) <- features[MeanStdFeatures, 2]


# add column name for YData
# correct column name
names(YData) <- "Activity"

# update values with correct activity names
YData[, 1] <- activities[YData [, 1], 2]
YData

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(SubjData) <- "Subject"

# bind all the columns data in a single data set
AllData <- cbind (XData, YData, SubjData)
AllData

# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject
###############################################################################
TidyData <- ddply(AllData, .(Subject, Activity), function(x) colMeans(x[, 1:66]))

#write the file

write.table(TidyData, "MyTidyData.txt", row.name=FALSE)
