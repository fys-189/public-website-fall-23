library(tidyverse)
library(tidycensus)
library(sf)


race <- get_acs(geography = "block group", 
               variables = c("C02003_003", 
                             "C02003_004", 
                             "C02003_005", 
                             "C02003_006", 
                             "C02003_007", 
                             "C02003_009"),
               summary_var = "C02003_001",
               year = 2021,
               state = "LA",
               geometry = TRUE)

race$variable <-
  recode(race$variable,
         C02003_003 = "White",
         C02003_004 = "Black or African American",
         C02003_005 = "American Indian or Alaska Native",
         C02003_006 = "Asian",
         C02003_007 = "Native Hawaiian or Other Pacific Islander",
         C02003_009 = "Multiple Races")

race <- race |>
  mutate(pct = estimate / summary_est * 100)

st_write(st_as_sf(race), "data/race_la_2021.geojson")

