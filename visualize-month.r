library(readr)
library(stringr)
library(dplyr)
library(ggplot2)


#Extract subset by filtering according to the selected crime
crimeMonth <- function (train, CrimeCategory, granularity) {
#First month of the training set
#2003-01-06 => 1
#(YYYY-2003)*12 + MM
##e.g 01-2005 => 25
##e.g 08-2006 => 3*12 + 8 => 44
##e.g 05-2015 => 12*12+5 => 149
  crime <- subset(train, Category==CrimeCategory)
  #Regex to match hours and minutes
  pattern <- "^([0-9]{4})-([0-9]{2})-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}"
  matches <- str_match(crime$Dates, pattern)
  crime["Year"] <- as.integer(matches[,2])
  crime["Month"] <- as.integer(matches[,3])

  #number of minutes since midnight
  crime["MonthOffset"] <- as.integer((crime$Year-2003)*12 + crime$Month)
  #Number of category
  qplot(MonthOffset, data=crime, geom="histogram", binwidth=granularity)
  #/* nbCat = minutesInDay %/% granularity
  #offset = 0
  #for(i in 1:nbCat){
  #    cat[i] = nrows(subset)
  #}
  #

}
