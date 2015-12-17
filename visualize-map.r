## Prevalent Crimes in San Francisco
library(plyr)
library(dplyr)
library(ggmap)
library(ggplot2)
library(readr)
library(stringr)

crimeMap <- function (granularity, minCrime, filterNonCriminal) {
  # Retrieve map from google API
  map <- get_map(location="sanfrancisco",zoom=12,source="osm")
  ## Filter categories
  if(filterNonCriminal == TRUE) {
    train <- filter(train, Category != "OTHER OFFENSES",
    Category != "NON-CRIMINAL")
  }
  ## Create area factor by rounding lon e lat
  train$X_round <- round_any(train$X, granularity)
  train$Y_round <- round_any(train$Y, granularity)
  train$X_Y <- as.factor(paste(train$X_round, train$Y_round, sep = " "))
  ## Prevalent category by area
  prevalent <- function(x){as.character(
        unique(
                x$Category[x$Category == names(which.max(table(x$Category)))
                           ]
        )
  )
  }
  prevalent_crime <- ddply(train, .(X_Y, X_round, Y_round), prevalent)
  names(prevalent_crime) <- c("X_Y", "X", "Y", "Category")
  prevalent_crime$Category <- as.factor(prevalent_crime$Category)
  ## Filter areas with less than 50 Crimes
  counts <- ddply(train, .(X_Y), dim)$V1
  prevalent_crime <- mutate(prevalent_crime, counts = counts)
  prevalent_crime <- filter(prevalent_crime, counts > minCrime)
  prevalent_crime <- arrange(prevalent_crime, X_Y)
  ## Coordinates for polygon plot
  ##
  mid_granularity = granularity/2
  X_Y_1 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>%
        mutate(X = X - mid_granularity, Y = Y - mid_granularity)
  X_Y_2 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>%
        mutate(X = X - mid_granularity, Y = Y + mid_granularity)
  X_Y_3 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>%
        mutate(X = X + mid_granularity, Y = Y + mid_granularity)
  X_Y_4 <- prevalent_crime %>% select(X_Y, X, Y, Category, counts) %>%
        mutate(X = X + mid_granularity, Y = Y - mid_granularity)
  plot_data <- rbind(X_Y_1, X_Y_2, X_Y_3, X_Y_4)
  plot_data <- arrange(plot_data, X_Y)
  ## Plot
  mypal <- colorRampPalette(brewer.pal( 6 , "Set1" ));
  nbColor <- length(unique(plot_data$Category))
  print(nbColor)
  p <- ggmap(map) +
        geom_polygon(data = plot_data, aes(x = X, y = Y, fill=Category, group=X_Y, alpha = log(counts)))+
        scale_alpha(range = c(0.5, 0.7), guide = FALSE)+
        scale_fill_manual(values = mypal(nbColor)) +
        ggtitle("Prevalent Crimes in San Francisco")

  ## Save
  pattern <- "0.([0-9]+)"
  gran <- str_match(granularity, pattern)[,2]

  file_path <- paste(
                  paste(
                    paste(
                      paste(
                        "./img/crime-map",
                        as.character(gran),
                        sep="-"
                      ),
                      as.character(filterNonCriminal),
                      sep="-"
                    ),
                    as.character(minCrime),
                    sep="-"
                  ),
                  "png",
                  sep="."
              )
  ggsave(file_path, p, width=14, height=10, units="in")
}
