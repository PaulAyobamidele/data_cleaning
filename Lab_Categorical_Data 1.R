
# --- Section 1: Basics ---

# Install / load useful packages

#Check which packages you already have by trying to load them. You will get an error message if you do not have the package
library(titanic)
library(dplyr)
library(ggplot2)
?titanic



#Use this line if you want install multiple packages
install.packages(c("titanic", "dplyr", "ggplot2"))
#Or this one if you have just one missing
install.packages('titanic')


#the titanic package has the dataset
#ggplot2 will be used for plotting the graphs
#dplyr is a powerful package for manipulating datasets



#load the dataset
data("titanic_train")
#When you are working with real datasets, you need to know the explanation for each variable. If you find a datset online, make sure to read the documentation that comes with it.
#Since we loaded this one from a library, you can use the ? to learn more
?titanic_train
#? works to learn more about R base functions or those you got from libraries !






# Let's explore the Dataset
#Head will show the first 6 observations
head(titanic_train)
#Since we have so many variables, it is not very clear. 
#What about a quick visual inspection?
View(titanic_train)
#You can look at the different variable values and match them to descriptions from the documentation to make sure you understand them.



#This doesn't tell you anything however about the class or types of variables you have.
#Let's try structure
str(titanic_train)
#Here you can see that some variables are considered integers, others characters, or just numerical.
#This is important. For example, we know that sex is categorical, the 2 categories being male and female (the people in the titanic did not identify as they/them for all we know)
#however, R considers it as character. we will have to change that later.



#Another useful function is the summary that gives a basic description of all variables.
summary(titanic_train)
#the numerical variables will summarized using min, mean, median...
#Here the categorical variables are not correctly identified as so
#this also serves to show missing values (NA) which we will also have to deal with.







# --- Section 2: You explore ---

#From here on out, I want you to use your knowledge or the internet, including chatGPT to answer the questions. this should be easy since GPT already knows this dataset ! 
#Coding is all about learning to solve problems. So as I guide you through the steps of what to do, I will let you figure out for now how to do it.

#please insert your code to answer each question. make sure you run it beforehand to see if it works :) 

#Cleaning the data
#1.1. Which variable(s) has missing values?


#1.2 Drop all missing values from the dataset.


#1.3 Change misidentified character variables into categorical variables 





#Let's dive into exploring the reasons for survival

#SEX
#2.1 Were there more male or female survivors?


#2.2 #2.2 Using ggplot2, show a barplot showing the count female/male by survivor/non survivors


#MOTIVATION/COMFORT FROM FAMILY
#3 Were there more survivors amongst the people who had more family members?



#AGE
#4.1 What's the mean age of survivors ?


#4.2 What do you conclude from that ?


#4.3 Categorize people by age (3, 4, 5 categories.. whatever you want). Using ggplot 2, show how many from each category survived/did not survive


#CONCLUSION
#5. You can run any other analyses. According to you, what were the characteristics of survivors?





