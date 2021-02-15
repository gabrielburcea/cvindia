cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020_2nd_dataset.csv")


cohort_data_22092020 <- cohort_data_22092020 %>%
  dplyr::group_by(covid_tested) %>%
  tidyr::drop_na()

cohort_data_22092020_top_five <- cohort_data_22092020  %>%
  dplyr::filter(country == "Brazil" | country == "United Kingdom" | country == "India" | country == "Mexico" | country == "Pakistan")

# age_std_data_covid_positive <- cohort_data_22092020 %>%
#   dplyr::select(id, Country, age_band, count_country_age_band_comorbidities, standard_pop) %>%
#   dplyr::rename(country = Country) %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "comorbidities",
#                       values_to = "binary_yes_no") %>%
#   dplyr::filter(binary_yes_no =="Yes") %>%
#   dplyr::select(id, country, age_band, comorbidities, standard_pop, count_country_age_band_comorbidities)

age_std_data_no_comorb <- cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition,
                liver_disease, kidney_disease, covid_tested) %>%
  dplyr::group_by(country, age_band) %>%
  dplyr::summarise(count_country_age_band_no_comorb = dplyr::n())


age_std_data_with_comorb <-  cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition,
                liver_disease, kidney_disease) %>%
  tidyr::pivot_longer(cols = 5:13,
                      names_to = "comorbidities",
                      values_to = "binary_comorb") %>%
  dplyr::filter(binary_comorb == "Yes") %>%
  dplyr::group_by(country, age_band, comorbidities) %>%
  dplyr::summarise(count_country_age_band_with_comorb = dplyr::n())


comorb_data <- left_join(age_std_data_no_comorb, age_std_data_with_comorb)

study_pop_comorb_data <- comorb_data %>%
  dplyr::mutate(study_pop_comorb = count_country_age_band_with_comorb/count_country_age_band_no_comorb)

library(readxl)
### Deal with world-wide population - get the worldwide population by age group
### Deal with world-wide population - get the worldwide population by age group
world_wide_pop <- read_excel("/Users/gabrielburcea/rprojects/cvindia/data/world_wide_pop.xlsx")

data_piv <- world_wide_pop %>%
  dplyr::rename(year = "Reference date (as of 1 July)")


data_piv <- data_piv %>%
  tidyr::pivot_longer(cols = 9:29,
                      names_to = "age_band",
                      values_to = "value") %>%
  dplyr::filter(year == "2020")

data_piv <- data_piv %>% mutate_all(trimws)

data_piv$value <- as.numeric(data_piv$value)

data_piv$Value <- data_piv$value * 1000

count_world_pop <- data_piv %>%
  dplyr::summarise(Total_wwpop = sum(Value))

data_piv$age_band <- as.factor(data_piv$age_band)
age_levels <- c(
  "0-19" = "0-4" ,
  "0-19" = "5-9",
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

data_rec <- data_piv %>%
  dplyr::mutate(age_recoded_band = forcats::fct_recode(age_band,!!!age_levels)) %>%
  dplyr::select(age_recoded_band, Value)

sum_world_wide_pop_age_group_total <- data_rec %>%
  dplyr::group_by(age_recoded_band) %>%
  dplyr::summarise(standard_pop = sum(Value)) %>%
  dplyr::mutate(total_worldwide_pop = sum(standard_pop))


comorb_data_study_pop_world_wide_pop <- left_join(study_pop_comorb_data, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_comorb_age_group <- comorb_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_comorb = study_pop_comorb * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_comorb <- expected_comorb_age_group %>%
  dplyr::group_by(comorbidities, country) %>%
  dplyr::mutate(sum_expected_comorb = sum(expected_standard_pop_comorb))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_comorb <- sum_expected_comorb %>%
  dplyr::mutate(age_standardise_rate_in_comorb = sum_expected_comorb / total_worldwide_pop *100)




# ########### Standardisation for all countries ##############################
cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020_2nd_dataset.csv")

cohort_data_22092020 <- cohort_data_22092020 %>%
  dplyr::group_by(covid_tested) %>%
  tidyr::drop_na() %>%
  dplyr::filter(Country != "Brazil" ) %>%
  dplyr::filter(Country != "India") %>%
  dplyr::filter(Country != "Pakistan") %>%
  dplyr::filter(Country != "Mexico") %>%
  dplyr::filter(Country != "United Kingdom") 



# age_std_data_covid_positive <- cohort_data_22092020 %>%
#   dplyr::select(id, Country, age_band, count_country_age_band_comorbidities, standard_pop) %>%
#   dplyr::rename(country = Country) %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "comorbidities",
#                       values_to = "binary_yes_no") %>%
#   dplyr::filter(binary_yes_no =="Yes") %>%
#   dplyr::select(id, country, age_band, comorbidities, standard_pop, count_country_age_band_comorbidities)

age_std_data_no_comorb_all_countries <- cohort_data_22092020 %>%
  dplyr::select(id, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition,
                liver_disease, kidney_disease, covid_tested) %>%
  dplyr::group_by(age_band) %>%
  dplyr::summarise(count_all_countries_age_band_no_comorb = dplyr::n())


age_std_data_with_comorb_all_countries <-  cohort_data_22092020 %>%
  dplyr::select(id, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition,
                liver_disease, kidney_disease) %>%
  tidyr::pivot_longer(cols = 4:11,
                      names_to = "comorbidities",
                      values_to = "binary_comorb") %>%
  dplyr::filter(binary_comorb == "Yes") %>%
  dplyr::group_by(age_band, comorbidities) %>%
  dplyr::summarise(count_all_countries_age_band_with_comorb = dplyr::n())

comorb_data_all_countries <- left_join(age_std_data_no_comorb_all_countries, age_std_data_with_comorb_all_countries)

study_pop_comorb_data_all_countries <- comorb_data_all_countries %>%
  dplyr::mutate(study_pop_comorb_all_countries = count_all_countries_age_band_with_comorb/count_all_countries_age_band_no_comorb)



### Deal with world-wide population - get the worldwide population by age group
world_wide_pop <- read_excel("/Users/gabrielburcea/rprojects/cvindia/data/world_wide_pop.xlsx")

data_piv <- world_wide_pop %>%
  dplyr::rename(year = "Reference date (as of 1 July)")


data_piv <- data_piv %>%
  tidyr::pivot_longer(cols = 9:29,
                      names_to = "age_band",
                      values_to = "value") %>%
  dplyr::filter(year == "2020")

data_piv <- data_piv %>% mutate_all(trimws)

data_piv$value <- as.numeric(data_piv$value)

data_piv$Value <- data_piv$value * 1000

count_world_pop <- data_piv %>%
  dplyr::summarise(Total_wwpop = sum(Value))

data_piv$age_band <- as.factor(data_piv$age_band)
age_levels <- c(
  "0-19" = "0-4" ,
  "0-19" = "5-9",
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

data_rec <- data_piv %>%
  dplyr::mutate(age_recoded_band = forcats::fct_recode(age_band,!!!age_levels)) %>%
  dplyr::select(age_recoded_band, Value)

sum_world_wide_pop_age_group_total <- data_rec %>%
  dplyr::group_by(age_recoded_band) %>%
  dplyr::summarise(standard_pop = sum(Value)) %>%
  dplyr::mutate(total_worldwide_pop = sum(standard_pop))


comorb_data_study_pop_world_wide_pop <- left_join(study_pop_comorb_data_all_countries, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_comorb_age_group <- comorb_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_comorb_all_countries = study_pop_comorb_all_countries * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_comorb_all_countries <- expected_comorb_age_group %>%
  dplyr::group_by(comorbidities) %>%
  dplyr::mutate(sum_expected_comorb_all_countries = sum(expected_standard_pop_comorb_all_countries))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_comorb_all_countries <- sum_expected_comorb_all_countries %>%
  dplyr::mutate(age_standardise_rate_in_comorb = sum_expected_comorb_all_countries / total_worldwide_pop *100)


adjusted_comorbididity_rates_select_all_countries <- age_standard_rate_comorb_all_countries %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(comorbidities,  age_standardise_rate_in_comorb) %>%
  dplyr::distinct() %>%
  add_column(country = c("All other countries")) %>%
  dplyr::select(country, comorbidities, age_standardise_rate_in_comorb) %>%
  arrange(country)


adjusted_comorbididity_rates_select <- age_standard_rate_comorb %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(country, comorbidities,  age_standardise_rate_in_comorb)

adjusted_comorbididity_rates_final <- bind_rows(adjusted_comorbididity_rates_select, adjusted_comorbididity_rates_select_all_countries)




#write.csv(adj_comorb_forcats, file = "/Users/gabrielburcea/rprojects/data/your.md/age_standard_rate_comorb_2910_2020.csv", row.names = FALSE)


cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC6600")

pre_existing_levels <- c(
  
  "diabetes type two" = "diabetes_type_two",
  "diabetes type one" = "diabetes_type_one",
  "heart disease" = "heart_disease",
  "lung condidition" = "lung_condition",
  "liver disease" = "liver_disease",
  "kidney disease" = "kidney_disease"
  
)

adj_comorb_forcats <- adjusted_comorbididity_rates_final %>%
  dplyr::mutate(comorbidities = forcats::fct_recode(comorbidities, !!!pre_existing_levels)) %>%
  dplyr::mutate(age_standardise_rate_in_comorb = round(age_standardise_rate_in_comorb, 2))

 
cols <- c("#000000", "#E69F00", "#56B4E9", "#009E73", 
  "#F0E442", "#0072B2")
#title <- "Figure 5: Adjusted rates for pre-existing conditions for top 5 countries vs. all countries"
plot_adjusted_rates <- ggplot2::ggplot(adj_comorb_forcats,
                                       ggplot2::aes(comorbidities, age_standardise_rate_in_comorb,  country)) +
  ggplot2::coord_flip() +
  ggplot2::geom_bar(ggplot2::aes(fill = country), width = 0.4,
                    position = position_dodge(width = 0.5), stat = "identity") +
  ggplot2::scale_fill_manual(values = cols,
    guide = guide_legend(reverse = TRUE), name = "Country" ) +
  ggplot2::labs(
                x = "Pre-existing conditions", y = "Percentage") +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(
      t = 0,
      r = 10,
      b = 0,
      l = 0
    )),
    plot.title = ggplot2::element_text(size = 9, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 10),
    legend.box = "horizontal", 
    legend.title = element_text(size = 14), 
    legend.text = element_text(size = 10)
  )

plot_adjusted_rates


unique_age_adjusted_comor <- adj_comorb_forcats %>%
  distinct(country, comorbidities, age_standardise_rate_in_comorb
           )

pivlong_comorb <- unique_age_adjusted_comor %>%
  dplyr::select(country, comorbidities, age_standardise_rate_in_comorb) %>%
  tidyr::pivot_wider(names_from = "country",
                     values_from = "age_standardise_rate_in_comorb")


write.csv(pivlong_comorb, file = "/Users/gabrielburcea/rprojects/data/your.md/age_standardised/adjusted_rates_comorbidities_tables.csv", row.names = FALSE)
pivlong_sympt %>%
  dplyr::arrange("symptoms") %>%
  gt()




