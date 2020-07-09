# data_rec <- read.csv("/Users/gabrielburcea/Rprojects/data/PivotMappe060520r.csv", header = TRUE, sep = ",")
# data_select <- data_rec %>%
#   #### rename reason for helping as it contains whether respondents have been tested negative or positive
#   dplyr::rename(tested_or_not = 'Reason.For.Helping') %>%
#   tidyr::separate('Long.Standing.Health.Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
#                                                    'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight','Comorbidity_nine'), sep = ",")
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
#   dplyr::mutate(Condition = 'Yes') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
#   dplyr::select(-None)
# 
# # ########################################
# # #### Loading libraries needed ##########
# # ########################################
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
#    )
# 
# 
# # # #################################################
# # # ######### Get a numeric dataset #################
# # # #################################################
# 
# level_key_temperature <-
#   c( "38.1-39" = '38.2-39',
#      "38.1-39" = 'Temperature')
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# 
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
# data_model$id <- as.character(data_model$ID)
# data_model$covid_tested <- as.factor(data_model$Covid_tested)
# data_model$age <- as.numeric(data_model$Age)
# data_model$gender <- as.factor(data_model$Gender)
# data_model$country <- as.character(data_model$Country)
# data_model$pregnant <- as.factor(data_model$Pregnant)
# data_model$date_completed <- as.Date(data_model$Date.Completed)
# data_model$location <- as.character(data_model$Location)
# 
# 
# # # #### Refactor the levels ##################################################
# data_sel <- data_model %>%
#   dplyr::select(
#     ID,
#     covid_tested,
#     tested_or_not,
#     age,
#     gender,
#     country,
#     location,
#     pregnant,
#     date_completed,
#     care_home_worker,
#     health_care_worker,
#     how_unwell,
#     self_diagnosis,
#     number_days_symptoms,
#     chills,
#     cough,
#     diarrhoea,
#     fatigue,
#     headache,
#     loss_smell_taste,
#     muscle_ache,
#     nasal_congestion,
#     nausea_vomiting,
#     shortness_breath,
#     sore_throat,
#     sputum,
#     temperature,
#     asthma,
#     diabetes_type_one,
#     diabetes_type_two,
#     obesity,
#     hypertension,
#     heart_disease,
#     lung_condition,
#     liver_disease,
#     kidney_disease,
#     number_morbidities
#   )
# level_key_chills <-
#   c( 'Yes' = "Chills",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_cough <-
#   c( 'Yes' = "Cough",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_diarrhoea <-
#   c( 'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_fatigue <-
#   c( 'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_headache <-
#   c('No' = "No",
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe",
#     'Yes' = "Headcahe")
# level_key_loss_smell_taste <-
#   c( 'Yes' = "Loss of smell and taste",
#      'No' = "No",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_muschle_ache <-
#   c( 'No' = "No",
#      'Yes' = "Muscle Ache",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_nasal_congestion <-
#   c( 'No' = "No",
#      'Yes' = "Nasal Congestion",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_nausea_vomiting <-
#   c( 'No' = "No",
#      'Yes' = "Nausea and Vomiting",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_self_diagnosis <-
#   c( 'No' = "None",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_short_breath <-
#   c( 'No' = "No",
#      'Yes' = "Shortness of Breath",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_sore_throat <-
#   c( 'No' = "No",
#      'Yes' = "Sore Throat",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_sputum <-
#   c( 'No' = "No",
#      'Yes' = "Sputum",
#      'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# level_key_care_home_worker <-
#   c('Yes' = 'Yes',
#     'No' = 'No')
# 
# # #### Refactor the levels ##################################################
# data_not_sev <- data_sel %>%
#   dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills),
#                 cough = forcats::fct_recode(cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(headache, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(loss_smell_taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muschle_ache),
#                 nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath= forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(temperature, !!!level_key_temperature))
# 
# data_categ_nosev <- data_not_sev
# 
# write.csv(data_categ_nosev, file = "/Users/gabrielburcea/Rprojects/stats_data_whole/data_categ_no_sev.csv", row.names = FALSE)
# 
# # # 
# # # test <- data_categ_nosev %>%
# # #   dplyr::mutate(asthma_diabetes_one = if_else(asthma == 'Yes' | diabetes_type_one == "Yes" , TRUE, FALSE),
# # #                 asthma_diabetes_two = if_else(asthma == 'Yes' | diabetes_type_two == "Yes" , TRUE, FALSE),
# # #                 asthma_hypertension = if_else(asthma == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
# # #                 asthma_obesity = if_else(asthma == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
# # #                 asthma_heart_disease = if_else(asthma == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
# # #                 asthma_lung_cond = if_else(asthma == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
# # #                 asthma_liver_disease = if_else(asthma == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 asthma_kidney_disease = if_else(asthma == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 diabetes_one_diabetes_two = if_else(diabetes_type_one == 'Yes' | diabetes_type_one == "Yes" , TRUE,FALSE ),
# # #                 diabetes_one_hypertension = if_else(diabetes_type_one == 'Yes' | hypertension == 'Yes' , TRUE,  FALSE),
# # #                 diabetes_one_obesity = if_else(diabetes_type_one == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
# # #                 diabetes_one_heart_disease = if_else(diabetes_type_one == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
# # #                 diabetes_one_lung_cond = if_else(diabetes_type_one == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
# # #                 diabetes_one_liver_disease = if_else(diabetes_type_one == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 diabetes_one_kidney_disease = if_else(diabetes_type_one == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # # 
# # #                 diabetes_two_hypertension = if_else(diabetes_type_two == 'Yes' | hypertension == 'Yes' , TRUE, FALSE),
# # #                 diabetes_two_obesity = if_else(diabetes_type_two == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
# # #                 diabetes_two_disease = if_else(diabetes_type_two == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
# # #                 diabetes_two_lung_cond = if_else(diabetes_type_two == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
# # #                 diabetes_two_liver_disease = if_else(diabetes_type_two == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 diabetes_two_kidney_disease = if_else(diabetes_type_two == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 hypertension_obesity = if_else(hypertension == 'Yes' | obesity == 'Yes' , TRUE, FALSE),
# # #                 hypertension_heart_disease = if_else(hypertension == 'Yes' | heart_disease == 'Yes' , TRUE,FALSE ),
# # #                 hypertension_lung_cond = if_else(hypertension == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE),
# # #                 hypertension_liver_disease = if_else(hypertension == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 hypertension_kidney_disease = if_else(hypertension == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 obesity_heart_disease = if_else(obesity == 'Yes' | heart_disease == 'Yes' , TRUE, FALSE),
# # #                 obesity_lung_cond = if_else(obesity == 'Yes' | lung_condition == 'Yes' , TRUE,  FALSE),
# # #                 obesity_liver_disease = if_else(obesity == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 obesity_kidney_disease = if_else(obesity == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 heart_disease_lung_cond = if_else(heart_disease == 'Yes' | lung_condition == 'Yes' , TRUE, FALSE ),
# # #                 heart_disease_liver_disease = if_else(heart_disease == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 heart_disease_kidney_disease = if_else(heart_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 lung_condition_liver_disease = if_else(lung_condition == 'Yes' | liver_disease == 'Yes' , TRUE, FALSE),
# # #                 lung_condition_kidney_disease = if_else(lung_condition == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE),
# # # 
# # #                 liver_disease_kidney_disease = if_else(liver_disease == 'Yes' | kidney_disease == 'Yes' , TRUE, FALSE))
# # # 
# # # 
# # # write.csv(test, file = "/Users/gabrielburcea/Rprojects/data/data_no_sev_stats.csv", row.names = FALSE)
# # 
# # 
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
# 
# df_comorbidity <- data_select %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   dplyr::group_by(ID) %>%
#   tidyr::drop_na() %>%
#   dplyr::mutate(number_morbidities = n())
# 
# 
# 
# # data_rec <- data_select  %>%
# #   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
# #                       names_to = 'Comorbidity_count',
# #                       values_to = 'Comorbidity') %>%
# #   tidyr::drop_na('Comorbidity') %>%
# #   dplyr::select(-Comorbidity_count) %>%
# #   dplyr::distinct() %>%
# #   dplyr::mutate(Condition = 'Yes') %>%
# #   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
# #   dplyr::select(-None)
# 
# df_comorbidity_unique <- distinct(df_comorbidity, ID, .keep_all = TRUE)
# 
# 
# df_comor_piv_wide <- df_comorbidity_unique %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 2) %>%
#   dplyr::select(-Comorbidity_count) %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 1)) %>%
#   dplyr::select(-None)
# 
# ########################################
# #### Loading libraries needed ##########
# ########################################
# # library(caret)
# # library(corrplot)
# # library(tidyverse)
# # library(e1071)
# # library(DMwR)
# # library(lattice)
# # library(pROC)
# # library(ROCR)
# # library(ggplot2)
# # library(reshape2)
# # library(leaps)
# # library(MASS)
# # library(rms)
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
# 
# 
# 
# # #################################################
# # ######### Get a numeric dataset #################
# # #################################################
# 
# level_key_temperature <-
#   c( "38.1-39" = '38.2-39',
#      "38.1-39" = 'Temperature')
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# 
# data_model <- df_comor_piv_wide %>%
#   dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key),
#                 number_days_symptoms = forcats::fct_recode(Number.Of.Days.Symptoms.Showing, !!!level_no_days_sympt_show) )
# 
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
# 
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
# 
# 
# level_key_chills <-
#   c( '2' = "Chills",
#      '1' = "No",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_cough <-
#   c( '2' = "Cough",
#      '1' = "No",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_diarrhoea <-
#   c( '1' = "No",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_fatigue <-
#   c( '1' = "No",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# 
# level_key_headache <-
#   c( '1' = "No",
#      '2' = "Headcahe",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_loss_smell_taste <-
#   c( '1' = "No",
#      '2' = "Loss of smell and taste",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_muschle_ache <-
#   c( '1' = "No",
#      '2' = "Muscle Ache",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_nasal_congestion <-
#   c( '1' = "No",
#      '2' = "Nasal Congestion",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_nausea_vomiting <-
#   c( '1' = "No",
#      '2' = "Nausea and Vomiting",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_self_diagnosis <-
#   c( '1' = "None",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_short_breath <-
#   c( '1' = "No",
#      '2' = "Shortness of Breath",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_sore_throat <-
#   c( '1' = "No",
#      '2' = "Sore Throat",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# level_key_sputum <-
#   c( '1' = "No",
#      '2' = "Sputum",
#      '2' = "Mild",
#      '3' = "Moderate",
#      '4' = "Severe")
# 
# 
# level_key_temperature <-
#   c( '1' = "No",
#      '2' = "Temperature",
#      '2' = "37.5-38",
#      '3' = "38.1-39",
#      '3' = "38.2-39",
#      '4' =  "39.1-41")
# 
# level_key_care_home_worker <-
#   c('1' = 'Yes',
#     '2' = 'No')
# 
# level_key_health_care_worker <-
#   c('1' = 'Yes',
#     '2' = 'No')
# 
# level_key_gender <-
#   c('1' = "Male",
#     "2" = "Female",
#     '99' = 'Other')
# 
# level_no_days_sympt_show <-
#   c('21' = "More than 21")
# 
# 
# 
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
# 
# data_numeric$number_days_symptoms <- as.numeric(data_numeric$number_days_symptoms)
# data_numeric$gender <- as.factor(data_numeric$Gender)
# data_numeric$country <- as.factor(data_numeric$Country)
# data_numeric$chills <- as.numeric(data_numeric$chills)
# data_numeric$cough  <- as.numeric(data_numeric$cough)
# data_numeric$diarrhoea  <- as.numeric(data_numeric$diarrhoea)
# data_numeric$fatigue  <- as.numeric(data_numeric$fatigue)
# data_numeric$headache   <- as.numeric(data_numeric$headache)
# data_numeric$loss_smell_taste   <- as.numeric(data_numeric$loss_smell_taste)
# data_numeric$muscle_ache  <- as.numeric(data_numeric$muscle_ache)
# data_numeric$nasal_congestion <- as.numeric(data_numeric$nasal_congestion)
# data_numeric$nausea_vomiting  <- as.numeric(data_numeric$nausea_vomiting)
# data_numeric$self_diagnosis <- as.numeric(data_numeric$self_diagnosis)
# data_numeric$shortness_breath <- as.numeric(data_numeric$shortness_breath)
# data_numeric$sore_throat <- as.numeric(data_numeric$sore_throat)
# data_numeric$sputum <- as.numeric(data_numeric$sputum)
# data_numeric$temperature  <- as.numeric(data_numeric$temperature)
# data_numeric$health_care_worker <- as.numeric(data_numeric$health_care_worker)
# data_numeric$care_home_worker <- as.numeric(data_numeric$care_home_worker)
# data_numeric$asthma   <- as.numeric(data_numeric$`Asthma (managed with an inhaler)`)
# data_numeric$diabetes_type_two <- as.numeric(data_numeric$`Diabetes Type 2`)
# data_numeric$obesity <- as.numeric(data_numeric$Obesity)
# data_numeric$hypertension  <- as.numeric(data_numeric$`High Blood Pressure (hypertension)`)
# data_numeric$heart_disease  <- as.numeric(data_numeric$`Long-Standing Heart Disease`)
# data_numeric$kidney_disease <- as.numeric(data_numeric$`Long-Standing Kidney Disease`)
# data_numeric$lung_condition <- as.numeric(data_numeric$`Long-Standing Lung Condition`)
# data_numeric$liver_disease <- as.numeric(data_numeric$`Long-Standing Liver Disease`)
# data_numeric$diabetes_type_one <- as.numeric(data_numeric$`Diabetes Type 1 (controlled by insulin)`)
# data_numeric$how_unwell <- as.numeric(data_numeric$how_unwell)
# data_numeric$age <- as.numeric(data_numeric$Age)
# data_numeric$covid_tested <- as.factor(data_numeric$Covid_tested)
# 
# data_final <- data_numeric %>%
#   dplyr::select(ID, covid_tested, country, gender, age, number_days_symptoms, care_home_worker, health_care_worker, how_unwell, self_diagnosis,
#                 chills, cough, diarrhoea, fatigue, headache, loss_smell_taste,
#                 muscle_ache, nasal_congestion, nausea_vomiting,  shortness_breath, sore_throat,
#                 sputum, temperature, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease,
#                 lung_condition, liver_disease, hypertension, kidney_disease, number_morbidities)
# 
# data_no_sev_stats <- data_final
# write.csv(data_no_sev_stats, file = "/Users/gabrielburcea/Rprojects/stats_data_whole/data_no_sev_stats.csv", row.names = FALSE)
