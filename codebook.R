if(!file.exists(".UCI HAR Dataset/")) {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, zipped, method = "curl")
  unzip (zipped)}

nms_org <- as.character(read.table("./UCI HAR Dataset/features.txt")[,2])
nms_new <- c("subject","activity",nms_org)
nms_org <- c(NA,NA,nms_org)
nms_new <- gsub("[()]", "", nms_new)
nms_new <- gsub("-","",nms_new)
nms_new <- tolower(nms_new)
nms_new[grep("subject|activity|mean|std", nms_new, invert = TRUE)] <- NA
units <- c()
units[grep("acc", nms_new)] <- "g"
units[grep("gyro", nms_new)] <- "rad/s"
units[length(units):length(nms_org)] <- NA
codebook <- data.frame("original"=nms_org,
                       "tidy"=nms_new,
                       "units"=units,
                       stringsAsFactors = FALSE)
codebook <- rbind(c("Original Set", "Tidy Set", "Units"),c("---","---","---"),codebook)
write.table(codebook, file = "CODEBOOK.md", quote = FALSE, sep = "|", row.names = FALSE, col.names = FALSE)
rm(nms_new, nms_org, units, codebook)