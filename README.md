##A. OVERVIEW

####run_analysis.R:
A script that creates a tidy data set by processing and transforming a raw data set to create a tidy data set that contains the Subject ID, activity ID and all the aggregated means for each mean and standard deviation variable for each activity and each subject 

The script downloads and uncompresses the data set from an archived file[1]. The test and training data sets are processed and merged together as follows: 

* Only include fields from the original data sets that are either the mean or
standard deviations, and remove any are Frequency values
*  Combine the test and training into one data frame
* The names of the selected variables have been changed to remove any 
non-alphanumeric characters
*  Calculate the average mean and standard deviation for each subject, and activity
*  Append the string “AggMean” to show that all the numeric columns have been aggregated

run_analsis.R defines two functions: createAggMeanDataSet(), createDataSet().

####createAggMeanDataSet(): 
This function calls createDataSet(rawDataSet) twice in order to build
the tidy data set. It is also responsible for cleaning up the tidy data set’s variable names, and calculating the aggregated values. This function returns a data frame of the tidy data.

####createDataSet(rawDataSet): 
This function takes the name of a raw data set (“test”, “train) as
input and returns a new data with the columns Subject, Activity, plus the 561 columns from the original data set.

##B. Running the run_analysis.R script

There are two methods available for running this script:

1. From the command line

		Rscript run_analysis.R

The user will only have access to data set as a CSV text file (tidyDataSet.txt)
after the script completes

2. From within the R console, using the source() function

	     source(“run_analysis.R”)

The user will have access to the data set as a data frame (tidyDataSet), and a CSV
file (tidyDataSet.txt) after the script completes

Both methods assume that the script will be in the current working directory

	    

##C. Detailed Script Operation

####Main Script:

(a) Download the data set archive file

    print("Downloading data set archive...please wait")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url,"./Dataset.zip",method="curl")

(b) Extract the contents of the archive file and move into the archive’s directory

    print("Extracting data set archive...please wait")
    unzip("./Dataset.zip", exdir="./")

    setwd("UCI HAR Dataset")

(c) Build the tidy data set and save the data frame to tidyDataSet

    tidyDataSet <- createAggMeanDataSet()


(d) Go back to our original folder, save the tidy data set to a CSV file, and remove any
    variables no longer needed

    setwd("..")
    write.csv(tidyDataSet,"tidyDataSet.txt", row.names=F)
    rm(list=c("createDataSet","createAggMeanDataSet","url"))


####createAggMeanDataSet():

(a) Load the test and training data set

    testAgg <- createDataSet("test")
    trainAgg <- createDataSet("train")

(b) Join the data sets, then calculate the aggreagted means for all the columns

    datasetAgg <- rbind(testAgg,trainAgg)
    datasetAgg <- aggregate(datasetAgg[, names(datasetAgg)[3:68]], datasetAgg[1:2],mean)

(c) Tidy up the variable names -> remove “()-“, and replace “BodyBody” with “Body”

    names(datasetAgg) <- sub("\\(\\)","",names(datasetAgg))
    names(datasetAgg) <- gsub("-","",names(datasetAgg))
    names(datasetAgg) <- sub("BodyBody","Body",names(datasetAgg))

(d) Now change all the variable names to show that they are aggregated by appending "AggMean" 
    to the end of each name; and return the tidy data set

    names(datasetAgg)[3:68] <- sub("$", "AggMean", names(datasetAgg)[3:68])
    return(datasetAgg)


####createDataSet(dsName):

(a) Define paths for raw data set, Subject column, and Activity codes

    dsPath <- sprintf("%s/X_%s.txt", dsName, dsName)
    subjectPath <- sprintf("%s/subject_%s.txt", dsName, dsName)
    activityPath <- sprintf("%s/y_%s.txt", dsName, dsName)

(b) Load raw data set, Subject, and Activity data

    df <- read.table(dsPath, stringsAsFactors=F )
    dfS <- read.table(subjectPath, stringsAsFactors=F )
    dfA <- read.table(activityPath, stringsAsFactors=F )

(c) Set the column names for Subject and Activity varibales

    names(dfS) <- "Subject"
    names(dfA) <- "Activity"

(d) Set the feature column names for the raw data set

    features <- read.table("features.txt",stringsAsFactors=F)
    features <- features$V2
    names(df) <- features

(e) Select the list of variables that will be aggregated; but first remove any variables 
    that contain the string "Freq”, and only select those that contain "mean" or "std"

    aggFeatures <- grep("Freq", features, invert=T, value=T)
    aggFeatures <- grep("mean|std", aggFeatures,value=T)

(f) Create the data frame with the variables that we are going to aggregate

    aggDF <- df[, aggFeatures]

(g) Get the labels for the activity codes

    actlabel <- read.table("activity_labels.txt")

(h) Let's start building our tidy data set: add Subject column and Activity columns
	
    df <- dfS
    df[ "Activity" ] <- actlabel$V2[ dfA$Activity ]

(i) Add the columns that were subset and return the new data set

    return( cbind(df, aggDF) )

##D. REFERENCES

[1] https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
