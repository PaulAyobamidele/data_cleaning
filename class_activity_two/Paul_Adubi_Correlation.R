# Setting the work directory


# Load the data
read_movie <- read.csv("EMdataone/class_activity_two/movies.csv")

# take a look at it
str(read_movie)


# Any variables you want to change the type for?
# ... genre

# Take a look at the variable "status"


# some movies are not released, let's get rid of them


read_movie$status <- trimws(read_movie$status)
read_movie <- read_movie[read_movie$status == "Released", ]
read_movie$status




# Create a variable year from the date variable
str(read_movie$date_x)

# changing date format


?format()
date_object <- as.Date(read_movie$date_x, "%m/%d/%Y")

year <- format(date_object, "%Y")

year
# Create a variable season from the date variable
date_object
?factor()

month <- format(date_object, "%m")
month

seasons <- factor(month, levels = c("12", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11"), labels = c("Winter", "Winter", "Winter", "Spring", "Spring", "Spring", "Summer", "Summer", "Summer", "Fall", "Fall", "Fall"))

seasons

library(tidyverse)


read_movie <-
  read_movie %>% mutate(seasons)

View(read_movie)
# Any other variables you want to remove?

factor(read_movie$genre)


# let's look at some correlations
install.packages("corrplot")
library(corrplot)

# Plot correlation of all numerical variables in the dataset you have left
str(read_movie)

your_numerical_data <- read_movie[, sapply(read_movie, is.numeric)]
your_numerical_data

# Compute the correlation matrix
cor_matrix <- cor(your_numerical_data)


# Print the full correlation matrix
corrplot(cor_matrix, method = "circle", type = "upper", order = "hclust", tl.col = "black", tl.srt = 45)



# this is some code to add the significance value of the correlation

# mat : is a matrix of data
# ... : further arguments to pass to the native R cor.test function

cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat <- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}
# matrix of the p-value of the correlation
p.mat <- cor.mtest(your_numerical_data)
p.mat
# plot
corrplot(cor_matrix,
  type = "upper", order = "hclust",
  p.mat = p.mat, sig.level = 0.01, insig = "blank"
)












col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))


col

corrplot(cor_matrix,
  method = "color", col = col(200),
  type = "upper", order = "hclust",
  addCoef.col = "black", # Add coefficient of correlation
  tl.col = "black", tl.srt = 45, # Text label color and rotation
  # Combine with significance
  p.mat = p.mat, sig.level = 0.01, insig = "blank",
  # hide correlation coefficient on the principal diagonal
  diag = FALSE
)


# Plot the budget against revenue and add the regression line of the linear relationship between them

library(ggplot2)
ggplot(read_movie, aes(budget_x, revenue)) +
  geom_point(na.rm = FALSE) +
  geom_smooth(method = "lm", se = FALSE, color = "RED")

linear_regression <- lm(revenue ~ budget_x, data = read_movie)
plot(revenue ~ budget_x, data = read_movie)
abline(linear_regression, col = "red")

# Is there a stat significant difference in budget between movies produced in different seasons?

anova <- aov(budget_x ~ seasons, data = read_movie)

anova
# BONUS: Is there a statistically significant difference in revenue of movies from different countries?
# Hint: There are too many countries, you can try the regions :)

head(read_movie$country)

print(unique(read_movie$country))

# "AU" - Australia (Oceania)
# "US" - United States (North America)
# "MX" - Mexico (North America)
# "GB" - United Kingdom (Europe)
# "CL" - Chile (South America)
# "NO" - Norway (Europe)
# "ES" - Spain (Europe)
# "AR" - Argentina (South America)
# "KR" - South Korea (Asia)
# "HK" - Hong Kong (Asia)
# "UA" - Ukraine (Europe)
# "IT" - Italy (Europe)
# "RU" - Russia (Europe / Asia)
# "CO" - Colombia (South America)
# "DE" - Germany (Europe)
# "JP" - Japan (Asia)
# "FR" - France (Europe)
# "FI" - Finland (Europe)
# "IS" - Iceland (Europe)
# "ID" - Indonesia (Asia)
# "BR" - Brazil (South America)
# "BE" - Belgium (Europe)
# "DK" - Denmark (Europe)
# "TR" - Turkey (Europe / Asia)
# "TH" - Thailand (Asia)
# "PL" - Poland (Europe)
# "GT" - Guatemala (North America)
# "CN" - China (Asia)
# "CZ" - Czech Republic (Europe)
# "PH" - Philippines (Asia)
# "ZA" - South Africa (Africa)
# "CA" - Canada (North America)
# "NL" - Netherlands (Europe)
# "TW" - Taiwan (Asia)
# "PR" - Puerto Rico (North America)
# "IN" - India (Asia)
# "IE" - Ireland (Europe)
# "SG" - Singapore (Asia)
# "PE" - Peru (South America)
# "CH" - Switzerland (Europe)
# "SE" - Sweden (Europe)
# "IL" - Israel (Asia)
# "DO" - Dominican Republic (North America)
# "VN" - Vietnam (Asia)
# "GR" - Greece (Europe)
# "SU" - Soviet Union (historical reference, no longer exists)
# "HU" - Hungary (Europe)
# "BO" - Bolivia (South America)
# "SK" - Slovakia (Europe)
# "UY" - Uruguay (South America)
# "BY" - Belarus (Europe)
# "AT" - Austria (Europe)
# "PY" - Paraguay (South America)
# "MY" - Malaysia (Asia)
# "MU" - Mauritius (Africa)
# "LV" - Latvia (Europe)
# "XC" - Not recognized as a standard country code (please verify)
# "KH" - Cambodia (Asia)
# "IR" - Iran (Asia)


country_short <- c(unique(read_movie$country))

country_short
typeof(country_short)

load_continent_with_country <- list(
  Africa = c("ZA", "CI", "EG", "KE", "MG", "MU", "MA", "NG", "RW", "SN", "ZA", "TZ", "UG"),
  Asia = c("CN", "IN", "JP", "KR", "MY", "PH", "SG", "TW", "TH", "VN", "HK", "ID", "KH", "IR"),
  Europe = c("AT", "BE", "BY", "CZ", "DK", "FI", "FR", "DE", "GR", "HU", "IS", "IE", "IT", "LV", "NL", "NO", "PL", "PT", "RU", "SK", "ES", "SE", "CH", "TR", "UA", "GB"),
  NorthAmerica = c("CA", "US", "MX"),
  Oceania = c("AU", "FJ", "NZ"),
  SouthAmerica = c("AR", "BO", "BR", "CL", "CO", "EC", "PY", "PE", "UY", "VE")
)


read_movie$Region <- sapply(read_movie$country, function(country) {
  for (continent in names(load_continent_with_country)) {
    if (country %in% load_continent_with_country[[continent]]) {
      return(continent)
    }
  }
  return("Other")
})

read_movie$Region

View(read_movie)

anova2 <- aov(revenue ~ Region, data = read_movie)
anova2


# Bonus Bonus : Can you think of any other fun things you want to explore? Some thing with the actor, genre...


ggplot(read_movie, aes(x = Region, y = revenue)) +
  geom_boxplot()
