setwd("C:/math/coursera/data collect/project")
library("plyr")
#read train data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="")
all_train <- cbind( X_train, y_train, subject_train)

#read test data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="")
all_test <- cbind( X_test, y_test, subject_test)

#merge train and test data
all_data <- rbind (all_train,all_test)

#read labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
features <- read.table("./UCI HAR Dataset/features.txt", quote="")

#grep mean and standart deviation colomn
mean_sd_row <- features[ grep("mean\\(|std", as.character(features$V2)),]

extract_data <- all_data [,c(mean_sd_row$V1, 562:563)]

#rename colomns
names(extract_data) <- c(gsub("[\\(\\)-]", "", (as.character(mean_sd_row$V2))), "activity", "subject")
match
dataset2 <- ddply (extract_data, ~(activity+ subject),  mean)
