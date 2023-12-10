read_data_one <- read.csv("data1.csv")
read_data_one

View(read_data_one)

install.packages("readxl")
library(readxl)

read_data_two <- read_excel("data3.xls")
read_data_two

View(read_data_two)


read_data_three <- read.table("data2.txt", header = TRUE, sep = ",")
read_data_three


View(read_data_three)



library(readr)

read_data_four <- read_table("http://courses.washington.edu/b517/Datasets/string.txt")
read_data_four


?which()


?has.missing()




data3 <- read_excel("class_activity/data3.xls")
typeof(data3)
View(data3)


data3$Weight

# Check for NA values in the "Weight" column
na_indices <- is.na(data3$Weight)

# Replace NA values with 2
data3$Weight[na_indices] <- 2
View(data3$Weight)
# Find the mean of the weight of all balls
# Find the mean of the weight of volleyballs
# Find the mean of the weight of footballs


# allballs <- c(data3$Weight)
# allballs
# mean_all_balls <- mean(allballs, na.rm = TRUE)
# mean_all_balls


# # 2.2


# volleyballs <- c(data3$Weight[data3$ball_type == "Volleyball"])
# volleyballs
# mean_weight_of_volleyballs <- mean(volleyballs, na.rm = TRUE)
# mean_weight_of_volleyballs


# # 2.428571

# footballs <- c(data3$Weight[data3$ball_type == "Football"])
# footballs

# mean_weight_of_footballs <- mean(footballs, na.rm = TRUE)
# mean_weight_of_footballs


# # 2.153846
