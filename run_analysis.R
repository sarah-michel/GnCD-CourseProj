#---------------------------#
#  ___ run_analysis.R ___   #     |\____/\
# Sarah Michel              #     / ,o  o ;
# Coursera                  #   ==:. / Y\ :=
# Getting & Cleaning Data   #     \ `\ w/'/
# 2015-08-22                #     /       \
#---------------------------#

# By default, looks for folder in its working directory.
    src <- paste(getwd(),"UCI HAR Dataset",sep="/")

# If needed, uncomment the below to point it to your own directory location.
    # src <- "YOUR_SOURCE_PATH_HERE"

# read in train and test data & features
    x_train <- read.table(paste(src,"train","x_train.txt",sep="/"))
    y_train <- read.table(paste(src,"train","y_train.txt",sep="/"))
    sub_train <- read.table(paste(src,"train","subject_train.txt",sep="/"))
    x_test <- read.table(paste(src,"test","x_test.txt",sep="/"))
    y_test <- read.table(paste(src,"test","y_test.txt",sep="/"))
    sub_test <- read.table(paste(src,"test","subject_test.txt",sep="/"))
    features <- read.table(paste(src,"features.txt",sep="/"))

# 1. merge the training and test sets to create one data set
    dat <- rbind(cbind(sub_train,y_train,x_train),cbind(sub_test,y_test,x_test))

# 4. appropriately label the data set with descriptive variable names
    names(dat) <- c("subject_id","activity_id",as.character(features$V2))

# clean up
    rm(list=c("x_train","y_train","sub_train","x_test","y_test","sub_test","features"))

# 2. extract only the measurements on the mean and standard deviation for each measurement
    dat <- dat[,c(1,2,grep("mean\\(\\)|std\\(\\)",names(dat)))]

# read activity labels
    act_lab <- read.table(paste(src,"activity_labels.txt",sep="/"),stringsAsFactors=FALSE)
    names(act_lab) <- c("activity_id","activity_name")

# 3. use descriptive activity names to name the activities in the data set    
    dat <- merge(dat,act_lab,by.x="activity_id",by.y="activity_id")
    dat <- dat[,c(1,ncol(dat),2:(ncol(dat)-1))] # put activity_name next to activity_id

# clean up
    rm(act_lab)
    rm(src)

# 5. from the data set in step 4, create a second, independent tidy data set with the
# average of each variable for each activity and each subject.
    datMelt <- melt(dat,id=c("subject_id","activity_id","activity_name"))
    meanDat <- dcast(datMelt, subject_id + activity_id + activity_name ~ variable,mean)

# Output result from step 5
    write.table(meanDat,file="run_analysis_output.txt",row.name=FALSE)

# clean up
    rm(list=c("datMelt","dat","meanDat"))