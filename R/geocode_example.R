# library(tidyverse)
# library(ggmap)
# 
# cities_df <- data %>% 
#   dplyr::distinct(Location)
# 
# 
# cities_ll_080720 <- mutate_geocode(cities_df, Location)
# 
# write_csv(cities_df, path = "D:/Rprojects/cvindia/data/cities_ll_080720.csv")
# 
# saveRDS(cities_df, file = "D:/Rprojects/cvindia/data/cities_ll_080720.rds")