visualizeDistrict<-function(district){
  ##Gives you the crimes per category that have been reported in the PdDistrict=district
  pddistrict = subset(train, PdDistrict==district)
  pddistrict <- filter(pddistrict, Category != "OTHER OFFENSES", Category != "NON-CRIMINAL")
  pddistrict <- within(pddistrict, Category <- factor(Category,
             levels=names(sort(table(Category), decreasing=TRUE))))
  q <- qplot(Category, data=pddistrict, geom="histogram")
  q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}

visualizePdDistrictEfficiency <- function() {
  districts <- unique(train[,5])
  for(i in 1:dim(unique(train[,5]))[1]) {
    district <- as.character(districts[i, 1])
    print(district)
    total = subset(train, PdDistrict==district)
    totalCrime <- dim(total)[1]
    resolved = subset(total, Resolution=="ARREST, BOOKED")
    resolvedCrime <- dim(resolved)[1]
    resolutionRate <- resolvedCrime/totalCrime
    print(resolutionRate)
  }
}
