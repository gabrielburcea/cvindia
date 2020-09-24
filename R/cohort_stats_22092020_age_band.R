# Get the frequecies and means and standard deviation
# age, how unwell, gender, number_days_symptoms_showing, number_morbidities
# library(tidyverse)
# library(stargazer)
# library(psych)
# conflict_prefer("filter", "stats")
# cleaned_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")
# 
# 
# table(cleaned_data$age)
# 
# unique(cleaned_data$number_days_symptom_showing)
# na_strings <- c( "0 0" , "7 7", "4 4", "5 5", "9 9","6 6", "21 ?? ???? ??", "42 ?? ????", "21 ?????? ?????")
# data <- cleaned_data %>%
#   mutate(across(starts_with('number_days_symptom_show'),
#                 ~ replace(., . %in% na_strings, NA)))
# sympt_show_t <- table(data$number_days_symptom_showing) 
# 
# sympt_show_t <- as.data.frame(sympt_show_t) %>% arrange(desc(Var1))
# 
# data$number_days_symptom_showing <- as.numeric(data$number_days_symptom_showing)
# 
# #number_days_symptom_showing
# number_days_symptoms_showing <- data %>%
#   dplyr::select(age_band, number_days_symptom_showing) %>%
#   drop_na()
# number_d_sympt_covid_pos <- number_days_symptoms_showing %>%
#   dplyr::filter(age_band == "positive") %>%
#   dplyr::select(-age_band)
# numb_days_sympt_cov_pos <- as.data.frame(number_d_sympt_covid_pos)
# psych::describe(numb_days_sympt_cov_pos, skew = FALSE)
# # showing symptoms
# numb_d_show_sympt_cov <- number_days_symptoms_showing %>%
#   dplyr::filter(age_band == "showing symptoms") %>%
#   dplyr::select(-age_band) %>%
#   drop_na()
# no_days_sympt_show_sympt <- as.data.frame(numb_d_show_sympt_cov)
# psych::describe(no_days_sympt_show_sympt, skew = FALSE)
# # negative tested
# negative_tested_symptom <- number_days_symptoms_showing %>%
#   dplyr::filter(age_band == "negative") %>%
#   dplyr::select(-age_band)
# negative_tested_symptom_show <- as.data.frame(negative_tested_symptom)
# psych::describe(negative_tested_symptom_show, skew = FALSE)
# # age
# data <- cleaned_data %>% mutate(Age = replace(age, age > 100, NA_real_))
# data_num_age_groups <- data %>%
#   dplyr::group_by(Age, age_band) %>%
#   tally()
# # covid_positive by age - mean and standard deviation
# covid_positive_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(age_band == "positive") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_pos_age_mean_std <- as.data.frame(covid_positive_age_mean_std)
# psych::describe(covid_pos_age_mean_std, skew = FALSE)
# #covid_showing_symptoms by age - mean and standard deviation
# covid_show_sympt_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(age_band == "showing symptoms") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_show_symp_age_mean_std <- as.data.frame(covid_show_sympt_age_mean_std)
# psych::describe(covid_show_symp_age_mean_std, skew = FALSE)
# # mean age and standard deviation of negative tests
# covid_negative_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(age_band == "negative") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_negat_age_mean_std <- as.data.frame(covid_negative_age_mean_std)
# psych::describe(covid_negat_age_mean_std, skew = FALSE)
# 
# 
# 
# data <- data %>%
#   dplyr::mutate(age_clean = replace(age, age > 100, NA_real_))
# 
# data <- data %>%
#   dplyr::mutate(age_band = dplyr::case_when(
#     age == 0 | age <= 19 ~ '0-19',
#     age == 20 | age <= 39 ~ '20-39',
#     age == 40 | age <= 59 ~ '40-59',
#     age >= 60 ~ "60+"))
# 
# unique(data$age_band)
# 
# 
# # Covid tested counts 
# 
# data %>%
#   dplyr::group_by(age_band) %>% 
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# 
# 
# 
# # Care home worker -
# na_strings_care_home_worker <- c("Age", "Care Home Worker")
# data <- data %>%
#   mutate(across(starts_with('care_home_worker'),
#                 ~ replace(., . %in% na_strings_care_home_worker, NA)))
# care_home_worker <- data %>%
#   dplyr::select(age_band, care_home_worker) %>%
#   drop_na() %>%
#   dplyr::group_by(age_band, care_home_worker) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # health care worker - percentanges
# na_strings_health_care_worker <- c("Chills", "Healthcare Worker")
# data <- data %>%
#   mutate(across(starts_with('health_care_worker'),
#                 ~ replace(., . %in%  na_strings_health_care_worker, NA)))
# 
# health_care_worker <- data %>%
#   dplyr::group_by(age_band, health_care_worker) %>%
#   drop_na() %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# 
# 
# # loss of smell taste
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, loss_smell_taste) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100)
# #muscle ache
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, muscle_ache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100)
# #cough
# na_strings_cough<- c("Location")
# data <- data %>%
#   mutate(across(starts_with('cough'),
#                 ~ replace(., . %in%  na_strings_cough, NA)))
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, cough) %>%
#   dplyr::tally() %>%
#   dplyr::mutate( Perc = n/sum(n) *100)
# #shorthness of breath
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, shortness_breath) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #chills
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, chills) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #diarrhoea
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, diarrhoea) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #fatigue
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, fatigue) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # headache
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, headache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # nasal congestion
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, nasal_congestion) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentate = n/sum(n)*100)
# # nausea and vominting
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, nausea_vomiting) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# #sore throat
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, sore_throat) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # sputum
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, sputum) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # temperature
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, temperature) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # loss appetite
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, loss_appetite) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # sneezing
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, sneezing) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # chest pain
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, chest_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # chest_pain
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, itchy_eyes) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# #joint_pain
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, joint_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# # itchy eyes
# 
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, itchy_eyes) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# # Comorbidities
# data
# 
# 
# 
# 
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, asthma) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # diabetes type I
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, diabetes_type_one) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # diabetes type II
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, diabetes_type_two) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # heart disease
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, heart_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #hypertension
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, hypertension) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # kidney disease
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, kidney_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #liver disease
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, liver_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #lung condition
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, lung_condition) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # obesity
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, obesity) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# na_strings_gender <- c("Gender")
# data <- data %>%
#   mutate(across(starts_with('gender'),
#                 ~ replace(., . %in% na_strings_gender, NA)))
# # female
# data %>%
#   drop_na() %>%
#   dplyr::filter(age_band != "0-19") %>%
#   dplyr::group_by(age_band, gender) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # pregnant
# na_strings_pregnant <- c("Loss of smell and taste", "Pregnant")
# data <- data %>%
#   dplyr::mutate(across(starts_with('pregnant'),
#                        ~ replace(.,. %in% na_strings_pregnant, NA)))
# female_pregnant <- data %>%
#   dplyr::select(age_band, gender, pregnant) %>%
#   dplyr::filter(gender == "Female")
# female_pregnant_cov_pos <- female_pregnant %>%
#   dplyr::filter(age_band == "positive") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_cov_pos
# female_pregnant_show_cov<- female_pregnant %>%
#   dplyr::filter(age_band == "showing symptoms") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_show_cov
# female_pregnant_cov_neg <- female_pregnant %>%
#   dplyr::filter(age_band == "negative") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_cov_neg
# # answered questions on symptoms
# questions_symptoms_answered <- data %>%
#   dplyr::select(id, age_band, chills, cough, diarrhoea, fatigue, headache,
#                 loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting,
#                 shortness_breath, sore_throat, sputum, temperature, loss_appetite,
#                 sneezing, chest_pain, itchy_eyes, joint_pain)
# 
# count_age_band_sympt <- questions_symptoms_answered %>%
#   drop_na() %>%
#   dplyr::select(id, age_band) %>%
#   dplyr::group_by(age_band) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# count_age_band_sympt
# 
# 
# # answered questions on comorbidities
# count_age_band_comorbidities <- data %>%
#   dplyr::select(id, age_band, asthma, obesity, diabetes_type_one, diabetes_type_two,
#                 hypertension, lung_condition, liver_disease, kidney_disease)
# 
# 
# count_age_band_comorbidities %>%
#   dplyr::group_by(age_band) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # Get the unique comorbidities - this is done here since some cleaning is taking part in this script
# # first run the cleaning_rtf_18_08_2020 and then apply this script to data so that you get a fully cleaned data
# # need to move the cleaning part into cleaning_rtf_18_08_2020
# pregnant_t <- table(data$pregnant)
# 
# pregnant_t
# pregnant_gender <- data %>%
#   drop_na() %>%
#   dplyr::filter(gender == "Female") %>%
#   dplyr::group_by(age_band, pregnant) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# pregnant_gender
# #write.csv(data, file = "/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_18_08_2020_fully_cleaned_uniq_comorb.csv", row.names = FALSE)