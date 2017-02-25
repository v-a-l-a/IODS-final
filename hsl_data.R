# Details: Noora Sheridan (noora.sheridan@aalto.fi), 24.2.2017
# In this file I do data wrangling on a dataset about Helsinki Region Transport (HSL) customer satisfaction survey.
# The dataset is openly available and was obtained from here: https://hsl.louhin.com/asty/help

# I start off by reading the data into R and  naming my dataset HSL
hsl <- read.csv("https://hsl.louhin.com/api/1.0/data/350?LWSAccessKey=b21f0e72-de32-4cee-ab24-242eeba7726b", sep = ";", header = TRUE)

# Having a quick overview of the dataset
dim(hsl)
# There are over 340 000 observations and 127 variables!

# First I keep only the variables that relate to my research question.
keep <- c("K3B", "K1A4", "K2A1", "K2A2", "T6", "T71", "T8", "T17", "T1")
library(dplyr)
hsl <- select(hsl, one_of(keep))

# I check that the datatypes of each variable seem correct (e.g. none are string)
str(hsl)
# All ar integer types, but should be categorical, so changing the datatypes except for Grade
hsl$K1A4 <- as.factor(hsl$K1A4)
hsl$K2A1 <- as.factor(hsl$K2A1)
hsl$K2A2 <- as.factor(hsl$K2A2)
hsl$T6 <- as.factor(hsl$T6)
hsl$T71 <- as.factor(hsl$T71)
hsl$T8 <- as.factor(hsl$T8)
hsl$T17 <- as.factor(hsl$T17)
hsl$T1 <- as.factor(hsl$T1)

# I still have ovr 340 000 observations but next I remove all with N/A values in any of the variables.
hsl <- filter(hsl, complete.cases(hsl) == TRUE)
dim(hsl)
# I still have 21 007 observations in my dataset, which seems enough, and values for all the 9 variables.

# Next I rename my variabls to have more easy to understand names.
colnames(hsl)[1:9] <- c("Grade", "Punctuality", "Space", "Meets_needs", "Gender", "Age", "Car", "Worth", "Frequency")
str(hsl)
# Worked! However, I notice that 'Gender' has 4 levels, not 2

summary(hsl$Gender)
# I see that there are no observations with gender level 3 ("other") or 4 ("don't want to say")

# I drop the unused levels 3 and 4 from variable 'Gender'
hsl$Gender <- factor(hsl$Gender)
summary(hsl$Gender)
# Gender now has 2 levels, and the correct number of observations in levels 1 and 2

# Lastly, I create a new column to my dataset called High_grade
hsl <- mutate(hsl, High_grade = Grade > 3)

# Final check that everything is correct
str(hsl)

# Now saving the dataset into my local folder for use in the analysis part!
write.table(hsl, file = "/Users/Noora/Documents/IODS-project/IODS-final/hsl.txt")
