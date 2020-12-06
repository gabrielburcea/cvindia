cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")

cohort_data_22092020_top_five <- cohort_data_22092020  %>%
  dplyr::filter(country == "Brazil" | country == "United Kingdom" | country == "India" | country == "Mexico" | country == "Pakistan")

age_std_data_no_sympt <- cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "positive") %>%
  dplyr::group_by(country, age_band) %>%
  dplyr::summarise(count_country_age_band_no_sympt = dplyr::n())

cohort_data_22092020_five_no_sympt_age <- left_join(cohort_data_22092020_top_five, age_std_data_no_sympt)


age_std_data_with_sympt <-  cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "positive") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "symptoms",
                      values_to = "binary_sympt") %>%
  dplyr::filter(binary_sympt == "Yes") %>%
  dplyr::group_by(country, age_band, symptoms) %>%
  dplyr::summarise(count_country_age_band_with_sympt = dplyr::n())

symptom_data <- left_join(age_std_data_no_sympt, age_std_data_with_sympt)

study_pop_symptom_data <- symptom_data %>%
  dplyr::mutate(study_pop_sympt = count_country_age_band_with_sympt/count_country_age_band_no_sympt)


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


symptom_data_study_pop_world_wide_pop <- left_join(study_pop_symptom_data, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_symptom_age_group <- symptom_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_symptoms = study_pop_sympt * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_sympt <- expected_symptom_age_group %>%
  dplyr::group_by(symptoms, country) %>%
  dplyr::mutate(sum_expected_symp = sum(expected_standard_pop_symptoms))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_sympt <- sum_expected_sympt %>%
  dplyr::mutate(age_standardise_rate_in_sympt = sum_expected_symp / total_worldwide_pop *100)



adjusted_symptoms_rates_select <- age_standard_rate_sympt %>%
  #dplyr::fil(age_recoded_band == "20-39") %>%
  dplyr::select(country, symptoms, age_standardise_rate_in_sympt )






########### Standardisation for all countries ##############################
cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")

# age_std_data_covid_positive <- cohort_data_22092020 %>%
#   dplyr::select(id, Country, age_band, count_country_age_band_comorbidities, standard_pop) %>%
#   dplyr::rename(country = Country) %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "comorbidities",
#                       values_to = "binary_yes_no") %>%
#   dplyr::filter(binary_yes_no =="Yes") %>%
#   dplyr::select(id, country, age_band, comorbidities, standard_pop, count_country_age_band_comorbidities)

age_std_data_no_sympt_all_countries <- cohort_data_22092020 %>%
  dplyr::select(id, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "positive") %>%
  dplyr::group_by(age_band) %>%
  dplyr::summarise(count_all_countries_age_band_no_sympt = dplyr::n())


age_std_data_with_sympt_all_countries <-  cohort_data_22092020 %>%
  dplyr::select(id, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "positive") %>%
  tidyr::pivot_longer(cols = 3:19,
                      names_to = "symptoms",
                      values_to = "binary_sympt") %>%
  dplyr::filter(binary_sympt == "Yes") %>%
  dplyr::group_by(age_band, symptoms) %>%
  dplyr::summarise(count_all_countries_age_band_with_sympt = dplyr::n())

sympt_data_all_countries <- left_join(age_std_data_no_sympt_all_countries, age_std_data_with_sympt_all_countries)

study_pop_sympt_data_all_countries <- sympt_data_all_countries %>%
  dplyr::mutate(study_pop_sympt_all_countries = count_all_countries_age_band_with_sympt/count_all_countries_age_band_no_sympt)


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


sympt_data_study_pop_world_wide_pop <- left_join(study_pop_sympt_data_all_countries, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_sympt_age_group <- sympt_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_sympt_all_countries = study_pop_sympt_all_countries * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_sympt_all_countries <- expected_sympt_age_group %>%
  dplyr::group_by(symptoms) %>%
  dplyr::mutate(sum_expected_sympt_all_countries = sum(expected_standard_pop_sympt_all_countries))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_sympt_all_countries <- sum_expected_sympt_all_countries %>%
  dplyr::mutate(age_standardise_rate_in_sympt = sum_expected_sympt_all_countries / total_worldwide_pop *100)


adjusted_sympt_rates_select_all_countries <- age_standard_rate_sympt_all_countries %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(symptoms,  age_standardise_rate_in_sympt) %>%
  dplyr::distinct() %>%
  add_column(country = c("All Countries")) %>%
  dplyr::select(country, symptoms, age_standardise_rate_in_sympt)


adjusted_sympt_rates_select <- age_standard_rate_sympt %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(country, symptoms,  age_standardise_rate_in_sympt)

adjusted_sympt_rates_final <- bind_rows(adjusted_sympt_rates_select, adjusted_sympt_rates_select_all_countries)

adj_sympt_forcats <- adjusted_sympt_rates_final %>%
  dplyr::mutate(age_standardise_rate_in_sympt = round(age_standardise_rate_in_sympt, 2)) %>%
  dplyr::arrange(country)

symptom_levels <- c(
  "muscle ache" = "muscle_ache",
  "nasal congestion" = "nasal_congestion",
  "nausea and vomiting" = "nausea_vomiting",
  "sore throat" = "sore_throat",
  "loss of appetite" = "loss_appetite",
  "chest pain" = "chest_pain",
  "itchy eyes" = "itchy_eyes",
  "joint pain" = "joint_pain"
)


adj_sympt_forcats <- adj_sympt_forcats %>% 
  dplyr::mutate(symptoms = forcats::fct_recode(symptoms, !!!symptom_levels))

#write.csv(adj_sympt_forcats, file = "/Users/gabrielburcea/rprojects/data/your.md/age_standard_rate_sympt_2910_2020.csv", row.names = FALSE)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC6600")

title <- "Figure 4: Adjusted SARS-Covid-19 symptom rates for group with Covid-19 tested positive, for top 5 countries vs. all countries"
plot_adjusted_rates <- ggplot2::ggplot(adj_sympt_forcats,
                                       ggplot2::aes(symptoms,  age_standardise_rate_in_sympt, country)) +
  ggplot2::coord_flip() +
  ggplot2::geom_bar(ggplot2::aes(fill = country), width = 0.4,
                    position = position_dodge(width = 0.5), stat = "identity") +
  ggplot2::scale_fill_manual(values = cbbPalette) +
  ggplot2::labs(title = title,
                subtitle = "\nNote: i) date period between 04/09/20202 - 22/09/2020",
                x = "SARS-Covid-19 Symptoms", y = "Percentage", caption = "Source: Your.md Data") +
  ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 0.9, b = 0, l = 0)),
                 plot.title = ggplot2::element_text(size = 0.9, face = "bold"),
                 plot.subtitle = ggplot2::element_text(size = 0.9),
                 legend.position = "bottom" , legend.box = "horizontal") +
  ggplot2::theme_bw()


plot_adjusted_rates



# DO the same for responders with showing symptoms 

cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")

cohort_data_22092020_top_five <- cohort_data_22092020  %>%
  dplyr::filter(country == "Brazil" | country == "United Kingdom" | country == "India" | country == "Mexico" | country == "Pakistan")

age_std_data_no_sympt <- cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  dplyr::group_by(country, age_band) %>%
  dplyr::summarise(count_country_age_band_no_sympt = dplyr::n())

cohort_data_22092020_five_no_sympt_age <- left_join(cohort_data_22092020_top_five, age_std_data_no_sympt)


age_std_data_with_sympt <-  cohort_data_22092020_top_five %>%
  dplyr::select(id, country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  tidyr::pivot_longer(cols = 4:20,
                      names_to = "symptoms",
                      values_to = "binary_sympt") %>%
  dplyr::filter(binary_sympt == "Yes") %>%
  dplyr::group_by(country, age_band, symptoms) %>%
  dplyr::summarise(count_country_age_band_with_sympt = dplyr::n())

symptom_data <- left_join(age_std_data_no_sympt, age_std_data_with_sympt)

study_pop_symptom_data <- symptom_data %>%
  dplyr::mutate(study_pop_sympt = count_country_age_band_with_sympt/count_country_age_band_no_sympt)


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


symptom_data_study_pop_world_wide_pop <- left_join(study_pop_symptom_data, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_symptom_age_group <- symptom_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_symptoms = study_pop_sympt * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_sympt <- expected_symptom_age_group %>%
  dplyr::group_by(symptoms, country) %>%
  dplyr::mutate(sum_expected_symp = sum(expected_standard_pop_symptoms))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_sympt <- sum_expected_sympt %>%
  dplyr::mutate(age_standardise_rate_in_sympt = sum_expected_symp / total_worldwide_pop *100)



adjusted_symptoms_rates_select <- age_standard_rate_sympt %>%
  #dplyr::fil(age_recoded_band == "20-39") %>%
  dplyr::select(country, symptoms, age_standardise_rate_in_sympt )






########### Standardisation for all countries ##############################
cohort_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")

# age_std_data_covid_positive <- cohort_data_22092020 %>%
#   dplyr::select(id, Country, age_band, count_country_age_band_comorbidities, standard_pop) %>%
#   dplyr::rename(country = Country) %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "comorbidities",
#                       values_to = "binary_yes_no") %>%
#   dplyr::filter(binary_yes_no =="Yes") %>%
#   dplyr::select(id, country, age_band, comorbidities, standard_pop, count_country_age_band_comorbidities)

age_std_data_no_sympt_all_countries <- cohort_data_22092020 %>%
  dplyr::select(id, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  dplyr::group_by(age_band) %>%
  dplyr::summarise(count_all_countries_age_band_no_sympt = dplyr::n())


age_std_data_with_sympt_all_countries <-  cohort_data_22092020 %>%
  dplyr::select(id, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache,
                nasal_congestion, nausea_vomiting, shortness_breath, sore_throat, sputum, temperature,
                loss_appetite, loss_smell_taste, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
  dplyr::filter(covid_tested == "showing symptoms") %>%
  tidyr::pivot_longer(cols = 3:19,
                      names_to = "symptoms",
                      values_to = "binary_sympt") %>%
  dplyr::filter(binary_sympt == "Yes") %>%
  dplyr::group_by(age_band, symptoms) %>%
  dplyr::summarise(count_all_countries_age_band_with_sympt = dplyr::n())

sympt_data_all_countries <- left_join(age_std_data_no_sympt_all_countries, age_std_data_with_sympt_all_countries)

study_pop_sympt_data_all_countries <- sympt_data_all_countries %>%
  dplyr::mutate(study_pop_sympt_all_countries = count_all_countries_age_band_with_sympt/count_all_countries_age_band_no_sympt)


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


sympt_data_study_pop_world_wide_pop <- left_join(study_pop_sympt_data_all_countries, sum_world_wide_pop_age_group_total, by = c("age_band" = "age_recoded_band"))


# get the expected symptoms in standard population
expected_sympt_age_group <- sympt_data_study_pop_world_wide_pop %>%
  dplyr::mutate(expected_standard_pop_sympt_all_countries = study_pop_sympt_all_countries * standard_pop)

# get the sum of expected symptoms in standard pop

sum_expected_sympt_all_countries <- expected_sympt_age_group %>%
  dplyr::group_by(symptoms) %>%
  dplyr::mutate(sum_expected_sympt_all_countries = sum(expected_standard_pop_sympt_all_countries))

# get the age standardize rates for symptoms by dividing the sum of the expected symptoms in standard pop

age_standard_rate_sympt_all_countries <- sum_expected_sympt_all_countries %>%
  dplyr::mutate(age_standardise_rate_in_sympt = sum_expected_sympt_all_countries / total_worldwide_pop *100)


adjusted_sympt_rates_select_all_countries <- age_standard_rate_sympt_all_countries %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(symptoms,  age_standardise_rate_in_sympt) %>%
  dplyr::distinct() %>%
  add_column(country = c("All Countries")) %>%
  dplyr::select(country, symptoms, age_standardise_rate_in_sympt)


adjusted_sympt_rates_select <- age_standard_rate_sympt %>%
  #dplyr::filter(age_recoded_band == "20-39") %>%
  dplyr::select(country, symptoms,  age_standardise_rate_in_sympt)

adjusted_sympt_rates_final <- bind_rows(adjusted_sympt_rates_select, adjusted_sympt_rates_select_all_countries)

adj_sympt_forcats <- adjusted_sympt_rates_final %>%
  dplyr::mutate(age_standardise_rate_in_sympt = round(age_standardise_rate_in_sympt, 2))

symptom_levels <- c(
  "muscle ache" = "muscle_ache",
  "nasal congestion" = "nasal_congestion",
  "nausea and vomiting" = "nausea_vomiting",
  "sore throat" = "sore_throat",
  "loss of appetite" = "loss_appetite",
  "chest pain" = "chest_pain",
  "itchy eyes" = "itchy_eyes",
  "joint pain" = "joint_pain"
)


adj_sympt_forcats <- adj_sympt_forcats %>% 
  dplyr::mutate(symptoms = forcats::fct_recode(symptoms, !!!symptom_levels))

adj_sympt_tables_covpos <- adj_sympt_forcats %>%
  dplyr::distinct(country, symptoms, age_standardise_rate_in_sympt) %>%
  tidyr::pivot_wider(names_from = "country", 
                     values_from = "age_standardise_rate_in_sympt")


write.csv(adj_sympt_tables_covpos, file = "/Users/gabrielburcea/rprojects/data/your.md/adj_sympt_tables_covpos_2910_2020.csv", row.names = FALSE)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC6600")

title <- "Figure 5: Adjusted SARS-Covid-19 symptom rates for showing symptoms group, for top 5 countries vs. all countries"
plot_adjusted_rates_show_symptoms <- ggplot2::ggplot(adj_sympt_forcats,
                                       ggplot2::aes(symptoms,  age_standardise_rate_in_sympt, country)) +
  ggplot2::coord_flip() +
  ggplot2::geom_bar(ggplot2::aes(fill = symptoms), width = 0.4,
                    position = position_dodge(width = 0.5), stat = "identity") +
  ggplot2::scale_fill_manual(values = cbbPalette) +
  ggplot2::labs(title = title,
                subtitle = "\nNote: i) Adjusted rates are not including those who responded they have been tested positive;  ii) date period between 04/09/20202 - 22/09/2020",
                x = "SARS-Covid-19 Symptoms", y = "Percentage", caption = "Source: Your.md Data") +
  ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 10, b = 0, l = 0)),
                 plot.title = ggplot2::element_text(size = 9, face = "bold"),
                 plot.subtitle = ggplot2::element_text(size = 10),
                 legend.position = "bottom" , legend.box = "horizontal") +
  ggplot2::theme_bw()


plot_adjusted_rates_show_symptoms 



library(patchwork)

library(ggpubr)

ggpubr::ggarrange(plot_adjusted_rates, plot_adjusted_rates_show_symptoms)




# unique_age_adjusted_sympt <- adj_sympt_forcats %>%
#   distinct(country, symptoms, age_standardise_rate_in_sympt
#   )
# 
# pivlong_sympt <- unique_age_adjusted_sympt %>%
#   dplyr::select(country, symptoms, age_standardise_rate_in_sympt) %>%
#   tidyr::pivot_wider(names_from = "country",
#                      values_from = "age_standardise_rate_in_sympt")
# 
# 
# write.csv(pivlong_sympt, file = "/Users/gabrielburcea/rprojects/data/your.md/age_standardised/adjusted_rates_symptoms_tables.csv", row.names = FALSE)






