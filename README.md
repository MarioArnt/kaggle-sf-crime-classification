# Visualization scripts

## Install R dependencies
In the R terminal install the following dependencies:

If you don't have R, you can install it on a debian/ubuntu environment using the command
`sudo apt-get install r-base`

```R
#Data import library
install.packages("readr")

#String manipulation library
install.packages("stringr")

#Data display library
install.packages("dplyr")

#Plot library
install.packages("ggplot2")

#Plot data on maps
install.packages("ggpmap")
```

## Plot functions

#### crimeWeekday(data, crime-type)
Visualize crime frequency depending on the day of week for each crime type.
Inputs:
* data (dataframe): the training dataset to use
* crime-type (str): the crime type (e.g. "PROSTITUTION")

Exemple:

```R
source('visualize-weekday.r')
crimeWeekday(train, "LARCENY/THEFT")
```
#### crimeHours(data, crime-type, granularity)
Visualize crime frequency depending on the hour of the day for each crime type.
Inputs:
* data (dataframe): the training dataset to use
* crime-type (str): the crime type (e.g. "DRUG/NARCOTIC")
* granularity (int): the time dividion chosen for plotting (eg. 10 for 10 minutes time intervals)

Exemple:

```R
source('visualize-hours.r')
crimeHours(train, "VEHICLE THEFT", 60)
```

#### crimeMap(granularity, minCrime, filterNonCriminal)
Visualize most frequent crime type for each squared area on the San Francisco map.
The function generates images called crimemap-*granularity*-*filter*-*minCrime*.png in `./img` folder.
Inputs:
* granularity (float): round longitude and latitude in order to split San Francisco in more or less wide squared areas
* minCrime (int): ignore area where there occurred less than n crimes
* filterNonCriminal (boolean): ignore NON-CRIMINAL and OTHER OFFENSES crimes if true

Exemple:
```R
source('visualize-map.r')
for (i in 1:5) {
  granularity = i/1000
  crimeMap(granularity, 0, TRUE)
  crimeMap(granularity, 20, TRUE)
  crimeMap(granularity, 50, TRUE)
}
```
This loop will generate 15 .png maps with different parameters.
