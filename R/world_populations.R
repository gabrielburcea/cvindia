library(tidyverse)

world_wide_pop <- readr::read_csv("/Users/gabrielburcea/rprojects/data/wwdata/world_wide_pop.csv")

age_groups_lev <- c("0-9" = "05-Sep", "10-14" = "Oct-14")

data <- world_wide_pop %>%
  tidyr::pivot_longer(cols = 5:25 , names_to = "age_grps" , values_to = "value") %>%
  dplyr::mutate(age_groups = forcats::fct_recode(age_grps, !!!age_groups_lev)) %>%
  dplyr::rename(year = "Reference date (as of 1 July)") %>%
  dplyr::filter(year == "2020")

data$age_groups <- as.factor(data$age_groups)
age_levels <- c(
  "0-19" = "0-4" ,
  "0-19" = "0-9",
  "0-19" = "10-14",
  "0-19" = "15-19",
  "20-39" = "20-24",
  "20-39" = "25-29",
  "20-39" = "30-34",
  "20-39" = "35-39",
  "40-59" = "40-44",
  "40-59" = "45-49",
  "40-59" = "50-54",
  "40-59" = "55-59",
  "60+" = "60-64", 
  "60+" = "65-69", 
  "60+" = "70-74", 
  "60+" = "75-79", 
  "60+" = "80-84", 
  "60+" = "85-89", 
  "60+" = "90-94", 
  "60+" = "95-99", 
  "60+" = "100+"
)

data_rec <- data %>%
  dplyr::mutate(age_recoded_band = forcats::fct_recode(age_groups, !!!age_levels)) %>%
  dplyr::select(age_recoded_band, value)

                