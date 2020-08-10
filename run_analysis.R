setwd("H:/DataScienceCoursera/GettingCleaningData/getting-and-cleaning-date-final-proj")
subtest<-read.csv("./UCI HAR Dataset/test/subject_test.txt",header = F)
subtrain<-read.csv("./UCI HAR Dataset/train/subject_train.txt",header=F)
xtest<-read.table("./UCI HAR Dataset/test/x_test.txt")
xtrain<-read.table("./UCI HAR Dataset/train/x_train.txt")
ytest<-read.csv("./UCI HAR Dataset/test/y_test.txt",header = F)
ytrain<-read.csv("./UCI HAR Dataset/train/y_train.txt",header=F)
#Merges the training and the test sets to create one data set.
all<-rbind(cbind(subtest,ytest,xtest),cbind(subtrain,ytrain,xtrain))

#Extracts only the measurements on the mean and standard deviation for each measurement.
feature<-read.csv("./UCI HAR Dataset/features.txt",header = F,sep = " ")
extr<-feature[grep('mean|std',feature$V2),]

#Uses descriptive activity names to name the activities in the data set
act<-read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(all)[1:2]<-c("subject","activity")
all<-merge(all,act,by.x = "activity",by.y = "V1")
colnames(all)[564]<-"actnames"

#Appropriately labels the data set with descriptive variable names.
colnames(all)[3:563]<-feature$V2

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
avg<-aggregate(.~subject + actnames,all,mean)
write.table(avg, file = "tidydata.csv",row.name=FALSE)
