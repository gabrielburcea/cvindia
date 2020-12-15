# Get the frequecies and means and standard deviation 
#age, how unwell, gender, number_days_symptoms_showing, number_morbidities
# library(tidyverse)
# library(stargazer)
# library(psych)
# conflict_prefer("filter", "stats")
# 
# 
# cleaned_data_22092020 <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020_2nd_dataset.csv")
# 
# cleaned_data <- cleaned_data_22092020 %>%
#   dplyr::filter(country == "Pakistan")
# 
# cleaned_data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested) %>%
#   tally()
# 
# unique(cleaned_data$number_days_symptom_showing)
# na_strings <- c( "0 0" , "7 7", "4 4", "5 5", "9 9","6 6", "21 ?? ???? ??", "42 ?? ????", "21 ?????? ?????")
# data <- cleaned_data %>%
#   mutate(across(starts_with('number_days_symptom_show'),
#                 ~ replace(., . %in% na_strings, NA)))
# sympt_show_t <- table(data$number_days_symptom_showing)
# 
# sympt_show_t
# 
# number_days_symptom_showing <- c(
#   
#   "22" = "More than 21",
#   "43" = "More than 42",
#   "22" = "Plus de 21"
#   
# )
# 
# 
# data <- data %>%
#   dplyr::mutate(number_days_symptom_showing = forcats::fct_recode(number_days_symptom_showing, !!!number_days_symptom_showing))
# 
# 
# 
# unique(data$number_days_symptom_showing)
# #number_days_symptom_showing
# number_days_symptoms_showing <- data %>%
#   dplyr::select(covid_tested, number_days_symptom_showing) %>%
#   drop_na()
# 
# 
# number_d_sympt_covid_pos <- number_days_symptoms_showing %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   dplyr::select(-covid_tested)
# 
# numb_days_sympt_cov_pos <- as.data.frame(number_d_sympt_covid_pos)
# psych::describe(numb_days_sympt_cov_pos, skew = FALSE)
# 
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
# 
# data_num_age_groups <- data %>%
#   dplyr::group_by(Age, covid_tested) %>%
#   tally() %>%
#   drop_na()
# 
# #covid_positive by age - mean and standard deviation
# covid_positive_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_pos_age_mean_std <- as.data.frame(covid_positive_age_mean_std)
# psych::describe(covid_pos_age_mean_std, skew = FALSE)
# #covid_showing_symptoms by age - mean and standard deviation
# covid_show_sympt_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_show_symp_age_mean_std <- as.data.frame(covid_show_sympt_age_mean_std)
# psych::describe(covid_show_symp_age_mean_std, skew = FALSE)
# # mean age and standard deviation of negative tests
# covid_negative_age_mean_std <- data_num_age_groups %>%
#   dplyr::filter(covid_tested == "negative") %>%
#   drop_na() %>%
#   dplyr::select(Age)
# covid_negat_age_mean_std <- as.data.frame(covid_negative_age_mean_std)
# psych::describe(covid_negat_age_mean_std, skew = FALSE)
# 
# #
# 
# 
# # Covid tested counts
# 
# cleaned_data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested) %>%
#   tally()
# 
# # Care home worker -
# na_strings_care_home_worker <- c("Age", "Care Home Worker")
# data <- cleaned_data %>%
#   mutate(across(starts_with('care_home_worker'),
#                 ~ replace(., . %in% na_strings_care_home_worker, NA)))
# 
# 
# cleaned_data %>%
#   dplyr::select(covid_tested, care_home_worker) %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, care_home_worker) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(care_home_worker != "No")
# 
# 
# # health care worker - percentange
# na_strings_health_care_worker <- c("Chills", "Healthcare Worker")
# data <- cleaned_data %>%
#   mutate(across(starts_with('health_care_worker'),
#                 ~ replace(., . %in%  na_strings_health_care_worker, NA)))
# #health care worker
# data %>%
#   dplyr::group_by(covid_tested, health_care_worker) %>%
#   drop_na() %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(health_care_worker != "No")
# 
# #gender
# 
# data %>%
#   dplyr::group_by(covid_tested, gender) %>%
#   drop_na() %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(gender != "No")
# 
# data %>%
#   dplyr::group_by(covid_tested, gender, pregnant) %>%
#   drop_na() %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(pregnant != "No")
# 
# # loss of smell taste
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, loss_smell_taste) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(loss_smell_taste != "No")
# #muscle ache
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, muscle_ache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n) *100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(muscle_ache != "No")
# #cough
# data %>%
#   dplyr::group_by(covid_tested, cough) %>%
#   drop_na() %>%
#   dplyr::tally() %>%
#   dplyr::mutate( Perc = n/sum(n) *100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(cough != "No")
# #shorthness of breath
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, shortness_breath) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(shortness_breath != "No")
# #chills
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, chills) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(chills != "No")
# #diarrhoea
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, diarrhoea) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(diarrhoea != "No")
# #fatigue
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, fatigue) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(fatigue!= "No")
# # headache
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, headache) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(headache != "No")
# # nasal congestion
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, nasal_congestion) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentate = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(nasal_congestion != "No")
# # nausea and vominting
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, nausea_vomiting) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(nausea_vomiting != "No")
# #sore throat
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, sore_throat) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(sore_throat!= "No")
# # sputum
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, sputum) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(sputum != "No")
# # temperature
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, temperature) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(temperature != "No")
# # loss appetite
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, loss_appetite) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(loss_appetite != "No")
# # sneezing
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, sneezing) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(sneezing != "No")
# # chest pain
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, chest_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(chest_pain != "No") %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(chest_pain != "No")
# # itchy eyes
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, itchy_eyes) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(itchy_eyes != "No")
# #joint_pain
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, joint_pain) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(joint_pain!= "No")
# 
# # itchy eyes
# 
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, itchy_eyes) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(itchy_eyes != "No")
# 
# # Comorbidities
# 
# #asthma
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, asthma) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(asthma != "No")
# 
# # diabetes type I
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, diabetes_type_one) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(diabetes_type_one != "No")
# # diabetes type II
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, diabetes_type_two) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(diabetes_type_two != "No")
# # heart disease
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, heart_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(heart_disease != "No")
# #hypertension
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, hypertension) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(hypertension!= "No")
# # kidney disease
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, kidney_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(kidney_disease != "No")
# #liver disease
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, liver_disease) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(liver_disease != "No")
# #lung condition
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, lung_condition) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(lung_condition!= "No")
# # obesity
# data %>%
#   drop_na() %>%
#   dplyr::group_by(covid_tested, obesity) %>%
#   dplyr::tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100) %>%
#   tidyr::drop_na() %>%
#   dplyr::filter(obesity != "No")
# 
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
#                        ~ replace(.,. %in% na_strings_pregnant, NA)))
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
#   drop_na() %>%
#   dplyr::select(id, covid_tested, asthma, obesity, diabetes_type_one, diabetes_type_two,
#                 hypertension, lung_condition, liver_disease, kidney_disease) %>%
#   dplyr::group_by(covid_tested) %>%
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
#   dplyr::group_by(covid_tested, pregnant) %>%
#   tally() %>%
#   dplyr::mutate(Percentage = n/sum(n)*100)
# 
# pregnant_gender