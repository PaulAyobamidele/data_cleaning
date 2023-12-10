# NORMALITY TESTS

# Before you run a linear model or any other parametric test on data (e.g t-test, ANOVA...), you need to test for the normality of your data
# This is because a lot of the underlying equations used by the models are for normal data

# For example, we can look at this built-in dataset looking at how long the odontoblast (cell that is the origin of tooth growth) of guinea pigs grow depending on the dose of Vitamin C and the method of delivery
?ToothGrowth

# load data set
data <- ToothGrowth

# Checking out the structure to udnerstand more...
str(ToothGrowth)




# -----  Visual method -----
# We can try to check for normality by looking at the distribution visually

# load ggplot for visualisations
library(ggplot2)
# Plot the histogram and look at the distributino
ggplot(data, aes(x = len)) +
  geom_histogram(binwidth = 1, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Tooth Length", x = "Tooth Length", y = "Frequency")


# This doesn't look too normally distributed, but if we miss around with the binwidth (instead of each value of tooth length having it's own bar, we group more values together; pay attention to the change in the x-axis)
ggplot(data, aes(x = len)) +
  geom_histogram(binwidth = 6, fill = "lightblue", color = "black", alpha = 0.7) +
  labs(title = "Histogram of Tooth Length", x = "Tooth Length", y = "Frequency")

# looks much better, we can have hope.
# But as you can see, this method has its limitations. We can use statistical tests that other people came up with !


# ---- Statistical method ----

# Shapiro-Wilks test is a very widely used one
shapiro.test(data$len)

# If the p-value of the test is p > 0.05, the distribution of the data is not significantly different from a normal distribution and you can assume normality



# Another useful method is plotting a qqplot to check for normality (basically comparing what the quantiles would look like if it was normally distributed vs what they actually look like now)

# plots - QQ Plot

?qqnorm()
?qqline()

qqnorm(data$len, pch = 1, frame = FALSE)
qqline(data$len, col = "salmon", lwd = 2)
# As all the points fall approximately along this reference line, we can assume normality


# Essentially we can check for normality by three methods
# 1. ... Plotting the distribution to see if it is normally distribution
# 2. ... Using the Shapiro Test shapiro.test(dataset$len)
# 3. ... qqnorm and qqline
