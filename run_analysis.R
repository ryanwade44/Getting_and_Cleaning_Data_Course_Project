library(dplyr); library(tidyr); library(stringr)

# Use the code below if you need to change the working directory
#root.path = "<your working directory>"
#setwd(root.path)

#Activity Label data
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity.labels)[1] <- "activity.id"
names(activity.labels)[2] <- "activity"

#Subject data
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject.test)[1] <- "subject.id"
subject.test$phase <- "test"
subject.test$row.id <- row.names(subject.test)

subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject.train)[1] <- "subject.id"
subject.train$phase <- "train"
subject.train$row.id <- row.names(subject.train)

#Activity Data
activity.info.test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
names(activity.info.test)[1] <- "activity.id"
activity.info.test$row.id <- row.names(activity.info.test)
activity.info.train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
names(activity.info.train)[1] <- "activity.id"
activity.info.train$row.id <- row.names(activity.info.train)

#Combine activity info data with subject data and puts it into the additional_info data frame
activity.subject.test <- inner_join(activity.info.test, subject.test, by="row.id")
activity.subject.test <- inner_join(activity.subject.test, activity.labels, by="activity.id")
activity.subject.train <- inner_join(activity.info.train, subject.train, by="row.id")
activity.subject.train <- inner_join(activity.subject.train, activity.labels, by="activity.id")

#
read.me.root.name <- c("tBodyAcc-XYZ","tGravityAcc-XYZ","tBodyAccJerk-XYZ","tBodyGyro-XYZ","tBodyGyroJerk-XYZ","tBodyAccMag","tGravityAccMag","tBodyAccJerkMag","tBodyGyroMag","tBodyGyroJerkMag","fBodyAcc-XYZ","fBodyAccJerk-XYZ","fBodyGyro-XYZ","fBodyAccMag","fBodyAccJerkMag","fBodyGyroMag","fBodyGyroJerkMag")
feature.root.name <- c("tBodyAcc","tGravityAcc","tBodyAccJerk","tBodyGyro","tBodyGyroJerk","tBodyAccMag","tGravityAccMag","tBodyAccJerkMag","tBodyGyroMag","tBodyGyroJerkMag","fBodyAcc","fBodyAccJerk","fBodyGyro","fBodyAccMag","fBodyBodyAccJerkMag","fBodyBodyGyroMag","fBodyBodyGyroJerkMag")
full.variable.name <- c("body acceleration signal","gravity acceleration signal","body acceleration jerk signal","body angular velocity","angular velocity jerk signal","body acceleration magnitude","gravity acceleration magnitude","body acceleration jerk magnitude","body angular velocity magnitude","body angular velocity jerk magnitude","body acceleration frequency domain signals","body acceleration jerk frequency domain signals","body angular velocity frequency domain signals","body accelaration magnitude frequency domain signals","body acceleration jerk magnitude frequency domain signals","body angular velocity magnitude frequency domain signals","body angular velocity jerk magnitude frequency domain signals")

feature_names <- data.frame(read.me.root.name, feature.root.name, full.variable.name)
features <- read.table("./UCI HAR Dataset/features.txt")
features.std.means <-
    features %>% 
    mutate(feature.root.name = str_sub(V2,str_locate(V2,"^.*?-")[,1], str_locate(V2,"^.*?-")[,2]-1)
           ,stat = ifelse(str_detect(V2,"mean") == TRUE, "mean", "std")
           ,DesiredField = ifelse(str_detect(V2,"mean\\(\\)") | str_detect(V2,"std\\(\\)"),TRUE,FALSE)
           ,field.name = paste("V",V1,sep="")
           ,coordinate = ifelse(str_detect(V2,"[X|Y|Z]$"),str_sub(V2,nchar(as.character(V2)),nchar(as.character(V2))),"")) %>%
    rename(col.pos=V1, variable=V2) %>%
    filter(DesiredField == TRUE) %>%
    inner_join(feature_names, by="feature.root.name") %>%
    mutate(full.variable.name = str_trim(paste(full.variable.name, stat, coordinate, sep = " "), side = "right")) %>%
    select(col.pos, field.name, variable, full.variable.name)

test.set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.set <- test.set[,features.std.means$field.name]
names(test.set) <-features.std.means$full.variable.name 
test.set$row.id <- row.names(test.set)
test.set <- inner_join(test.set, activity.subject.test, by="row.id")

train.set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.set <- train.set[,features.std.means$field.name]
names(train.set) <-features.std.means$full.variable.name
train.set$row.id <- row.names(train.set)
train.set <- inner_join(train.set, activity.subject.train, by="row.id")

merged.data <- rbind(test.set, train.set)
merged.data <- 
    merged.data %>% 
    select(-activity.id) %>%
    select(activity:`body acceleration signal mean X`)

activity.subject.average <-
    merged.data %>%
    group_by(activity, phase, subject.id) %>%
    summarize(
        `avg body angular velocity jerk magnitude frequency domain signals std` = mean(`body angular velocity jerk magnitude frequency domain signals std`),
        `avg body angular velocity jerk magnitude frequency domain signals mean` = mean(`body angular velocity jerk magnitude frequency domain signals mean`),
        `avg body angular velocity magnitude frequency domain signals std` = mean(`body angular velocity magnitude frequency domain signals std`),
        `avg body angular velocity magnitude frequency domain signals mean` = mean(`body angular velocity magnitude frequency domain signals mean`),
        `avg body acceleration jerk magnitude frequency domain signals std` = mean(`body acceleration jerk magnitude frequency domain signals std`),
        `avg body acceleration jerk magnitude frequency domain signals mean` = mean(`body acceleration jerk magnitude frequency domain signals mean`),
        `avg body accelaration magnitude frequency domain signals std` = mean(`body accelaration magnitude frequency domain signals std`),
        `avg body accelaration magnitude frequency domain signals mean` = mean(`body accelaration magnitude frequency domain signals mean`),
        `avg body angular velocity frequency domain signals std Z` = mean(`body angular velocity frequency domain signals std Z`),
        `avg body angular velocity frequency domain signals std Y` = mean(`body angular velocity frequency domain signals std Y`),
        `avg body angular velocity frequency domain signals std X` = mean(`body angular velocity frequency domain signals std X`),
        `avg body angular velocity frequency domain signals mean Z` = mean(`body angular velocity frequency domain signals mean Z`),
        `avg body angular velocity frequency domain signals mean Y` = mean(`body angular velocity frequency domain signals mean Y`),
        `avg body angular velocity frequency domain signals mean X` = mean(`body angular velocity frequency domain signals mean X`),
        `avg body acceleration jerk frequency domain signals std Z` = mean(`body acceleration jerk frequency domain signals std Z`),
        `avg body acceleration jerk frequency domain signals std Y` = mean(`body acceleration jerk frequency domain signals std Y`),
        `avg body acceleration jerk frequency domain signals std X` = mean(`body acceleration jerk frequency domain signals std X`),
        `avg body acceleration jerk frequency domain signals mean Z` = mean(`body acceleration jerk frequency domain signals mean Z`),
        `avg body acceleration jerk frequency domain signals mean Y` = mean(`body acceleration jerk frequency domain signals mean Y`),
        `avg body acceleration jerk frequency domain signals mean X` = mean(`body acceleration jerk frequency domain signals mean X`),
        `avg body acceleration frequency domain signals std Z` = mean(`body acceleration frequency domain signals std Z`),
        `avg body acceleration frequency domain signals std Y` = mean(`body acceleration frequency domain signals std Y`),
        `avg body acceleration frequency domain signals std X` = mean(`body acceleration frequency domain signals std X`),
        `avg body acceleration frequency domain signals mean Z` = mean(`body acceleration frequency domain signals mean Z`),
        `avg body acceleration frequency domain signals mean Y` = mean(`body acceleration frequency domain signals mean Y`),
        `avg body acceleration frequency domain signals mean X` = mean(`body acceleration frequency domain signals mean X`),
        `avg body angular velocity jerk magnitude std` = mean(`body angular velocity jerk magnitude std`),
        `avg body angular velocity jerk magnitude mean` = mean(`body angular velocity jerk magnitude mean`),
        `avg body angular velocity magnitude std` = mean(`body angular velocity magnitude std`),
        `avg body angular velocity magnitude mean` = mean(`body angular velocity magnitude mean`),
        `avg body acceleration jerk magnitude std` = mean(`body acceleration jerk magnitude std`),
        `avg body acceleration jerk magnitude mean` = mean(`body acceleration jerk magnitude mean`),
        `avg gravity acceleration magnitude std` = mean(`gravity acceleration magnitude std`),
        `avg gravity acceleration magnitude mean` = mean(`gravity acceleration magnitude mean`),
        `avg body acceleration magnitude std` = mean(`body acceleration magnitude std`),
        `avg body acceleration magnitude mean` = mean(`body acceleration magnitude mean`),
        `avg angular velocity jerk signal std Z` = mean(`angular velocity jerk signal std Z`),
        `avg angular velocity jerk signal std Y` = mean(`angular velocity jerk signal std Y`),
        `avg angular velocity jerk signal std X` = mean(`angular velocity jerk signal std X`),
        `avg angular velocity jerk signal mean Z` = mean(`angular velocity jerk signal mean Z`),
        `avg angular velocity jerk signal mean Y` = mean(`angular velocity jerk signal mean Y`),
        `avg angular velocity jerk signal mean X` = mean(`angular velocity jerk signal mean X`),
        `avg body angular velocity std Z` = mean(`body angular velocity std Z`),
        `avg body angular velocity std Y` = mean(`body angular velocity std Y`),
        `avg body angular velocity std X` = mean(`body angular velocity std X`),
        `avg body angular velocity mean Z` = mean(`body angular velocity mean Z`),
        `avg body angular velocity mean Y` = mean(`body angular velocity mean Y`),
        `avg body angular velocity mean X` = mean(`body angular velocity mean X`),
        `avg body acceleration jerk signal std Z` = mean(`body acceleration jerk signal std Z`),
        `avg body acceleration jerk signal std Y` = mean(`body acceleration jerk signal std Y`),
        `avg body acceleration jerk signal std X` = mean(`body acceleration jerk signal std X`),
        `avg body acceleration jerk signal mean Z` = mean(`body acceleration jerk signal mean Z`),
        `avg body acceleration jerk signal mean Y` = mean(`body acceleration jerk signal mean Y`),
        `avg body acceleration jerk signal mean X` = mean(`body acceleration jerk signal mean X`),
        `avg gravity acceleration signal std Z` = mean(`gravity acceleration signal std Z`),
        `avg gravity acceleration signal std Y` = mean(`gravity acceleration signal std Y`),
        `avg gravity acceleration signal std X` = mean(`gravity acceleration signal std X`),
        `avg gravity acceleration signal mean Z` = mean(`gravity acceleration signal mean Z`),
        `avg gravity acceleration signal mean Y` = mean(`gravity acceleration signal mean Y`),
        `avg gravity acceleration signal mean X` = mean(`gravity acceleration signal mean X`),
        `avg body acceleration signal std Z` = mean(`body acceleration signal std Z`),
        `avg body acceleration signal std Y` = mean(`body acceleration signal std Y`),
        `avg body acceleration signal std X` = mean(`body acceleration signal std X`),
        `avg body acceleration signal mean Z` = mean(`body acceleration signal mean Z`),
        `avg body acceleration signal mean Y` = mean(`body acceleration signal mean Y`),
        `avg body acceleration signal mean X` = mean(`body acceleration signal mean X`)
    )

#Remove unneeded data frames
data.frames.to.remove <- c("read.me.root.name","feature.root.name","full.variable.name","activity.info.test","activity.info.train","activity.labels","activity.subject.test","activity.subject.train","feature_names","features","features.std.means","root.path","subject.test","subject.train","test.set","train.set")
rm(list = data.frames.to.remove)
rm(data.frames.to.remove)
