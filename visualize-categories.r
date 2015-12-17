#Extract subset by filtering according to the selected crime
crimeCategory <- function () {
  #Generate chart
  q <- qplot(Category, data=train, geom="histogram")
  q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
