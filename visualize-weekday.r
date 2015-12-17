library(readr)
library(dplyr)
library(ggplot2)

#Extract subset by filtering according to the selected crime
crimeWeekday <- function (train, CrimeCategory) {
  crime <- subset(train, Category==CrimeCategory)
  #Filter the results by weekday
  monday <- subset(crime, DayOfWeek=="Monday")
  tuesday <- subset(crime, DayOfWeek=="Tuesday")
  wednesday <- subset(crime, DayOfWeek=="Wednesday")
  thursday <- subset(crime, DayOfWeek=="Thursday")
  friday <- subset(crime, DayOfWeek=="Friday")
  saturday <- subset(crime, DayOfWeek=="Saturday")
  sunday <- subset(crime, DayOfWeek=="Sunday")
  #Count the number of occurences
  mon = nrow(monday)
  tue = nrow(tuesday)
  wed = nrow(wednesday)
  thu = nrow(thursday)
  fri = nrow(friday)
  sat = nrow(saturday)
  sun = nrow(sunday)
  #Generate chart
  results <- data.frame(day=c('MON','TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'),
  frequency=c(mon, tue, wed, thu, fri, sat, sun))
  print(results)
  qplot(DayOfWeek, data=crime, geom="histogram")
}
