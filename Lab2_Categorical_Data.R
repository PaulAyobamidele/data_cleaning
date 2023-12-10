library(titanic)
library(dplyr)
library(ggplot2)

data("titanic_train")



# Cleaning the data
# 1.1. Which variable(s) has missing values?

names(which(colSums(is.na(titanic_train)) > 0))


# curiously however, if we look at Embarked..
table(titanic_train$Embarked)

# or worse
table(titanic_train$Cabin)
sum(titanic_train$Cabin == "")


# There are still "missing values" !
# And that's because an empty string ("") is not considered a missing value
# Pay attention to how your data is formatted by checking the summary carefully, especially when it comes to variables of interest. Luckily, we're not too interested in the Cabin here.



# 1.2 Drop all missing values from the dataset.
# Since this is just us training, we won't care too much about the missing values. Next time, we will :)
titanic_train <- na.omit(titanic_train)



# 1.3 Change misidentified character variables into categorical variables
titanic_train$Sex <- as.factor(titanic_train$Sex)
titanic_train$Embarked <- as.factor(titanic_train$Embarked)
# I'll also change the name of survived for readability
titanic_train$Survived <- factor(titanic_train$Survived, levels = c(0, 1), labels = c("No", "Yes"))





# Let's dive into exploring the reasons for survival

# SEX
# 2.1 Were there more male or female survivors?
sex_survival_count <- table(titanic_train$Sex, titanic_train$Survived)
sex_survival_count

# no margin will give overall proportion (number/total)
prop.table(sex_survival_count)

# margin = 1 calculates proportion in relation to the same Row
# For example, in the first row, 0.15 means that out of that row (so out of all females), the proportion of those in the "no" column (or the proportion of those who died) is 15%
prop.table(sex_survival_count, margin = 1)

# margin = 2 calculates proportion in relation to the same Column
prop.table(sex_survival_count, margin = 2)

# def more female survivors

# 2.2 Using ggplot2, plot a barplot showing the count of female/male by survivor/non survivors
ggplot(titanic_train, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "dodge", stat = "count") +
  labs(title = "Survival by Gender", x = "Gender", y = "Count")



# MOTIVATION/COMFORT FROM FAMILY
# 3 Were there more survivors among the people who had more family members?
# Let's create a new variable taking into account all family members on board
titanic_train$FamilyMembers <- titanic_train$SibSp + titanic_train$Parch
family_survival_count <- table(titanic_train$FamilyMembers, titanic_train$Survived)
# Let's see what this table says
family_survival_count

# Very unclear, let's try plotting it out instead
ggplot(titanic_train, aes(x = as.factor(FamilyMembers), fill = Survived)) +
  geom_bar(position = "dodge", stat = "count") +
  labs(
    title = "Survival by Number of Family Members",
    x = "Number of Family Members",
    y = "Count"
  ) +
  scale_x_discrete(labels = function(x) ifelse(as.integer(x) %% 2 == 0, x, ""))

# It seems that there were more deaths for those with no family members (0), and there were more survivors among people who had 1-3 family members.


# AGE
# 4.1 What's the mean age of survivors ?
mean_age_survivors <- mean(titanic_train$Age[titanic_train$Survived == "Yes"])
mean_age_survivors






# 4.2 What do you conclude from that ?
# We can only conclude the value of the mean age of survivors... 28.34


# 4.3 Categorize people by age (3, 4, 5 categories.. whatever you want). Using ggplot 2, show how many from each category survived/did not survive

titanic_train$AgeCategory <- cut(titanic_train$Age,
  breaks = c(0, 18, 30, 50, Inf),
  labels = c("0-18", "18-30", "30-50", "50+")
)



ggplot(titanic_train, aes(x = AgeCategory, fill = Survived)) +
  geom_bar(position = "dodge", stat = "count") +
  labs(title = "Survival by Age Category", x = "Age Category", y = "Count")




# I think that is too broad since in all emergency situations there is a women and babies first policy. I will create a category showing that clearly
titanic_train$AgeCategory <- cut(titanic_train$Age,
  breaks = c(0, 5, 18, 30, 50, Inf),
  labels = c("babies", "teens", "young adults", "adults", "seniors")
)

ggplot(titanic_train, aes(x = AgeCategory, fill = Survived)) +
  geom_bar(position = "dodge", stat = "count") +
  labs(title = "Survival by Age Category", x = "Age Category", y = "Count") +
  facet_grid(. ~ Sex)


# Indeed it seems more babies survived regardless of sex, but overall, females in all age categories had more survivors than men





# 5. According to you, what were the characteristics of survivors?
# You cannot conclude from looking at averages and plots. They could give you great ideas and a strong hunch, but statistically significant conclusions are drawn from tests and models.. since you in the next lab !
