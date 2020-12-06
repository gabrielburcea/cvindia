# library(tidyverse)
# library(gt)
# 
# 
# unique_age_adjusted_comor <- age_standard_rate_sympt_2910_2020 %>%
#   distinct(country, symptoms, age_standardise_rate_in_sympt
#            ) %>%
#   dplyr::mutate(standardised_symptom_rates = round(age_standardise_rate_in_sympt, 2)) %>%
#   select(-age_standardise_rate_in_sympt)
# 
# 
# 
# pivlong_sympt <- unique_age_adjusted_comor %>%
#   dplyr::select(country, symptoms, standardised_symptom_rates) %>%
#   tidyr::pivot_wider(names_from = "country", 
#                      values_from = "standardised_symptom_rates")
# 
# 
# write.csv(pivlong_sympt, file = "/Users/gabrielburcea/rprojects/data/your.md/age_standardised/adjusted_rates_comorbidities_tables.csv", row.names = FALSE)
# 
# 
# pivlong_sympt %>%
#   dplyr::arrange("symptoms") %>%
#   gt()




