# set our work directory
setwd ("/Coursera_CleaningData/UCI HAR Dataset/UCI HAR Dataset")
getwd ()
# we already extracted the zipped files

# Reading trainings tables:
Xtraining <- read.table("train/X_train.txt")
# let us check it 
head (Xtraining)


# Reading feature vector:
features <- read.table('features.txt')
# let us check it 
features


# Reading activity labels:
ActivityLabels = read.table('activity_labels.txt')
#let us check it
ActivityLabels

# set column names for activities
colnames(ActivityLabels) <- c('Activity','Activity_Type')
colnames(ActivityLabels)

######## for train################

# assign column names to Xtrain
colnames(Xtraining) <- features[,2] 
colnames(Xtraining)
#_________

# read the y train text file 
YTraining <- read.table("train/y_train.txt")

# assign column names
colnames(YTraining) <-"Activity"

#__________________
# read the subject train text file
SubjectTraining <- read.table("train/subject_train.txt")
#let us check it
head (SubjectTraining)
#assign column names
colnames(SubjectTraining) <- "Subject"

#____*** let us do the same with testing text files##############
# Reading testing tables:
XTest <- read.table("test/X_test.txt")
# assign column headers
colnames(XTest) <- features[,2] 
colnames(XTest)

 # read the y test data
YTest <- read.table("test/y_test.txt")
#assign column headers
colnames(YTest)<- "Activity"

# read the subject test data
subjectTest <- read.table("test/subject_test.txt")
# assign column headers
colnames(subjectTest) <- "Subject" 


 
# merge the testing files
AllTest <- cbind(YTest, subjectTest, XTest)
# let us test it
#let us check
colnames(AllTest)

#merge the training files
AllTraining <- cbind (YTraining, SubjectTraining, Xtraining)
#let us check it
colnames(AllTraining)

# merge test and training all in one set

AllinOne <- rbind(AllTraining, AllTest)


# let us check the column names are set properly
colNames <- colnames(AllinOne)
colNames
# Create vector for defining ID, mean and standard deviation
MeanStd <- (grepl("Activity" , colNames) | 
                     grepl("Subject" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
)

# get the required subset (clean one)
MeanStdSubAllinone <- AllinOne[ , MeanStd  == TRUE]
# let us check it
MeanStdSubAllinone

myTidySet <- aggregate(. ~Subject + Activity, MeanStdSubAllinone, mean)

# let us check it

myTidySet

# let us write it to a text file
write.table(myTidySet, "TidySet.txt", row.name=FALSE)


 
