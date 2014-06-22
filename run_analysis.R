# Function: createDataSet
#
# input	  : dsName - a character vector name for chosen data set; it is also the name of the directory where the data set lives
#			valid values are dsName are 'test' or train
# output  : a data frame that holds the chosen raw data set
#

createDataSet <- 
function(dsName)
{
	# Define paths for raw data set, Subject column, and Activity codes
	dsPath <- sprintf("%s/X_%s.txt", dsName, dsName)
	subjectPath <- sprintf("%s/subject_%s.txt", dsName, dsName)
	activityPath <- sprintf("%s/y_%s.txt", dsName, dsName)
	
	# Load raw data set
	df <- read.table(dsPath, stringsAsFactors=F )

	# Load data for Subject column
	dfS <- read.table(subjectPath, stringsAsFactors=F )

	# Load data for Activity column
	dfA <- read.table(activityPath, stringsAsFactors=F )
	
	# Set the column names for Subject and Activity varibales
	names(dfS) <- "Subject"
	names(dfA) <- "Activity"

	# Set the feature column names for the raw data set
	features <- read.table("features.txt",stringsAsFactors=F)
	features <- features$V2
	names(df) <- features
	
	# Select the list of variables that will be aggreagted
	# First remove any variables that contain the string "Freq"
	aggFeatures <- grep("Freq", features, invert=T, value=T)
	# Only select those that contain "mean" or "std"
	aggFeatures <- grep("mean|std", aggFeatures,value=T)

	# Create the data frame with the variables that we are going to aggregate
	aggDF <- df[, aggFeatures]
	
	# Get the labels for the activity codes
	actlabel <- read.table("activity_labels.txt")

	# Let's start building our tidy data set
	# Add Subject column
	df <- dfS
	
	# Add Activity column
	df[ "Activity" ] <- actlabel$V2[ dfA$Activity ]
	
	# Add the columns that were subset and return the new data set
	return( cbind(df, aggDF) )
}


# Function: createAggMeanDataSet
#
# input	  : None
# output  : a data frame that holds the tidy data set
#
createAggMeanDataSet <- 
function()
{
	print("Create the new data set for the test subjects")
	testAgg <- createDataSet("test")
	
	print("Create the new data set for the train subjects")
	trainAgg <- createDataSet("train")
	
	# Join the data sets, then calculate the aggreagted means for all the columns
	datasetAgg <- rbind(testAgg,trainAgg)
	datasetAgg <- aggregate(datasetAgg[, names(datasetAgg)[3:68]], datasetAgg[1:2],mean)
	
	# Tidy up the variable names -> remove "()-", and replace "BodyBody" with "Body"

	names(datasetAgg) <- sub("\\(\\)","",names(datasetAgg))
	names(datasetAgg) <- gsub("-","",names(datasetAgg))
	names(datasetAgg) <- sub("BodyBody","Body",names(datasetAgg))

	# Now change all the variable names to show that they are aggregated
	# by appending "AggMean" to the end of each name

	names(datasetAgg)[3:68] <- sub("$", "AggMean", names(datasetAgg)[3:68])
	return(datasetAgg)
}

#
#####################################   M A I N   ###########################################
#
#
# Download data set archive
print("Downloading data set archive...please wait")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"./Dataset.zip",method="curl")

# Extract data set from archive zip file. The root folder for the
# archive will be "UCI HAR Dataset"

print("Extracting data set archive...please wait")
unzip("./Dataset.zip", exdir="./")

# Move into Data set working directory
setwd("UCI HAR Dataset")

# Build the tidy data set
tidyDataSet <- createAggMeanDataSet()

# Return home
setwd("..")

# Save data set to a CSV file
write.csv(tidyDataSet,"tidyDataSet.txt", row.names=F)

# Tidy up the user's R environment by removing uneeded variables
rm(list=c("createDataSet","createAggMeanDataSet","url"))

print("Tidy data set build complete...")
print("Copies of tidy data are in the data frame tidyDataSet,")
print("and the text file tidyDataSet.txt")





