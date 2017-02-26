# Details: Noora Sheridan (noora.sheridan@aalto.fi), 24.2.2017
# In this file I do data wrangling on a dataset about Helsinki Region Transport (HSL) customer satisfaction survey.
# The dataset is openly available and was obtained from here: https://hsl.louhin.com/asty/help

# I start off by reading the data into R and  naming my dataset HSL
hsl <- read.csv("https://hsl.louhin.com/api/1.0/data/350?LWSAccessKey=b21f0e72-de32-4cee-ab24-242eeba7726b", sep = ";", header = TRUE)

# Having a quick overview of the dataset
dim(hsl)
# There are over 340 000 observations and 127 variables!

# First I keep only the variables that relate to my research question.
keep <- c("K3B", "K1A1", "K1A4", "K2A1", "K2A2", "T17", "K1A5", "K2A4")
library(dplyr)
hsl <- select(hsl, one_of(keep))

# I still have ovr 340 000 observations but next I remove all with N/A values in any of the variables.
hsl <- filter(hsl, complete.cases(hsl) == TRUE)
dim(hsl)
# I still have 16 689 observations in my dataset, which seems enough, and values for all the 8 variables.

# Next I rename my variabls to have more easy to understand names.
colnames(hsl)[1:8] <- c("Grade", "Customer_service", "Punctuality", "Space", "Meets_needs", "Worth", "Tidyness", "Changing")
str(hsl)
# Worked!

# I create a new column to my dataset called High_grade, and drop the 'Grade' column
hsl <- mutate(hsl, High_grade = Grade > 3)
keep2 <- c("Customer_service", "Punctuality", "Space", "Meets_needs", "Worth", "Tidyness", "Changing", "High_grade")
hsl <- select(hsl, one_of(keep2))

# Makin Worth into categorical and naming the levels
hsl$Worth <- factor(hsl$Worth, levels = c(1,2), labels = c("yes", "no"))

# Checking that everything is ok
str(hsl)
# Seems good!
    
# Now saving the dataset into my local folder for use in the analysis part!
write.table(hsl, file = "/Users/Noora/Documents/IODS-project/IODS-final/create_hsl.txt")
