crimePerAddress<-function(address){
  ## Gives You the number of crimes by Category that happened in address
  address_subset= train[grep(address, train$Address), ]
  address_subset <- filter(address_subset, Category != "OTHER OFFENSES", Category != "NON-CRIMINAL")
  address_subset <- within(address_subset, Category <- factor(Category,
             levels=names(sort(table(Category), decreasing=TRUE))))
  q <- qplot(Category, data=address_subset, geom="histogram")
  q + theme(axis.text.x = element_text(angle = 90, hjust = 1))
}

getCorner <- function(){
  train$Address
  pattern <- " / "
  if (str_match(train$Address, pattern)) {
    train["Corner"] <- 1;
  }
  else {
    train["Corner"] <- 0;
  }
}
