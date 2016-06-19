# Code Book for the "Getting and Cleaning Data" Course Project

## Transformations

- The training and testing data sets: I used the dplyr, tidyr, and stringr packages for my transformations. Here are the steps I used to get the "merged.data" data frame:
  - combined the activity and subject information into one data frame for both the test and train data sets
  - Created a "features.std.means" data frame that contains information like the original variable name, column position, and the more descriptive name for all of the variables that measures means and standard deviations.
  - I used the variables identified in the step above to select the columns I needed in the train and test data sets
  - I merged the train and test data frame into one data frame
  
- The final "tidy" data set:
  - I took the data set from above and used the "group by" verb to reduce the data set to unique "activity" and "subject id combinations
  - I used the "summarise" function from the dplyr package to calculate the mean of all of the variables 
  

## merged.data Data Frame Variables

activity
phase
subject.id
row.id
body angular velocity jerk magnitude frequency domain signals std
body angular velocity jerk magnitude frequency domain signals mean
body angular velocity magnitude frequency domain signals std
body angular velocity magnitude frequency domain signals mean
body acceleration jerk magnitude frequency domain signals std
body acceleration jerk magnitude frequency domain signals mean
body accelaration magnitude frequency domain signals std
body accelaration magnitude frequency domain signals mean
body angular velocity frequency domain signals std Z
body angular velocity frequency domain signals std Y
body angular velocity frequency domain signals std X
body angular velocity frequency domain signals mean Z
body angular velocity frequency domain signals mean Y
body angular velocity frequency domain signals mean X
body acceleration jerk frequency domain signals std Z
body acceleration jerk frequency domain signals std Y
body acceleration jerk frequency domain signals std X
body acceleration jerk frequency domain signals mean Z
body acceleration jerk frequency domain signals mean Y
body acceleration jerk frequency domain signals mean X
body acceleration frequency domain signals std Z
body acceleration frequency domain signals std Y
body acceleration frequency domain signals std X
body acceleration frequency domain signals mean Z
body acceleration frequency domain signals mean Y
body acceleration frequency domain signals mean X
body angular velocity jerk magnitude std
body angular velocity jerk magnitude mean
body angular velocity magnitude std
body angular velocity magnitude mean
body acceleration jerk magnitude std
body acceleration jerk magnitude mean
gravity acceleration magnitude std
gravity acceleration magnitude mean
body acceleration magnitude std
body acceleration magnitude mean
angular velocity jerk signal std Z
angular velocity jerk signal std Y
angular velocity jerk signal std X
angular velocity jerk signal mean Z
angular velocity jerk signal mean Y
angular velocity jerk signal mean X
body angular velocity std Z
body angular velocity std Y
body angular velocity std X
body angular velocity mean Z
body angular velocity mean Y
body angular velocity mean X
body acceleration jerk signal std Z
body acceleration jerk signal std Y
body acceleration jerk signal std X
body acceleration jerk signal mean Z
body acceleration jerk signal mean Y
body acceleration jerk signal mean X
gravity acceleration signal std Z
gravity acceleration signal std Y
gravity acceleration signal std X
gravity acceleration signal mean Z
gravity acceleration signal mean Y
gravity acceleration signal mean X
body acceleration signal std Z
body acceleration signal std Y
body acceleration signal std X
body acceleration signal mean Z
body acceleration signal mean Y
body acceleration signal mean X

## activity.subject.average Data Frame Variables

activity
phase
subject.id
avg body angular velocity jerk magnitude frequency domain signals std
avg body angular velocity jerk magnitude frequency domain signals mean
avg body angular velocity magnitude frequency domain signals std
avg body angular velocity magnitude frequency domain signals mean
avg body acceleration jerk magnitude frequency domain signals std
avg body acceleration jerk magnitude frequency domain signals mean
avg body accelaration magnitude frequency domain signals std
avg body accelaration magnitude frequency domain signals mean
avg body angular velocity frequency domain signals std Z
avg body angular velocity frequency domain signals std Y
avg body angular velocity frequency domain signals std X
avg body angular velocity frequency domain signals mean Z
avg body angular velocity frequency domain signals mean Y
avg body angular velocity frequency domain signals mean X
avg body acceleration jerk frequency domain signals std Z
avg body acceleration jerk frequency domain signals std Y
avg body acceleration jerk frequency domain signals std X
avg body acceleration jerk frequency domain signals mean Z
avg body acceleration jerk frequency domain signals mean Y
avg body acceleration jerk frequency domain signals mean X
avg body acceleration frequency domain signals std Z
avg body acceleration frequency domain signals std Y
avg body acceleration frequency domain signals std X
avg body acceleration frequency domain signals mean Z
avg body acceleration frequency domain signals mean Y
avg body acceleration frequency domain signals mean X
avg body angular velocity jerk magnitude std
avg body angular velocity jerk magnitude mean
avg body angular velocity magnitude std
avg body angular velocity magnitude mean
avg body acceleration jerk magnitude std
avg body acceleration jerk magnitude mean
avg gravity acceleration magnitude std
avg gravity acceleration magnitude mean
avg body acceleration magnitude std
avg body acceleration magnitude mean
avg angular velocity jerk signal std Z
avg angular velocity jerk signal std Y
avg angular velocity jerk signal std X
avg angular velocity jerk signal mean Z
avg angular velocity jerk signal mean Y
avg angular velocity jerk signal mean X
avg body angular velocity std Z
avg body angular velocity std Y
avg body angular velocity std X
avg body angular velocity mean Z
avg body angular velocity mean Y
avg body angular velocity mean X
avg body acceleration jerk signal std Z
avg body acceleration jerk signal std Y
avg body acceleration jerk signal std X
avg body acceleration jerk signal mean Z
avg body acceleration jerk signal mean Y
avg body acceleration jerk signal mean X
avg gravity acceleration signal std Z
avg gravity acceleration signal std Y
avg gravity acceleration signal std X
avg gravity acceleration signal mean Z
avg gravity acceleration signal mean Y
avg gravity acceleration signal mean X
avg body acceleration signal std Z
avg body acceleration signal std Y
avg body acceleration signal std X
avg body acceleration signal mean Z
avg body acceleration signal mean Y
avg body acceleration signal mean X
