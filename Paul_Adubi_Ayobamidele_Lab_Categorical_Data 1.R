# --- Section 1: Basics ---

# Install / load useful packages

# Check which packages you already have by trying to load them. You will get an error message if you do not have the package
library(titanic)
library(dplyr)
library(ggplot2)
?titanic



# Use this line if you want install multiple packages
install.packages(c("titanic", "dplyr", "ggplot2"))
# Or this one if you have just one missing
install.packages("titanic")


# the titanic package has the dataset
# ggplot2 will be used for plotting the graphs
# dplyr is a powerful package for manipulating datasets



# load the dataset
data("titanic_train")
# When you are working with real datasets, you need to know the explanation for each variable. If you find a datset online, make sure to read the documentation that comes with it.
# Since we loaded this one from a library, you can use the ? to learn more
?titanic_train
# ? works to learn more about R base functions or those you got from libraries !






# Let's explore the Dataset
# Head will show the first 6 observations
head(titanic_train)
# Since we have so many variables, it is not very clear.
# What about a quick visual inspection?
View(titanic_train)
# You can look at the different variable values and match them to descriptions from the documentation to make sure you understand them.



# This doesn't tell you anything however about the class or types of variables you have.
# Let's try structure
str(titanic_train)
# Here you can see that some variables are considered integers, others characters, or just numerical.
# This is important. For example, we know that sex is categorical, the 2 categories being male and female (the people in the titanic did not identify as they/them for all we know)
# however, R considers it as character. we will have to change that later.



# Another useful function is the summary that gives a basic description of all variables.
summary(titanic_train)
# the numerical variables will summarized using min, mean, median...
# Here the categorical variables are not correctly identified as so
# this also serves to show missing values (NA) which we will also have to deal with.







# --- Section 2: You explore ---

# From here on out, I want you to use your knowledge or the internet, including chatGPT to answer the questions. this should be easy since GPT already knows this dataset !
# Coding is all about learning to solve problems. So as I guide you through the steps of what to do, I will let you figure out for now how to do it.

# please insert your code to answer each question. make sure you run it beforehand to see if it works :)

# Cleaning the data
# 1.1. Which variable(s) has missing values?

# Two functions are useful here
# is.na() and complete.cases()

# Let's start with the first function is.na()

missing_variable <- (colSums(is.na(titanic_train)))
missing_variable


# Let's now use the second function complete.cases

?complete.cases()
?sapply()

complete_case <- sapply(titanic_train, function(x) {
    sum(complete.cases(x))
})
complete_case


# OR

incomplete_rows <- titanic_train[!complete.cases(titanic_train), ]
incomplete_rows

number_incomplete_rows <- nrow(incomplete_rows)
number_incomplete_rows


# 1.2 Drop all missing values from the dataset.
?na.omit()
titanic_train <- na.omit(titanic_train)
titanic_train


# check

check_for_omission <- colSums(is.na(titanic_train))
View(check_for_omission)


# 1.3 Change misidentified character variables into categorical variables

str(titanic_train)

misidentified_character <- sapply(titanic_train, is.character)
misidentified_character

name_misidentified_character <- names(misidentified_character[misidentified_character])
name_misidentified_character

titanic_train[name_misidentified_character] <- lapply(titanic_train[name_misidentified_character], as.factor)
name_misidentified_character
titanic_train[name_misidentified_character]


# Let's dive into exploring the reasons for survival

# SEX
# 2.1 Were there more male or female survivors?
survival_table <- table(titanic_train$Survived, titanic_train$Sex)

survival_category <- c("Did not Survive", "Survive")

row.names(survival_table) <- survival_category
survival_table

male_survivors <- sum(survival_table[2, "male"])
male_survivors

female_survivors <- sum(survival_table[2, "female"])
female_survivors

if (male_survivors > female_survivors) {
    print("There were more male survivors than female survivors")
} else {
    print("There were more female survivors than male survivors")
}


# There were more female survivors than male survivors


# 2.2 #2.2 Using ggplot2, show a barplot showing the count female/male by survivor/non survivors

survival_dataframe <- as.data.frame(survival_table)

ggplot(survival_dataframe, aes(x = Var1, y = Freq, fill = Var2)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
        title = "Survival Count by Gender",
        x = "Survival Status",
        y = "Count",
        fill = "Gender"
    ) +
    scale_x_discrete(labels = c("Did not Survive", "Survived"))

# MOTIVATION/COMFORT FROM FAMILY
# 3 Were there more survivors amongst the people who had more family members?

str(titanic_train)

titanic_train$family_total <- titanic_train$SibSp + titanic_train$Parch + 1
titanic_train$family_total

titanic_train$Survived
survivor_family_table <- table(titanic_train$Survived, titanic_train$family_total)
survivor_family_table


survival_category <- c("Did not Survive", "Survive")
row.names(survivor_family_table) <- survival_category
survivor_family_table

#                    1   2   3   4   5   6   7   8
#   Did not Survive 274  63  40   6   8  19   8   6
#   Survive         130  76  53  21   3   3   4   0

survivor_family_df <- as.data.frame(survivor_family_table)

# Plot the bar chart
ggplot(survivor_family_df, aes(x = Var2, y = Freq, fill = Var2)) +
    geom_bar(stat = "identity", position = "dodge") +
    labs(
        title = "Survival Count by Family Member Count",
        x = "Family Members",
        y = "Count",
        fill = "Survival Status"
    )



# NO! There were less survivors among survivors with more family members


# AGE
# 4.1 What's the mean age of survivors ?

age <- titanic_train$Age[titanic_train$Survived == 1]
mean(age, na.rm = TRUE)
# 4.2 What do you conclude from that ?

# The average age of survivors (i.e those who survived) is 28.34369

# 4.3 Categorize people by age (3, 4, 5 categories.. whatever you want). Using ggplot 2, show how many from each category survived/did not survive

titanic_train$Age_Category <- cut(titanic_train$Age, breaks = c(0, 18, 30, 50, Inf), labels = c("0-18", "19-30", "31-50", "51+"), right = FALSE)

# Visualize with ggplot2
ggplot(titanic_train, aes(x = Age_Category, fill = factor(Survived))) +
    geom_bar(position = "dodge") +
    labs(
        title = "Survival Count by Age Category",
        x = "Age Category",
        y = "Count",
        fill = "Survived"
    )

# CONCLUSION
# 5. You can run any other analyses. According to you, what were the characteristics of survivors?


# What is the mean age of those who did not survive?

nonsurvivor <- titanic_train$Age[titanic_train$Survived == 0]
nonsurvivor

mean_of_nonsurvivor <- mean(nonsurvivor)
mean_of_nonsurvivor

# 30.62618


# What is the mean age of those who did not survive who are males?

males_nonsurvivor <- titanic_train$Age[titanic_train$Sex == "male" & titanic_train$Survived == 0]
males_nonsurvivor

mean_of_males_nonsurvivor <- mean(males_nonsurvivor)
mean_of_males_nonsurvivor


# 31.61806


# What is the mean age of those who did not survive who are females?

females_nonsurvivor <- titanic_train$Age[titanic_train$Sex == "female" & titanic_train$Survived == 0]
females_nonsurvivor

mean_of_females_nonsurvivor <- mean(females_nonsurvivor)
mean_of_females_nonsurvivor

# 25.04688
mean_age_data <- c(mean_of_males_nonsurvivor, mean_of_females_nonsurvivor)
barplot(mean_age_data, names.arg = c("Males", "Females"), col = c("light blue", "orange"), main = "Mean Age of Non-Survivors by Gender", ylab = "Mean Age", ylim = c(0, 40))



# What is the range of the male non-survivors age
range_male_non_survivors <- max(titanic_train$Age[titanic_train$Sex == "male" & titanic_train$Survived == 0]) - min(titanic_train$Age[titanic_train$Sex == "male" & titanic_train$Survived == 0])
range_male_non_survivors


# What is the range of the female non-survivors age
range_female_non_survivors <- max(titanic_train$Age[titanic_train$Sex == "female" & titanic_train$Survived == 0]) - min(titanic_train$Age[titanic_train$Sex == "female" & titanic_train$Survived == 0])
range_female_non_survivors


range_sex_age_vector <- c(range_male_non_survivors, range_female_non_survivors)

barplot(range_sex_age_vector, names.arg = c("Range of Males Age", "Range of Females Age"), col = c("Brown", "Purple"), main = "The Range of Non-Survivors Age", ylab = "Non-survivors range of age", ylim = c(0, 90))


# What is the correlation between age and fare

corr_age <- titanic_train$Age
corr_age


corr_fare <- titanic_train$Fare
corr_fare



cor(corr_age, corr_fare,
    use = "everything",
    method = c("pearson", "kendall", "spearman")
)



#  0.09606669

# This is a very weak positive correlation indicating that as the fare increase, there is some increase in age even though it is weak relationship.
