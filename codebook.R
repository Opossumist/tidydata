# This script generates the codebook. Assuming that this file is in the same directory as run_analysis.R
# and that features.txt still contains similar descriptions of the original data.  It will produce
# a table that is meant to be read in markdown.
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