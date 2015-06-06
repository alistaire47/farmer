library(dplyr)

county <- read.csv('CenPop2010_Mean_CO.csv')

county$chickenFarms2012 <- sapply(seq(nrow(county)), function(x){
    system(
        paste0("curl 'http://quickstats.nass.usda.gov/api/get_counts/?key=15218620-973B-368F-B5F3-19404E4A6181&source_desc=CENSUS&sector_desc=ANIMALS & PRODUCTS&group_desc=POULTRY&commodity_desc=CHICKENS&state_name=", toupper(county$STNAME[x]), "& county_name=", toupper(county$COUNAME[x]), "&year__GE=2012'")
        )
})

county$chickenFarms2007 <- sapply(seq(nrow(county)), function(x){
    system(
        paste0("curl 'http://quickstats.nass.usda.gov/api/get_counts/?key=15218620-973B-368F-B5F3-19404E4A6181&source_desc=CENSUS&sector_desc=ANIMALS & PRODUCTS&group_desc=POULTRY&commodity_desc=CHICKENS&state_name=", toupper(county$STNAME[x]), "& county_name=", toupper(county$COUNAME[x]), "&year__GE=2007'")
    )
})

write.csv(county, 'counties_with_chickens.csv')

states <- levels(county$STNAME)
chicFarmByState2012 <- sapply(seq(length(states)), function(x){
    system(
        paste0("curl 'http://quickstats.nass.usda.gov/api/get_counts/?key=15218620-973B-368F-B5F3-19404E4A6181&source_desc=CENSUS&sector_desc=ANIMALS & PRODUCTS&group_desc=POULTRY&commodity_desc=CHICKENS&state_name=", toupper(states[x]), "&year__GE=2012'")
    )
})