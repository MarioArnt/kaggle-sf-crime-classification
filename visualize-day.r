library(stringr)
library(ggplot2)

crimeDay <- function (train, CrimeCategory, granularity) {
  crime <- subset(train, Category==CrimeCategory)
  pattern <- "^[0-9]{4}-[0-9]{2}-([0-9]{2}) [0-9]{2}:[0-9]{2}:[0-9]{2}"
  matches <- str_match(crime$Dates, pattern)
  crime["Day"] <- as.integer(matches[,2])
  qplot(Day, data=crime, geom="histogram", binwidth=granularity)
}
