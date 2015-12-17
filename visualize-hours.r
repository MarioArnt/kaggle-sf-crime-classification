#Extract subset by filtering according to the selected crime
crimeHours <- function (train, CrimeCategory, granularity) {
  minutesInDay = 24*60 # 1440
  #We want equivalents hour split
  if (minutesInDay %% granularity != 0) {
    print('bad granularity, should be a int that divides 1440')
  }
  else {
    crime <- subset(train, Category==CrimeCategory)
    #Regex to match hours and minutes
    pattern <- "^[0-9]{4}-[0-9]{2}-[0-9]{2} ([0-9]{2}):([0-9]{2}):[0-9]{2}"
    matches <- str_match(crime$Dates, pattern)
    crime["Hours"] <- as.integer(matches[,2])
    crime["Minutes"] <- as.integer(matches[,3])
    #number of minutes since midnight
    crime["MinutesOffset"] <- as.integer(60*crime$Hours + crime$Minutes)
    #Number of category
    qplot(MinutesOffset, data=crime, geom="histogram", binwidth=granularity)
    #/* nbCat = minutesInDay %/% granularity
    #offset = 0
    #for(i in 1:nbCat){
    #    cat[i] = nrows(subset)
    #}
    #
  }
}
