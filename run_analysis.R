#getdata-006-courseproj
features <- read.table("Dataset/features.txt",stringsAsFactors = F)
data.X_train <- read.table("Dataset/train/X_train.txt")
data.y_train <- read.table("Dataset/train/y_train.txt")
data.subject_train <- read.table("Dataset/train/subject_train.txt")
data.X_test <- read.table("Dataset/test/X_test.txt")
data.y_test <- read.table("Dataset/test/y_test.txt")
data.subject_test <- read.table("Dataset/test/subject_test.txt")

# 1. merge them
data.X <- rbind(data.X_train,data.X_test)
data.y <- rbind(data.y_train,data.y_test)
data.subject <- rbind(data.subject_train,data.subject_test)
data.All <- cbind(data.subject,data.y,data.X)

names_of_data.All <- c("subject","y",features[,2])
names(data.All) <- names_of_data.All

write.table(data.All,file = "tidy_data.txt", row.names = F)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
cols_mean_std <- grep("(std[[:punct:]])|(mean[[:punct:]])",names_of_data.All)
data.sub_mean_std <- data.All[,cols_mean_std]
# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("Dataset/activity_labels.txt")
data.y_with_labels<-merge(data.y,activity_labels,by.x = 1, by.y=1)
names(data.y_with_labels)<-c("code","activity")
data.sub_mean_std<-cbind(data.subject,data.y_with_labels$activity,data.sub_mean_std)
names(data.sub_mean_std)[1] <- "subject"
names(data.sub_mean_std)[2] <- "activity"
# 4. Appropriately labels the data set with descriptive variable names. 
## I labeled them in step 1 :) according to the features.txt
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
res=aggregate.data.frame(data.sub_mean_std[,3:length(data.sub_mean_std[1,])],by=list(subject=data.sub_mean_std$subject,activity_type=data.sub_mean_std$activity),FUN = mean)

write.table(res,file="mean_for_each_subject-activity_of_mean_and_std_data.txt",row.name=F)

