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

# make a csv file with states and boolean value of whether flu report in state
states <- unique(county$STNAME)
fluBoolean <- states %in% unique(flu2$State)
fluByState <- data.frame(states, fluBoolean)
write.csv(fluByState, 'fluByState.csv')

# make a csv file with MN counties and boolean of whether flu report in county
mncounty <- county %>% filter(STNAME == 'Minnesota') %>% select(COUNAME)
mncounty <- mncounty$COUNAME
mnFluBoolean <- mncounty %in% unique(filter(flu2, State == 'Minnesota')$County)
mnFluByCounty <- data.frame(mncounty, mnFluBoolean)
write.csv(mnFluByCounty, 'MNfluByCounty.csv')
