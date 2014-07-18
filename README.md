The experiment data comes courtesy of:


Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


Description of data:


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 


Manipulation of Data:


first_tidy_table.txt

1. merged the x_test.txt and x_train.txt data sets to create one large data set  
2. extracted on the measurements on the mean and standard deviation for each measurement  
3. replaced the numerical representations of activies in the large data set with description names from features.txt  
4. Created appropriate labels for the large data set with descriptive variable names.  
    Example: "tBodyAcc-mean()-Y" becomes "timebodyaccelerometermeany"  

second_tidy_table.txt

1. Create a second, independent tidy data set with the average of each variable for each activity and each subject. To   accomplish this, the melt() and dcast() functions from the reshape2 package have been utilized with a dcast formula of   subject + activity ~ variable, mean



Related files:


run_analysis.R - R script that reads in all of the data files and conducts the analysis resulting in the files                             "first_tidy_table.txt" and "second_tidy_table.txt"
README.md      - An overview of where the data comes from, how the data has been manipulated, and what the outputs of the                  process are.
codebook.md    - An explanation of what the data set has: names of variables, a quick explanation of what they are, variable         types, etc.




