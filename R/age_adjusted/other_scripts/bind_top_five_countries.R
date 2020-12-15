# library(tidyverse)
# 
# data_piv <- world_wide_pop %>%
#   dplyr::rename(year = "Reference date (as of 1 July)")
# 
# 
# data_piv <- data_piv %>%
#   tidyr::pivot_longer(cols = 9:29,
#                       names_to = "age_band",
#                       values_to = "value") %>%
#   dplyr::filter(year == "2020")
# 
# data_piv <- data_piv %>% mutate_all(trimws)
# 
# data_piv$value <- as.numeric(data_piv$value)
# 
# data_piv$Value <- data_piv$value *1000
# 
# count_world_pop <- data_piv %>%
#   dplyr::summarise(Total_wwpop = sum(Value))
# 
# data_piv$age_band <- as.factor(data_piv$age_band)
# age_levels <- c(
#   "0-19" = "0-4" ,
#   "0-19" = "5-9",
#   "0-19" = "10-14",
#   "0-19" = "15-19",
#   "20-39" = "20-24",
#   "20-39" = "25-29",
#   "20-39" = "30-34",
#   "20-39" = "35-39",
#   "40-59" = "40-44",
#   "40-59" = "45-49",
#   "40-59" = "50-54",
#   "40-59" = "55-59",
#   "60+" = "60-64",
#   "60+" = "65-69",
#   "60+" = "70-74",
#   "60+" = "75-79",
#   "60+" = "80-84",
#   "60+" = "85-89",
#   "60+" = "90-94",
#   "60+" = "95-99",
#   "60+" = "100+"
# )
# 
# data_rec <- data_piv %>%
#   dplyr::mutate(age_recoded_band = forcats::fct_recode(age_band, !!!age_levels)) %>%
#   dplyr::select(age_recoded_band, Value)
# 
# sum_count_val <- data_rec %>%
#   dplyr::group_by(age_recoded_band) %>%
#   dplyr::summarise(standard_pop = sum(Value))
# 
# 
# 
# cohort_data_22092020 <- left_join(cohort_data_22092020_top_five, sum_count_val, by = c("age_band" = "age_recoded_band"))
# write.csv(cohort_data_22092020, file = "/Users/gabrielburcea/rprojects/data/your.md/cohort_data_22092020.csv", row.names = FALSE)