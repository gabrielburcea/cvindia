# library(tidyverse)
# 
# data <- PivotMappe060520r
# 
# data_select <- data %>%
#   dplyr::select(ID, Age, Gender, Location, Country, Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell',
#               'Long Standing Health Issues', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 'Number Of Days Symptoms Showing',
#               'Pregnant', 'Self Diagnosis', 'Shortness of Breath', 'Sore Throat','Reason For Helping', 'Sputum', 'Temperature') %>%
#   dplyr::rename( id = ID,
#                  age = Age,
#                  gender = Gender,
#                  location =  Location,
#                  country = Country,
#                  chills = Chills,
#                  diarrhoea = Diarrhoea,
#                  fatigue = Fatigue,
#                  headache = Headcahe,
#                  healthcare_worker = 'Healthcare Worker',
#                  how_unwell = 'How Unwell',
#                  long_standing_health = 'Long Standing Health Issues',
#                  loss_smell_taste = 'Loss of smell and taste',
#                  muscle_ache = 'Muscle Ache',
#                  nasal_congestion = 'Nasal Congestion',
#                  nausea_vomiting = 'Nausea and Vomiting',
#                  no_days_symptoms_show = 'Number Of Days Symptoms Showing',
#                  pregnant =  'Pregnant',
#                  shortness_breath = 'Shortness of Breath',
#                  sore_throat = 'Sore Throat',
#                  sputum = 'Sputum',
#                  temperature = 'Temperature',
#                  self_diagnosis = 'Self Diagnosis',
#                  tested_or_not = 'Reason For Helping')
# 
# data_select$tested_or_not <- as.factor(data_select)
# 
# test_data <- data_select %>%
#   tidyr::separate('long_standing_health', c('comorbidity_one', 'comorbidity_two', 'comorbidity_three', 'comorbidity_four'), sep = ",") %>%
#   tidyr::replace_na(list('comorbidity_one' = 'None', 'comorbidity_two' = 'None', 'comorbidity_three' = 'None', 'comorbidity_four' = 'None'))
# 
# test_data[test_data == 0] <- NA
# 
# data_model <- test_data %>%
#   dplyr::mutate(tested_covid = stringr::str_match(tested_or_not, 'Positive')) %>%
#   dplyr::mutate(tested_covid = stringr::str_match(tested_or_not, 'Positive')) %>%
#   tidyr::replace_na(list('tested_covid' = 'Negative')) %>%
#   tidyr::replace_na(list('no_days_symptoms_show' = 'None' )) %>%
#   dplyr::select(id, age, gender, country, chills, Cough, diarrhoea, fatigue, healthcare_worker, 
#                 how_unwell, comorbidity_one, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
#                 no_days_symptoms_show, self_diagnosis, shortness_breath, sore_throat, sputum, temperature, tested_covid)
#   

# write.csv(data_model, file = "/Users/gabrielburcea/Rprojects/data/data_model.csv")
# count_positive_negative <- test_data %>% 
#   dplyr::select(id, tested_covid) %>%
#   dplyr::group_by(tested_covid) %>%
#   tally()

# asthma <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Asthma (managed with an inhaler)' | comorbidity_one == "None") 
# 
# 
# long_standing_lung_condition <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Long-Standing Lung Condition' | comorbidity_one == 'None')
# 
# high_blood_pressure <- test_data %>% 
#   dplyr::filter(comorbidity_one == 'High Blood Pressure (hypertension)' | comorbidity_one == "None") 
# 
# obesity <- test_data %>%
#   dplyr::filter(comorbidity_one == 'Obesity' | comorbidity_one == "None") 




# dt_select <- dt_select %>%
#   dplyr::mutate(Age_band = case_when(age == 0 ~ '0',
#                                      age == 1 | age <= 4 ~ '1-4',
#                                      age == 5 | age <= 9 ~ '5-9',
#                                      age == 10 | age <= 14 ~ '10-14',
#                                      age == 15 | age <= 19 ~ '15-19',
#                                      age == 20 | age <= 24 ~ '20-24',
#                                      age == 25 | age <= 29 ~ '25-29',
#                                      age == 30 | age <= 34 ~ '30-34',
#                                      age == 35 | age <= 39 ~ '35-39',
#                                      age == 40 | age <= 44 ~ '40-44',
#                                      age == 45 | age <= 49 ~ '45-49',
#                                      age == 50 | age <= 54 ~ '50-54',
#                                      age == 55 | age <= 59 ~ '55-59',
#                                      age == 60 | age <= 64 ~ '60-64',
#                                      age == 65 | age <= 69 ~ '65-69',
#                                      age == 70 | age <= 74 ~ '70-74',
#                                      age == 75 | age <= 79 ~ '75-79',
#                                      age == 80 | age <= 84 ~ '80-84',
#                                      age == 85 | age <= 89 ~ '85-89',
#                                      age == 90 | age <= 94 ~ '90-94',
#                                      age >= 95  ~ '95+'))