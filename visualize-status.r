## This scripts give you The density of crimes by category that have been Arrested/ Booked
crimeResolution<-function(status){
arrests=subset(train,Resolution==status)
arrests <- filter(arrests, Category != "OTHER OFFENSES", Category != "NON-CRIMINAL")
arrests <- within(arrests, Category <- factor(Category,
           levels=names(sort(table(Category), decreasing=TRUE))))
q <- qplot(Category, data=arrests, geom="histogram")
q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
