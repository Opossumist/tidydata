# This section begins to assemble together all of the raw data in the files. The training
# set of data is assembled from the subject list, the activity list, and the data. The 
# test data is put together the same way into a separate table.  The training set is then
# added to the bottom of the test set, to make one combined data set.
testset <- cbind(read.table("./UCI HAR Dataset/test/subject_test.txt"),
                 read.table("./UCI HAR Dataset/test/y_test.txt"),
                 read.table("./UCI HAR Dataset/test/X_test.txt"))

trainset <- cbind(read.table("./UCI HAR Dataset/train/subject_train.txt"),
                  read.table("./UCI HAR Dataset/train/y_train.txt"),
                  read.table("./UCI HAR Dataset/train/X_train.txt"))

combinedset <- rbind(testset,
                     trainset)
rm(testset,trainset)

# In order to label the table, the labels are taken from the appropropriate files, with the
# first two columns named 'subject' and 'activity' manually.  The table is then simplified
# to the required data columns only.
names <- as.character(read.table("./UCI HAR Dataset/features.txt")[,2])
names <- gsub("[()]", "", names)
colnames(combinedset) <- c("subject",
                           "activity",
                           names)
dat <- combinedset[,grep("subject|activity|mean|std",colnames(combinedset))]
rm(combinedset,names)

# The numeric values for the activities are replaced with a descriptive string based on the 
# key in the activity labels file.
act_vect <- dat$activity
lbls <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in lbls$V1){
  act_vect[act_vect==i] <- as.character(lbls$V2[i])}
dat$activity <- act_vect
rm(act_vect, i, lbls)

# The data is then grouped by subject and activity, and the mean calculated for each pair, and
# made into a data table, which can then be written to a file.
dat %>%
  group_by(subject, activity) %>%
  summarize_each(funs(mean)) ->
  tidy
