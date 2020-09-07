# Get the frequecies and means and standard deviation 
#age, how unwell, gender, number_days_symptoms_showing, number_morbidities
# library(tidyverse)
# library(stargazer)
# library(psych)
# conflict_prefer("filter", "stats")
# cleaned_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_18_08_2020_multiple_comorbidities.csv")
# na_strings <- c( "More than 42",  "43+",  "Number Of Days Symptoms Showing", "No",
#                  "Yes", "Long Standing Health Issues",  "More than 21", "4 4","6 6", "7 7", "0 0", "5 5",  "9 9", "Plus de 21","21 ?? ???? ??", "42 ?? ????", "21 ?????? ?????")
# data <- cleaned_data %>%
#   mutate(across(starts_with('number_days_symptom_show'),
#                 ~ replace(., . %in% na_strings, NA)))
# sympt_show_t <- table(data$number_days_symptom_showing)
# data$number_days_symptom_showing <- as.numeric(data$number_days_symptom_showing)
# #number_days_symptom_showing
# number_days_symptoms_showing <- data %>%
#   dplyr::select(covid_tested, number_days_symptom_showing) %>%
#   drop_na()
# number_d_sympt_covid_pos <- number_days_symptoms_showing %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   dplyr::select(-covid_tested)
# numb_days_sympt_cov_pos <- as.data.frame(number_d_sympt_covid_pos)
# psych::describe(numb_days_sympt_cov_pos, skew = FALSE)
# # showing symptoms 
# numb_d_show_sympt_cov <- number_days_symptoms_showing %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>%
#   dplyr::select(-covid_tested) %>%
#   drop_na()
# no_days_sympt_show_sympt <- as.data.frame(numb_d_show_sympt_cov)
# psych::describe(no_days_sympt_show_sympt, skew = FALSE)
# # negative tested 
# negative_tested_symptom <- number_days_symptoms_showing %>%
#   dplyr::filter(covid_tested == "negative") %>%
#   dplyr::select(-covid_tested)
# negative_tested_symptom_show <- as.data.frame(negative_tested_symptom)
# psych::describe(negative_tested_symptom_show, skew = FALSE)
# # age 
# data <- cleaned_data %>% mutate(Age = replace(age, age > 100, NA_real_))
# data_num_age_groups <- data %>%
#   dplyr::group_by(Age, covid_tested) %>%
#   tally()
# # covid_positive by age - mean and standard deviation
# covid_positive_age_mean_std <- data_num_groups %>%
#   dplyr::filter(covid_tested == "positive") %>% 
#   drop_na() %>%
#   dplyr::select(Age)
# covid_pos_age_mean_std <- as.data.frame(covid_positive_age_mean_std)
# psych::describe(covid_pos_age_mean_std, skew = FALSE)
# #covid_showing_symptoms by age - mean and standard deviation
# covid_show_sympt_age_mean_std <- data_num_groups %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>% 
#   drop_na() %>%
#   dplyr::select(Age)
# covid_show_symp_age_mean_std <- as.data.frame(covid_show_sympt_age_mean_std)
# psych::describe(covid_show_symp_age_mean_std, skew = FALSE)
# # mean age and standard deviation of negative tests
# covid_negative_age_mean_std <- data_num_groups %>%
#   dplyr::filter(covid_tested == "negative") %>% 
#   drop_na() %>%
#   dplyr::select(Age)
# covid_negat_age_mean_std <- as.data.frame(covid_negative_age_mean_std)
# psych::describe(covid_negat_age_mean_std, skew = FALSE)
# # Cre home worker -
# na_strings_care_home_worker <- c("Age", "Care Home Worker")
# data <- data %>% 
#     mutate(across(starts_with('care_home_worker'),
#            ~ replace(., . %in% na_strings_care_home_worker, NA)))
# care_home_worker <- data %>%
#   dplyr::select(covid_tested, care_home_worker) %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, care_home_worker) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # health care worker - percentanges 
# na_strings_health_care_worker <- c("Chills", "Healthcare Worker")
# data <- data %>% 
#    mutate(across(starts_with('health_care_worker'),
#                  ~ replace(., . %in%  na_strings_health_care_worker, NA)))
# 
# health_care_worker <- data %>%
#   dplyr::group_by(covid_tested, health_care_worker) %>%
#   drop_na() %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # loss of smell taste 
# data %>% 
#   dplyr::group_by(covid_tested, loss_smell_taste) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100)
# #muscle ache 
# data %>%
#   dplyr::group_by(covid_tested, muscle_ache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100)
# #cough
# na_strings_cough<- c("Location")
# data <- data %>% 
#   mutate(across(starts_with('cough'),
#                 ~ replace(., . %in%  na_strings_cough, NA)))
# data %>%
#   dplyr::group_by(covid_tested, cough) %>%
#   drop_na() %>%
#   dplyr::tally() %>%
#   dplyr::mutate( Perc = n/sum(n) *100)
# #shorthness of breath 
# data %>% 
#   dplyr::group_by(covid_tested, shortness_breath) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #chills 
# data %>%
#   dplyr::group_by(covid_tested, chills) %>%
#   dplyr::tally() %>% 
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #diarrhoea
# data %>%
#   dplyr::group_by(covid_tested, diarrhoea) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #fatigue
# data %>%
#   dplyr::group_by(covid_tested, fatigue) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # headache 
# data %>%
#   dplyr::group_by(covid_tested, headache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # nasal congestion 
# data %>% 
#   dplyr::group_by(covid_tested, nasal_congestion) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentate = n/sum(n)*100)
# # nausea and vominting 
# data %>%
#   dplyr::group_by(covid_tested, nausea_vomiting) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# #sore throat 
# data %>% 
#   dplyr::group_by(covid_tested, sore_throat) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # sputum 
# data %>%
#   dplyr::group_by(covid_tested, sputum) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # temperature 
# data %>%
#   dplyr::group_by(covid_tested, temperature) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # loss appetite 
# data %>%
#   dplyr::group_by(covid_tested, loss_appetite) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # sneezing 
# data %>%
#   dplyr::group_by(covid_tested, sneezing) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # chest pain 
# data %>%
#   dplyr::group_by(covid_tested, chest_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# # chest_pain 
# data %>% 
#   dplyr::group_by(covid_tested, itchy_eyes) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# #joint_pain 
# data %>%
#   dplyr::group_by(covid_tested, joint_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # Comorbidities 
# data %>% 
#   dplyr::group_by(covid_tested, asthma) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # diabetes type I
# data %>%
#   dplyr::group_by(covid_tested, diabetes_type_one) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # diabetes type II
# data %>%
#   dplyr::group_by(covid_tested, diabetes_type_two) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # heart disease 
# data %>%
#   dplyr::group_by(covid_tested, heart_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #hypertension 
# data %>%
#   dplyr::group_by(covid_tested, hypertension) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # kidney disease 
# data %>%
#   dplyr::group_by(covid_tested, kidney_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #liver disease 
# data %>% 
#   dplyr::group_by(covid_tested, liver_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# #lung condition 
# data %>%
#   dplyr::group_by(covid_tested, lung_condition) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # obesity 
# data %>% 
#   dplyr::group_by(covid_tested, obesity) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# na_strings_gender <- c("Gender") 
# data <- data %>% 
#   mutate(across(starts_with('gender'),
#                 ~ replace(., . %in% na_strings_gender, NA)))
# # female 
# data %>%
#   dplyr::group_by(covid_tested, gender) %>%
#   drop_na() %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # pregnant 
# na_strings_pregnant <- c("Loss of smell and taste", "Pregnant")
# data <- data %>%
#   dplyr::mutate(across(starts_with('pregnant'), 
#                 ~ replace(.,. %in% na_strings_pregnant, NA)))
# female_pregnant <- data %>%
#   dplyr::select(covid_tested, gender, pregnant) %>% 
#   dplyr::filter(gender == "Female")
# female_pregnant_cov_pos <- female_pregnant %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_cov_pos
# female_pregnant_show_cov<- female_pregnant %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_show_cov
# female_pregnant_cov_neg <- female_pregnant %>%
#   dplyr::filter(covid_tested == "negative") %>%
#   drop_na() %>%
#   dplyr::group_by(pregnant) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# female_pregnant_cov_neg
# # answered questions on symptoms
# questions_symptoms_answered <- data %>%
#   dplyr::select(id, covid_tested, chills, cough, diarrhoea, fatigue, headache, 
#                 loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
#                 shortness_breath, sore_throat, sputum, temperature, loss_appetite,
#                 sneezing, chest_pain, itchy_eyes, joint_pain)
# questions_symptoms_answered %>%
#   dplyr::select(id, covid_tested) %>%
#   dplyr::group_by(covid_tested) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # answered questions on comorbidities 
# data %>%
#   dplyr::select(id, covid_tested, asthma, obesity, diabetes_type_one, diabetes_type_two, 
#                 hypertension, lung_condition, liver_disease, kidney_disease) %>%
#   dplyr::group_by(covid_tested) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# # Get the unique comorbidities - this is done here since some cleaning is taking part in this script 
# # first run the cleaning_rtf_18_08_2020 and then apply this script to data so that you get a fully cleaned data 
# # need to move the cleaning part into cleaning_rtf_18_08_2020
# pregnant_t <- table(data$pregnant)
# pregnant_gender <- data %>%
#   dplyr::group_by(gender, pregnant) %>%
#   tally()
# #write.csv(data, file = "/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_18_08_2020_fully_cleaned_uniq_comorb.csv", row.names = FALSE)