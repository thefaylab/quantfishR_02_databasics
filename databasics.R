# Data Basics in R
# 11/20/2018, RPW
# Description: Look at bottom trawl data and plot bottom temperature and spp lengths
# Value: Produces two graphs

# load libraries
library(tidyverse) 
library(skimr) # helpful summary info
library(readxl)

# load the bottom trawl data
neusData <- read_excel("neus_10spp.xlsx", sheet="neus_10spp", 
                       na = "NA")

skim(neusData)

unique(select(neusData, YEAR))
range(select(neusData, YEAR))

# trim down to last ten yrs of data for spring
neusFiltered <- neusData %>%
                  filter(YEAR >= 2005) %>% # filter() removes rows
                  filter(SEASON == "SPRING") %>%
                  select(YEAR, DEPTH, BOTTEMP, COMNAME, ABUNDANCE, BIOMASS, LENGTH) %>% # select() removes columns
                  filter(COMNAME %in% c("ATLANTIC COD", "AMERICAN LOBSTER"))   # %in% asks for items that match the set that follows,
                                                                               # in this case, filters rows where COMNAME is EITHER
                                                                               # cod or lobster
nrow(neusFiltered) 
ncol(neusFiltered)

# look at our data with boxplots and histsograms
ggplot(neusFiltered, aes(x=YEAR, y=BOTTEMP, group=YEAR)) +
  geom_boxplot()

ggplot(neusFiltered, aes(x=LENGTH)) +
  geom_histogram() +
  facet_grid(YEAR~COMNAME) + 
  xlim(0, 30)
