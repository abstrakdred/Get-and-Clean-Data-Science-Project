The tidy data set was generated from the research data collected for a study on Human Activity Recognition Using Smartphones Dataset [1].

The new data set contains the Subject ID, Activity label, and all the aggregated means for each mean and standard deviation value from the original raw data sets.


##TABLE 1: Variable Names for the Tidy Data Set

            {1}  Subject
            {2}  Activity
            {3}  tBodyAccmeanXAggMean    
            {4}  tBodyAccmeanYAggMean
            {5}  tBodyAccmeanZAggMean
            {6}  tBodyAccstdXAggMean        
            {7}  tBodyAccstdYAggMean
            {8}  tBodyAccstdZAggMean
            {9}  tGravityAccmeanXAggMean        
            {10} tGravityAccmeanYAggMean
            {11} tGravityAccmeanZAggMean
            {12} tGravityAccstdXAggMean
            {13} tGravityAccstdYAggMean
            {14} tGravityAccstdZAggMean
            {15} tBodyAccJerkmeanXAggMean    
            {16} tBodyAccJerkmeanYAggMean
            {17} tBodyAccJerkmeanZAggMean
            {18} tBodyAccJerkstdXAggMean
            {19} tBodyAccJerkstdYAggMean
            {20} tBodyAccJerkstdZAggMean
            {21} tBodyGyromeanXAggMean     
            {22} tBodyGyromeanYAggMean
            {23} tBodyGyromeanZAggMean
            {24} tBodyGyrostdXAggMean    
            {25} tBodyGyrostdYAggMean
            {26} tBodyGyrostdZAggMean
            {27} tBodyGyroJerkmeanXAggMean      
            {28} tBodyGyroJerkmeanYAggMean
            {29} tBodyGyroJerkmeanZAggMean
            {30} tBodyGyroJerkstdXAggMean    
            {31} tBodyGyroJerkstdYAggMean
            {32} tBodyGyroJerkstdZAggMean
            {33} tBodyAccMagmeanAggMean    
            {34} tBodyAccMagstdAggMean
            {35} tGravityAccMagmeanAggMean
            {36} tGravityAccMagstdAggMean   
            {37} tBodyAccJerkMagmeanAggMean
            {38} tBodyAccJerkMagstdAggMean
            {39} tBodyGyroMagmeanAggMean   
            {40} tBodyGyroMagstdAggMean
            {41} tBodyGyroJerkMagmeanAggMean
            {42} tBodyGyroJerkMagstdAggMean
            {43} fBodyAccmeanXAggMean
            {44} fBodyAccmeanYAggMean
            {45} fBodyAccmeanZAggMean        
            {46} fBodyAccstdXAggMean
            {47} fBodyAccstdYAggMean
            {48} fBodyAccstdZAggMean          
            {49} fBodyAccJerkmeanXAggMean
            {50} fBodyAccJerkmeanYAggMean
            {51} fBodyAccJerkmeanZAggMean    
            {52} fBodyAccJerkstdXAggMean
            {53} fBodyAccJerkstdYAggMean
            {54} fBodyAccJerkstdZAggMean     
            {55} fBodyGyromeanXAggMean
            {56} fBodyGyromeanYAggMean
            {57} fBodyGyromeanZAggMean       
            {58} fBodyGyrostdXAggMean
            {59} fBodyGyrostdYAggMean
            {60} fBodyGyrostdZAggMean        
            {61} fBodyAccMagmeanAggMean
            {62} fBodyAccMagstdAggMean
            {63} fBodyAccJerkMagmeanAggMean 
            {64} fBodyAccJerkMagstdAggMean
            {65} fBodyGyroMagmeanAggMean
            {66} fBodyGyroMagstdAggMean 
            {67} fBodyGyroJerkMagmeanAggMean
            {68} fBodyGyroJerkMagstdAggMean



##KEYS

    Subject	      	- identifier of the subject who carried out the experiment: 
				  subject values range from 1 to 30
    Activity	      	- activity label: 
			  (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)


The remaining variables are aggregated values representing the average of each of the mean variables in the raw data set: for each mean there is an aggregated average(mean) for each subject and activity which gives 30 subjects by 6 activity aggregated rows. 

The variables in the tidy data set use the same naming convention as the raw data set, although all the non-alphanumeric characters have been stripped out for the tidy data set:

        f			    - frequency domain signal
        t			    - time domain signal

        BodyAcc		    - Body Acceleration
        GravityAcc		- Gravity Acceleration
        BodyAccJerk		- body Jerk signal
        BodyGyro		    - gyroscope data
        BodyAccMag		- Magnitude
        GravityAccMag	- Gravity Acceleration
        BodyAccJerkMag	- Body Acceleration Jerk Magnitude
        BodyGyroMag		- gyroscope Magnitude
        BodyGyroJerkMag	- gyroscope Jerk Magnitude

        XZY			    - Axial direction, a variable will refer to X, Y, or Z
        mean			    - mean value
        std			    - standard deviation value
        AggMean		    - Average of the mean value


##EXAMPLE

    Subject Activity tBodyAccmeanXAggMean

          1   LAYING            0.2215982
          2   LAYING            0.2813734
          3   LAYING            0.2755169
          4   LAYING            0.2635592
          5   LAYING            0.2783343
          6   LAYING            0.2486565

The sample output above shows the first six subjects for one of the activities, and the associated aggregated variable. Row one shows that the aggregated mean for subject 1 performing the ‘LAYING activity is 0.2215982.

  Using variable {3}, i.e. tBodyAccmeanXAggMean, from an example above:

   t 		       - the value was extracted from a time domain signal
   BodyAcc	       - body acceleration
   mean	               - mean() was applied to  was a mean value
   X 		       - Axis X
   AggMean	       - aggregated value from a set of raw mean values from a subject and activity

Further information on the naming convention can be seen in features_info.txt[2]. 		

##REFERENCES

[1] README.txt: Included in the original compressed data set file that was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[2]features_info.txt: Included in the original compressed data set file that was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

