library(lubridate)
library(dplyr)

# import bird flu cases and county location data from the same directory as this script
flu <- read.csv('influenza_cases.csv')
county <- read.csv('CenPop2010_Mean_CO.txt')

# clean up flu dates
flu$Confirmation.Date <- dmy(flu$Confirmation.Date)

# join flu records with lat-long data
flu2 <- inner_join(flu, county, by=c("State"="STNAME", "County"="COUNAME"))

# export data
write.csv(flu2, file='flu_with_location.csv')
