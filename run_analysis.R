testset <- cbind(read.table("./UCI HAR Dataset/test/subject_test.txt"),
                 read.table("./UCI HAR Dataset/test/y_test.txt"),
                 read.table("./UCI HAR Dataset/test/X_test.txt"))

trainset <- cbind(read.table("./UCI HAR Dataset/train/subject_train.txt"),
                  read.table("./UCI HAR Dataset/train/y_train.txt"),
                  read.table("./UCI HAR Dataset/train/X_train.txt"))

combinedset <- rbind(testset,
                     trainset)
rm(testset,trainset)

names <- as.character(read.table("./UCI HAR Dataset/features.txt")[,2])
names <- gsub("[()]", "", names)
colnames(combinedset) <- c("subject",
                           "activity",
                           names)

dat <- combinedset[,grep("subject|activity|mean()|std()",colnames(combinedset))]
rm(combinedset,names)

act_vect <- dat$activity
lbls <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in lbls$V1){
  act_vect[act_vect==i] <- as.character(lbls$V2[i])}
dat$activity <- act_vect
rm(act_vect, i, lbls)

dat %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean)) ->
  tidy
