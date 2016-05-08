# This script generates the codebook. Assuming that this file is in the same directory as run_analysis.R
# and that features.txt still contains similar descriptions of the original data.
nms_org <- as.character(read.table("./UCI HAR Dataset/features.txt")[,2])
nms_new <- c("subject","activity",nms_org)
nms_org <- c(NA,NA,nms_org)
nms_new <- gsub("[()]", "", nms_new)
nms_new[grep("subject|activity|mean|std", nms_new, invert = TRUE)] <- NA
units <- c()
units[grep("Acc", nms_new)] <- "g"
units[grep("Gyro", nms_new)] <- "rad/s"
units[length(units):length(nms_org)] <- NA
codebook <- data.frame("original set"=nms_org,"tidy set"=nms_new, "units"=units)