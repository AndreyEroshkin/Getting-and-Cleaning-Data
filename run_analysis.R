setwd("C:/math/coursera/data collect/project")
library("plyr")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/Dataset.zip",method="curl")
unzip (zipfile="./data/Dataset.zip", exdir="./data")


#read train data
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", quote="")
all_train <- cbind( X_train, y_train, subject_train)

#read test data
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="")
all_test <- cbind( X_test, y_test, subject_test)

#merge train and test data
all_data <- rbind (all_train,all_test)

#read labels
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", quote="\"")
names(activity_labels) <- c("activity_num","activity")
features <- read.table("./data/UCI HAR Dataset/features.txt", quote="")

#grep mean and standart deviation colomn
mean_sd_row <- features[ grep("mean\\(|std", as.character(features$V2)),]

extract_data <- all_data [,c(mean_sd_row$V1, 562:563)]

#rename colomns
names(extract_data) <- c(gsub("[\\(\\)-]", "", (as.character(mean_sd_row$V2))), "activity_num", "subject")
#rename activity
dataset1 <- merge (extract_data, activity_labels, by="activity_num", all.x=TRUE, sort=FALSE) 
dataset1 <- dataset1 [,-1]

dataset2 <- ddply(dataset1, .(activity, subject), numcolwise(mean))
