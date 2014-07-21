library(reshape2)

features <- read.table("./UCI HAR Dataset/features.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#rename y_test$V1 to "activity"
names(y_test) <- "activity"

#rename subject_test$V1 to "subject
names(subject_test) <- "subject"

#rename variables to in x_test to names in features
colnames(x_test) <- features[ , 2]

#rename y_train$V1 to "activity"
names(y_train) <- "activity"

#rename subject_train$V1 to "subject
names(subject_train) <- "subject"

#rename variables to in x_train to names in features
colnames(x_train) <- features[ , 2]

#add subject and activity as the first two columns of x_test
x_test <- cbind(subject_test, x_test)
x_test <- cbind(y_test, x_test)

#add subject and activity as the first two columns of x_train
x_train <- cbind(subject_train, x_train)
x_train <- cbind(y_train, x_train)

#append x_train and x_test together to make one large df
# 10,299 obs. and 563 variables
x_df <- rbind(x_train, x_test)

#Extract only the measurements on the mean and standard 
#deviation for each measurement, while making sure to keep
#column 1 (activity) and column 2 (subject)
a <- grep("mean|std", names(x_df))
mean_std_measurements <- x_df[, c(1:2,a)]

#replace numbers in "activity" column with proper activity labels
for(i in seq_len(length(activity_labels[ ,2])))
{
    mean_std_measurements[,"activity"][mean_std_measurements[,"activity"] == i] <- tolower(as.character(activity_labels[i, 2]))
}
#try to make the variable names more meaningful
names(mean_std_measurements) <- tolower(names(mean_std_measurements))
names(mean_std_measurements) <- sub("^t","time", names(mean_std_measurements))
names(mean_std_measurements) <- sub("acc-","accelerometer",names(mean_std_measurements))
names(mean_std_measurements) <- sub("acc[^e]", "acceleration", names(mean_std_measurements))
names(mean_std_measurements) <- sub("gyro", "gyroscope", names(mean_std_measurements))
names(mean_std_measurements) <- gsub("-","",names(mean_std_measurements))
names(mean_std_measurements) <- sub("std", "standarddeviation", names(mean_std_measurements))
names(mean_std_measurements) <- sub("\\(\\)","", names(mean_std_measurements))
names(mean_std_measurements) <- sub("mag", "magnitude", names(mean_std_measurements))
names(mean_std_measurements) <- sub("freq", "frequency", names(mean_std_measurements))
names(mean_std_measurements) <- sub("^f", "frequencydomainsignal", names(mean_std_measurements))

#convert activity and and subject columns to factors
mean_std_measurements$activity <- as.factor(mean_std_measurements$activity)
mean_std_measurements$subject <- as.factor(mean_std_measurements$subject)


#create a second, independent tidy data set with the average of each variable for each activity and each subject.
x <- names(mean_std_measurements)
x<-x[3:81]
mean_std_measurements_melt <- melt(mean_std_measurements, id = c("activity", "subject"), measure.vars = x)
head(mean_std_measurements_melt)
second_tidy <- dcast(mean_std_measurements_melt, subject + activity ~ variable, mean)

#write the first tidy table to a file
write.table(mean_std_measurements, file = "./first_tidy_table.txt")

#write the second tidy table to a file
write.table(second_tidy, fiel = "./second_tidy_table.txt")
