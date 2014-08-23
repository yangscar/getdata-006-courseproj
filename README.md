getdata-006-courseproj
======================

# Intro

This file introduces the work flow of "run_analysis.R".

There are 5 things should be done as follow:

# 1. Merges the training and the test sets to create one data set.

I download the dataset to the "Dataset" folder, and use "read.table" function loads all the data seperately for test and train data.

Then I use "rbind" combine the test and train data, use cbind add subject, y value and activity type columns. 
Thus we merge all the data to a big data set "Big Data".

PA: Here I load the features information and use "names" to add names to each column. 
Since I think consistency is important and the names in "features.txt" are clear enough, I did not change the column name.

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

Here I use a regrex pattern to find the mean and std columns ("(std[[:punct:]])|(mean[[:punct:]])"). 
Names with "meanFreq" were excluded by this pattern, only names contain "mean()" or "std()" were included.
Then I take a subset of the "Big data" according to the columns found before.


# 3. Uses descriptive activity names to name the activities in the data set

First, we load the "activity_labels.txt" and get a table with two columns: activity code, activity name. 
Then we use "merge" to merge this table and the subet table we get in step 2 according to the activity code.
Thus we change the activity code to descriptive activity names.

# 4. Appropriately labels the data set with descriptive variable names. 
I labeled them in step 1 :) according to the features.txt (see Step1 PA) .

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here I use the "aggregate" function calculate the mean of each group that grouped by (subject and activity type).
