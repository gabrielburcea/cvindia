# library(tidyverse)
# library(naniar)
# library(forcats)
# 
# data_rec <-
#   read_csv("/Users/gabrielburcea/Rprojects/data/csvdata.csv")
# 
# nrow(distinct(data_rec))
# 
# data_rename <- data_rec %>%
#   dplyr::rename(
#     id = ID,
#     age = Age,
#     gender = Gender,
#     location = Location,
#     country = Country,
#     chills = Chills,
#     cough = Cough,
#     diarrhoea = Diarrhoea,
#     fatigue = Fatigue,
#     headache = Headcahe,
#     pregnant = Pregnant,
#     sputum = Sputum,
#     temperature = Temperature,
#     sneezing = Sneezing,
#     loss_of_smell_and_taste = "Loss of smell and taste",
#     muscle_ache = 'Muscle Ache',
#     nasal_congestion = "Nasal Congestion",
#     nausea_vomiting = "Nausea and Vomiting",
#     self_diagnosis = "Self Diagnosis",
#     shortness_breath = "Shortness of Breath",
#     sore_throat = "Sore Throat",
#     loss_appetite = "Loss of Appetite",
#     chest_pain = "Chest Pain",
#     itchy_eyes = "Itchy Eyes",
#     joint_pain = "Joint Pain", 
#     care_home_worker = 'Care Home Worker',
#     health_care_worker = "Healthcare Worker",
#     date_completed = 'Date Completed',
#     how_unwell = "How Unwell",
#     number_days_symptom_showing = "Number Of Days Symptoms Showing",
#     reason_for_help = "Reason For Helping",
#     language = Language,
#     health_condition = "Long Standing Health Issues"
#     
#   )
# 
# data_com <- data_rename %>%
#   rowwise() %>%
#   mutate(health_condition =
#            str_extract_all(health_condition,
#                            pattern = "None|Diabetes Type 2|Asthma \\(managed with an inhaler\\)|Obesity|High Blood Pressure \\(hypertension\\)|Long-Standing Lung Condition|Long-Standing Liver Disease|Long-Standing Heart Disease|Long-Standing Kidney Disease|Diabetes Type 1 \\(controlled by insulin\\)"), 
#          health_condition =  paste(health_condition, collapse = ","))
# 
# data_com$health_condition <- sub("^$", "None", data_com$health_condition)
# 
# reason_for_help_levels <-
#   c(
#     "negative" = "Curious",
#     "negative" =  "Curious,Self-Isolating With No Symptoms" ,
#     "negative" = "Live With Someone With Coronavirus",
#     "negative" = "Live With Someone With Coronavirus,Curious" ,
#     "negative" = "Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms",
#     "negative" = "Live With Someone With Coronavirus,Self-Isolating With No Symptoms",
#     "negative" = "Muscle Ache",
#     "negative" = "No",
#     "negative" = "None",
#     "negative" = "Reason For Helping",
#     "showing symptoms" = "Recovered But Have New Symptoms",
#     "showing symptoms" = "Recovered But Have New Symptoms,Curious",
#     "showing symptoms" = "Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#     "showing symptoms" = "Recovered But Have New Symptoms,Self-Isolating With No Symptoms",
#     "negative" = "Self-Isolating With No Symptoms",
#     "showing symptoms" = "Showing Symptoms But Not Tested",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Curious",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Curious",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious",
#     "showing symptoms" = "Showing Symptoms But Not Tested,Self-Isolating With No Symptoms",
#     "showing symptoms" = "Tested Negative But Have Symptoms",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Curious",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Self-Isolating With No Symptoms",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
#     "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#     "positive" = "Tested Positive",
#     "positive" = "Tested Positive,Curious",
#     "positive" = "Tested Positive,Live With Someone With Coronavirus",
#     "positive" = "Tested Positive,Recovered But Have New Symptoms",
#     "positive" = "Tested Positive,Recovered But Have New Symptoms,Curious",
#     "positive" = "Tested Positive,Self-Isolating With No Symptom",
#     "positive" = "Tested Positive,Showing Symptoms But Not Tested",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#     "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptom)"
#   )
# 
# 
# data_comorb <- data_com %>%
#   tidyr::separate(
#     health_condition,
#     c(
#       'Comorbidity_one',
#       'Comorbidity_two',
#       'Comorbidity_three',
#       'Comorbidity_four',
#       'Comorbidity_five',
#       'Comorbidity_six',
#       'Comorbidity_seven',
#       'Comorbidity_eight',
#       'Comorbidity_nine'
#       
#     ),
#     sep = ","
#   ) 
# data_comorb %>% distinct(Comorbidity_one) 
# data_comorb %>% distinct(Comorbidity_two)
# data_comorb %>% distinct(Comorbidity_three)
# data_comorb %>% distinct(Comorbidity_four)
# data_comorb %>% distinct(Comorbidity_five)
# data_comorb %>% distinct(Comorbidity_six)
# data_comorb %>% distinct(Comorbidity_seven)
# data_comorb %>% distinct(Comorbidity_eight)
# data_comorb %>% distinct(Comorbidity_nine)
# 
# data_long_wid <- data_comorb  %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   tidyr::drop_na('Comorbidity') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 'Yes') %>%
#   tidyr::pivot_wider(names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
#   dplyr::select(-None)
# 
# 
# # # # #################################################
# # # # ######### Get a numeric dataset #################
# # # # #################################################
# number_days_symptoms_show_levels <-
#   c('21' = "More than 21")
# data_model <- data_long_wid %>%
#   dplyr::mutate(covid_tested = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels),
#                 number_days_symptoms = forcats::fct_recode(number_days_symptom_showing, !!!number_days_symptoms_show_levels)) %>%
#   dplyr::select(-reason_for_help)
# 
# data_model$gender <- as.factor(data_model$gender)
# data_model$country <- as.factor(data_model$country)
# data_model$chills <- as.factor(data_model$chills)
# data_model$cough  <- as.factor(data_model$cough)
# data_model$diarrhoea  <- as.factor(data_model$diarrhoea)
# data_model$fatigue  <- as.factor(data_model$fatigue)
# data_model$headache   <- as.factor(data_model$headache)
# data_model$loss_of_smell_and_taste   <- as.factor(data_model$loss_of_smell_and_taste)
# data_model$muscle_ache  <- as.factor(data_model$muscle_ache)
# data_model$nasal_congestion <- as.factor(data_model$nasal_congestion)
# data_model$nausea_vomiting  <- as.factor(data_model$nausea_vomiting)
# data_model$self_diagnosis <- as.factor(data_model$self_diagnosis)
# data_model$shortness_breath <- as.factor(data_model$shortness_breath)
# data_model$sore_throat <- as.factor(data_model$sore_throat)
# data_model$sputum <- as.factor(data_model$sputum)
# data_model$temperature  <- as.factor(data_model$temperature)
# data_model$health_care_worker <- as.factor(data_model$health_care_worker)
# data_model$care_home_worker <- as.factor(data_model$care_home_worker)
# data_model$asthma   <- as.factor(data_model$`Asthma (managed with an inhaler)`)
# data_model$diabetes_type_two <- as.factor(data_model$`Diabetes Type 2`)
# data_model$obesity <- as.factor(data_model$Obesity)
# data_model$hypertension  <- as.factor(data_model$`High Blood Pressure (hypertension)`)
# data_model$heart_disease  <- as.factor(data_model$`Long-Standing Heart Disease`)
# data_model$kidney_disease <- as.factor(data_model$`Long-Standing Kidney Disease`)
# data_model$lung_condition <- as.factor(data_model$`Long-Standing Lung Condition`)
# data_model$liver_disease <- as.factor(data_model$`Long-Standing Liver Disease`)
# data_model$diabetes_type_one <- as.factor(data_model$`Diabetes Type 1 (controlled by insulin)`)
# data_model$how_unwell <- as.factor(data_model$how_unwell)
# data_model$covid_tested <- as.factor(data_model$covid_tested)
# data_model$id <- as.character(data_model$id)
# data_model$age <- as.numeric(data_model$age)
# data_model$gender <- as.factor(data_model$gender)
# data_model$pregnant <- as.factor(data_model$pregnant)
# data_model$date_completed <- as.Date(data_model$date_completed)
# data_model$location <- as.factor(data_model$location)
# data_model$loss_appetite <- as.factor(data_model$loss_appetite)
# data_model$sneezing <- as.factor(data_model$sneezing)
# data_model$chest_pain <- as.factor(data_model$chest_pain)
# data_model$itchy_eyes <- as.factor(data_model$itchy_eyes)
# data_model$joint_pain <- as.factor(data_model$joint_pain)
# 
# # # # #### Refactor the levels ##################################################
# data_sel <- data_model %>%
#   dplyr::select(
#     id,
#     covid_tested,
#     age,
#     gender,
#     country,
#     location,
#     date_completed,
#     care_home_worker,
#     chills,
#     cough,
#     diarrhoea,
#     fatigue,
#     headache,
#     health_care_worker,
#     how_unwell,
#     loss_of_smell_and_taste,
#     muscle_ache,
#     nasal_congestion,
#     nausea_vomiting,
#     number_days_symptom_showing,
#     pregnant,
#     self_diagnosis,
#     shortness_breath,
#     sore_throat,
#     sputum,
#     temperature,
#     language,
#     loss_appetite,
#     sneezing,
#     chest_pain,
#     itchy_eyes,
#     joint_pain,
#     covid_tested,
#     number_days_symptoms,
#     asthma,
#     diabetes_type_one,
#     diabetes_type_two,
#     obesity,
#     hypertension,
#     heart_disease,
#     lung_condition,
#     liver_disease,
#     kidney_disease
#   )
# 
# data_model %>% distinct(cough)
# data_model %>% distinct(chills)
# diarrhoea <-  table(data_model$diarrhoea)
# 
# 
# 
# level_key_chills <-
#   c( 'Yes' = "Chills",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe", 
#      'No' = "Location", 
#      'No' = "Gender")
# level_key_cough <-
#   c( 'Yes' = "Cough",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe", 
#      'Yes' = 'Cough')
# 
# 
# data_sel %>% distinct(diarrhoea)
# 
# level_key_diarrhoea <-
#   c( 
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe",
#      'No' = "Diarrhoea", 
#      'No' ='Country')
# 
# data_sel %>% distinct(fatigue)
# 
# level_key_fatigue <-
#   c( 'No' = 'Date Completed', 
#      'No' = "Fatigue", 
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe" 
#      )
# 
# data_sel %>% distinct(headache)
# level_key_headache <-
#   c('No' = 'Headache', 
#     'No' = 'Care Home Worker',
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe",
#     'Yes' = "Headcahe")
# 
# data_sel %>% distinct(loss_of_smell_and_taste)
# 
# level_key_loss_smell_taste <-
#   c( 'No' = "Loss of smell and taste",
#      'No' = 'Brazil', 
#      'No' = 'Peru',
#      'No' = 'Fatigue',
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# data_sel %>% distinct(muscle_ache)
# 
# level_key_muschle_ache <-
#   c( 'No' = "Muscle Ache",
#      'No' = "2020-08-04 17:11:00", 
#      'No' = "2020-08-02 01:55:00", 
#      'No' = "2020-08-01 15:11:00", 
#      'No' = "Headcahe",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# 
# data_sel %>% distinct(nasal_congestion)
# level_key_nasal_congestion <-
#   c( 'No' = "Healthcare Worker",
#      'Yes' = "Nasal Congestion",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# 
# data_sel %>% distinct(nausea_vomiting)
# level_key_nausea_vomiting <-
#   c( 'No' = "How Unwell",
#      'Yes' = "Nausea and Vomiting",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# 
# data_sel %>% distinct(self_diagnosis)
# 
# level_key_self_diagnosis <-
#   c( 'No' = "None",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe", 
#      'No' = "Self Diagnosis", 
#      'No' = "Nasal Congestion")
# 
# data_sel %>% distinct(shortness_breath)
# level_key_short_breath <-
#   c( 'No' = "Nausea and Vomiting",
#      'Yes' = "Shortness of Breath",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# 
# data_sel %>% distinct(sore_throat)
# 
# level_key_sore_throat <-
#   c( 'No' = "Number Of Days Symptoms Showing",
#      'No' = '1', 
#      'No' = "Sore Throat",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# 
# data_sel %>% distinct(sputum)
# 
# 
# level_key_sputum <-
#   c( 'No' = "None",
#      'No' =  "Long-Standing Lung Condition",
#      'No' = "Pregnant", 
#      'Yes' = "Sputum",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# data_sel %>% distinct(care_home_worker)
# 
# level_key_care_home_worker <-
#   c(
#     'No' = 'Care Home Worker', 
#     'No' = 'Age')
# 
# data_sel %>% distinct(temperature)
# 
# level_key_temperature <- 
#   c('No' = 'Temperature',
#     'No' = "Mexico", 
#     'No' = "Reason For Helping",
#     'Yes' = "37.5-38", 
#     'Yes' = "38.1-39", 
#     'Yes' = "39.1-41", 
#     'Yes' = "38.2-39")
# 
# data_sel %>% distinct(loss_appetite)
# 
# level_key_loss_appetite <- 
#   c('No' = "Loss of Appetite", 
#     'No' = "Shortness of Breath")
# 
# data_sel %>% distinct(sneezing)
# 
# level_key_sneezing <- 
#   c('No' = "Sneezing", 
#     'No' = "Sore Throat")
# 
# data_sel %>% distinct(chest_pain)
# 
# level_key_chest_pain <- 
#   c('No' = 'Chest Pain', 
#     'No' = '0', 
#     'No' = 'Sputum')
# 
# data_sel %>% distinct(itchy_eyes)
# 
# level_key_itchy_eyes <- 
#   c('No' = "Itchy Eyes", 
#     'No' = "Temperature")
# 
# data_sel %>% distinct(joint_pain)
# 
# level_key_joint_pain <- 
#   c('No' = 'Joint Pain', 
#     'No' = "Showing Symptoms But Not Tested", 
#     'No' = "Language")
# 
# # # #### Refactor the levels ##################################################
# data_categ_nosev <- data_sel %>%
#   dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills),
#                 cough = forcats::fct_recode(cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(headache, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(loss_of_smell_and_taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muschle_ache),
#                 nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(temperature, !!!level_key_temperature), 
#                 loss_appetite = forcats::fct_recode(loss_appetite, !!!level_key_loss_appetite), 
#                 sneezing = forcats::fct_recode(sneezing, !!!level_key_sneezing), 
#                 chest_pain = forcats::fct_recode(chest_pain, !!!level_key_chest_pain), 
#                 itchy_eyes = forcats::fct_recode(itchy_eyes, !!!level_key_itchy_eyes), 
#                 joint_pain = forcats::fct_recode(joint_pain, !!!level_key_joint_pain))
# 
# write.csv(data_categ_nosev, file = "/Users/gabrielburcea/Rprojects/stats_data_whole/data_categ_nosev.csv", row.names = FALSE)

# test <- data_categ_nosev %>%
#   dplyr::mutate(asthma_diabetes_one = if_else(asthma == 'Yes' | diabetes_type_one == "Yes" , TRUE, FALSE),
#                 asthma_diabetes_two = if_else(asthma == 'Yes' | diabetes_type_two == "Yes" , TRUE, FALSE),
#                 asthma_hypertension = if_else(asthma == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
#                 asthma_obesity = if_else(asthma == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 asthma_heart_disease = if_else(asthma == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 asthma_lung_cond = if_else(asthma == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 asthma_liver_disease = if_else(asthma == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 asthma_kidney_disease = if_else(asthma == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_one_diabetes_two = if_else(diabetes_type_one == 'Yes' | diabetes_type_one == "Yes" , TRUE,FALSE ),
#                 diabetes_one_hypertension = if_else(diabetes_type_one == 'Yes' | hypertension == 'Yes' , TRUE,  FALSE),
#                 diabetes_one_obesity = if_else(diabetes_type_one == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 diabetes_one_heart_disease = if_else(diabetes_type_one == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_one_lung_cond = if_else(diabetes_type_one == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
#                 diabetes_one_liver_disease = if_else(diabetes_type_one == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_one_kidney_disease = if_else(diabetes_type_one == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_two_hypertension = if_else(diabetes_type_two == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
#                 diabetes_two_obesity = if_else(diabetes_type_two == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 diabetes_two_disease = if_else(diabetes_type_two == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_two_lung_cond = if_else(diabetes_type_two == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 diabetes_two_liver_disease = if_else(diabetes_type_two == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 diabetes_two_kidney_disease = if_else(diabetes_type_two == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 hypertension_obesity = if_else(hypertension == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
#                 hypertension_heart_disease = if_else(hypertension == 'Yes' | heart_disease == 'Yes' , TRUE,FALSE ),
#                 hypertension_lung_cond = if_else(hypertension == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
#                 hypertension_liver_disease = if_else(hypertension == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 hypertension_kidney_disease = if_else(hypertension == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 obesity_heart_disease = if_else(obesity == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
#                 obesity_lung_cond = if_else(obesity == 'Yes' | lung_condition == 'Yes' , TRUE,  FALSE),
#                 obesity_liver_disease = if_else(obesity == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 obesity_kidney_disease = if_else(obesity == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 heart_disease_lung_cond = if_else(heart_disease == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
#                 heart_disease_liver_disease = if_else(heart_disease == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 heart_disease_kidney_disease = if_else(heart_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 lung_condition_liver_disease = if_else(lung_condition == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
#                 lung_condition_kidney_disease = if_else(lung_condition == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
#                 liver_disease_kidney_disease = if_else(liver_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE))

#  write.csv(test, file = "/Users/gabrielburcea/Rprojects/data/data_no_sev_stats.csv", row.names = FALSE)

# # ######################################################################################################################################
# # ######### Get a numeric dataset ######################################################################################################
# # ######################################################################################################################################
# # 
# data <- read.csv("/Users/gabrielburcea/Rprojects/data/PivotMappe060520r.csv", header = TRUE, sep = ",")
# data_select <- data %>%
#   #### rename reason for helping as it contains whether respondents have been tested negative or positive
#   dplyr::rename(tested_or_not = 'Reason.For.Helping') %>%
#   tidyr::separate('Long.Standing.Health.Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
#                                                    'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight',
#                                                    'Comorbidity_nine'), sep = ",")
# df_comorbidity <- data_select %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   dplyr::group_by(ID) %>%
#   tidyr::drop_na() %>%
#   dplyr::mutate(number_morbidities = n())
# data_rec <- data_select  %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   tidyr::drop_na('Comorbidity') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 'Yes') %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
#   dplyr::select(-None)
# df_comorbidity_unique <- distinct(df_comorbidity, ID, .keep_all = TRUE)
# df_comor_piv_wide <- df_comorbidity_unique %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 1) %>%
#   dplyr::select(-Comorbidity_count) %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 0)) %>%
#   dplyr::select(-None)
# ########################################
# #### Loading libraries needed ##########
# ########################################
# library(caret)
# library(corrplot)
# library(tidyverse)
# library(e1071)
# library(DMwR)
# library(lattice)
# library(pROC)
# library(ROCR)
# library(ggplot2)
# library(reshape2)
# library(leaps)
# library(MASS)
# library(rms)
# level_key <-
#   c(
#     "None" = 'none',
#     "Curious" = "none",
#     'Showing Symptoms But Not Tested,Curious' = "showing symptoms",
#     'Showing Symptoms But Not Tested' = "showing symptoms",
#     'Self-Isolating With No Symptoms' = "none",
#     'Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms' = "showing symptoms",
#     'Tested Positive' = 'positive',
#     'Curious,Self-Isolating With No Symptoms' = 'none',
#     'Tested Negative But Have Symptoms' = 'showing symptoms',
#     'Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus' = 'live_with_scorona',
#     'Live With Someone With Coronavirus,Curious' = 'live_with_scorona',
#     'Tested Negative But Have Symptoms,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Negative But Have Symptoms,Curious' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Self-Isolating With No Symptoms' = 'positive',
#     'Showing Symptoms But Not Tested,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'showing symptoms',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms' = 'showing symptoms',
#     'Tested Positive,Curious' = 'positive',
#     'Tested Positive,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Live With Someone With Coronavirus' = 'positive',
#     'Recovered But Have New Symptoms,Curious' = 'positive',
#     'Live With Someone With Coronavirus,Self-Isolating With No Symptoms' = 'live_with_scorona',
#     'Tested Positive,Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms' = 'live_with_scorona',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious' = 'showing symptoms',
#     'Recovered But Have New Symptoms,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms' = 'showing symptoms',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Showing Symptoms But Not Tested,Live With Someone With Coronavirus' = 'showing symptoms',
#     'Tested Positive,Recovered But Have New Symptoms,Curious' = 'positive',
#     'Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms' = 'showing symptoms',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious'  = 'showing symptoms'
#   )

# # #################################################
# # ######### Get a numeric dataset #################
# # #################################################
# level_key_temperature <-
#   c( "38.1-39" = '38.2-39',
#      "38.1-39" = 'Temperature')
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# data_model <- df_comor_piv_wide %>%
#   dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key),
#                 number_days_symptoms = forcats::fct_recode(Number.Of.Days.Symptoms.Showing, !!!level_no_days_sympt_show) )
# data_model$gender <- as.factor(data_model$Gender)
# data_model$country <- as.factor(data_model$Country)
# data_model$chills <- as.factor(data_model$Chills)
# data_model$cough  <- as.factor(data_model$Cough)
# data_model$diarrhoea  <- as.factor(data_model$Diarrhoea)
# data_model$fatigue  <- as.factor(data_model$Fatigue)
# data_model$headache   <- as.factor(data_model$Headcahe)
# data_model$loss_smell_taste   <- as.factor(data_model$Loss.of.smell.and.taste)
# data_model$muscle_ache  <- as.factor(data_model$Muscle.Ache)
# data_model$nasal_congestion <- as.factor(data_model$Nasal.Congestion)
# data_model$nausea_vomiting  <- as.factor(data_model$Nausea.and.Vomiting)
# data_model$self_diagnosis <- as.factor(data_model$Self.Diagnosis)
# data_model$shortness_breath <- as.factor(data_model$Shortness.of.Breath)
# data_model$sore_throat <- as.factor(data_model$Sore.Throat)
# data_model$sputum <- as.factor(data_model$Sputum)
# data_model$temperature  <- as.factor(data_model$Temperature)
# data_model$health_care_worker <- as.factor(data_model$Healthcare.Worker)
# data_model$care_home_worker <- as.factor(data_model$Care.Home.Worker)
# data_model$asthma   <- as.factor(data_model$`Asthma (managed with an inhaler)`)
# data_model$diabetes_type_two <- as.factor(data_model$`Diabetes Type 2`)
# data_model$obesity <- as.factor(data_model$Obesity)
# data_model$hypertension  <- as.factor(data_model$`High Blood Pressure (hypertension)`)
# data_model$heart_disease  <- as.factor(data_model$`Long-Standing Heart Disease`)
# data_model$kidney_disease <- as.factor(data_model$`Long-Standing Kidney Disease`)
# data_model$lung_condition <- as.factor(data_model$`Long-Standing Lung Condition`)
# data_model$liver_disease <- as.factor(data_model$`Long-Standing Liver Disease`)
# data_model$diabetes_type_one <- as.factor(data_model$`Diabetes Type 1 (controlled by insulin)`)
# data_model$how_unwell <- as.factor(data_model$How.Unwell)
# data_model$age <- as.factor(data_model$Age)
# data_model$covid_tested <- as.factor(data_model$Covid_tested)
# level_key_chills <-
#   c( '1' = "Chills",
#      '0' = "No",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_cough <-
#   c( '1' = "Cough",
#      '0' = "No",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# 
# level_key_diarrhoea <-
#   c( '0' = "No",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# 
# level_key_fatigue <-
#   c( '0' = "No",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_headache <-
#   c( '0' = "No",
#      '1' = "Headcahe",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_loss_smell_taste <-
#   c( '0' = "No",
#      '1' = "Loss of smell and taste",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_muschle_ache <-
#   c( '0' = "No",
#      '1' = "Muscle Ache",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_nasal_congestion <-
#   c( '0' = "No",
#      '1' = "Nasal Congestion",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_nausea_vomiting <-
#   c( '0' = "No",
#      '1' = "Nausea and Vomiting",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_self_diagnosis <-
#   c( '0' = "None",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_short_breath <-
#   c( '0' = "No",
#      '1' = "Shortness of Breath",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_sore_throat <-
#   c( '0' = "No",
#      '1' = "Sore Throat",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_sputum <-
#   c( '0' = "No",
#      '1' = "Sputum",
#      '1' = "Mild",
#      '2' = "Moderate",
#      '3' = "Severe")
# level_key_temperature <-
#   c( '0' = "No",
#      '1' = "Temperature",
#      '1' = "37.5-38",
#      '2' = "38.1-39",
#      '2' = "38.2-39",
#      '3' =  "39.1-41")
# level_key_care_home_worker <-
#   c('1' = 'Yes',
#     '0' = 'No')
# level_key_health_care_worker <-
#   c('1' = 'Yes',
#     '0' = 'No')
# level_key_gender <-
#   c('1' = "Male",
#     "2" = "Female",
#     '99' = 'Other')
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# #### Refactor the levels ##################################################
# data_numeric <- data_model %>%
#   dplyr::mutate(covid_tested = dplyr::recode(Covid_tested, !!!level_key),
#                 chills = forcats::fct_recode(chills, !!!level_key_chills),
#                 cough = forcats::fct_recode(cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(headache, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(loss_smell_taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muschle_ache),
#                 nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(temperature, !!!level_key_temperature),
#                 care_home_worker = forcats::fct_recode(care_home_worker, !!!level_key_care_home_worker),
#                 number_days_symptoms = forcats::fct_recode( number_days_symptoms, !!!level_no_days_sympt_show),
#                 health_care_worker = forcats::fct_recode(health_care_worker, !!!level_key_health_care_worker))
# data_final <- data_numeric %>%
#   dplyr::select(ID, covid_tested, country, gender, age, number_days_symptoms, care_home_worker, health_care_worker, how_unwell, self_diagnosis,
#                 chills, cough, diarrhoea, fatigue, headache, loss_smell_taste,
#                 muscle_ache, nasal_congestion, nausea_vomiting,  shortness_breath, sore_throat,
#                 sputum, temperature, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease,
#                 lung_condition, liver_disease, hypertension, kidney_disease, number_morbidities)
# data_no_sev_stats <- data_final
# write.csv(data_no_sev_stats, file = "/Users/gabrielburcea/Rprojects/stats_data_whole/data_no_sev_stats.csv", row.names = FALSE)
