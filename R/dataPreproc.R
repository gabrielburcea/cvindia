# ########################################
# #### Loading libraries needed #########
# #######################################
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
# 
# ######################################
# ########Reading the data ############
# #####################################
# 
# data <- read.csv("~/Rprojects/data/PivotMappe060520r.csv", header = TRUE, sep = ",")
# 
# ######################################################################################################
# ################ Get the LSHI into different columns as it contains more than 1 string per row #######
# ######################################################################################################
# 
# data_select <- data %>%
#   #### rename reason for helping as it contains whether respondents have been tested negative or positive
#   dplyr::rename(tested_or_not = 'Reason.For.Helping') %>%
#   tidyr::separate('Long.Standing.Health.Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
#                                                    'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 
#                                                    'Comorbidity_nine'), sep = ",")
# 
# data_rec <- data_select  %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'), 
#                       names_to = 'Comorbidity_count', 
#                       values_to = 'Comorbidity') %>%
#   tidyr::drop_na('Comorbidity') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 2) %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 1)) %>%
#   dplyr::select(-None)
# 
# level_key <-
#   c(
#     None = 'negative',
#     Curious = "negative",
#     'Showing Symptoms But Not Tested,Curious' = "negative",
#     'Showing Symptoms But Not Tested' = "negative",
#     'Self-Isolating With No Symptoms' = "negative",
#     'Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms' = "negative",
#     'Tested Positive' = 'positive',
#     'Curious,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Negative But Have Symptoms' = 'negative',
#     'Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus' = 'positive',
#     'Live With Someone With Coronavirus,Curious' = 'negative',
#     'Tested Negative But Have Symptoms,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Negative But Have Symptoms,Curious' = 'negative',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Self-Isolating With No Symptoms' = 'positive',
#     'Showing Symptoms But Not Tested,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'negative',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms' = 'negative',
#     'Tested Positive,Curious' = 'positive',
#     'Tested Positive,Showing Symptoms But Not Tested' = 'positive',
#     'Tested Positive,Live With Someone With Coronavirus' = 'positive',
#     'Recovered But Have New Symptoms,Curious' = 'negative',
#     'Live With Someone With Coronavirus,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Positive,Recovered But Have New Symptoms' = 'positive',
#     'Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms' = 'negative',
#     'Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious' = 'negative',
#     'Recovered But Have New Symptoms,Self-Isolating With No Symptoms' = 'negative',
#     'Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious' = 'positive',
#     'Tested Positive,Tested Negative But Have Symptoms' = 'positive',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
#     'Showing Symptoms But Not Tested,Live With Someone With Coronavirus' = 'negative',
#     'Tested Positive,Recovered But Have New Symptoms,Curious' = 'positive',
#     'Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
#     'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious'  = 'negative'
#   )
# 
# 
# data_model <- data_rec %>% 
#   dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key))
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
# data_model$asthma   <- as.numeric(data_model$`Asthma (managed with an inhaler)`)
# data_model$diabetes_type_two <- as.numeric(data_model$`Diabetes Type 2`)
# data_model$obesity <- as.numeric(data_model$Obesity)
# data_model$hypertension  <- as.numeric(data_model$`High Blood Pressure (hypertension)`)
# data_model$heart_disease  <- as.numeric(data_model$`Long-Standing Heart Disease`)
# data_model$kidney_disease <- as.numeric(data_model$`Long-Standing Kidney Disease`)
# data_model$lung_condition <- as.numeric(data_model$`Long-Standing Lung Condition`)
# data_model$liver_disease <- as.numeric(data_model$`Long-Standing Liver Disease`)
# data_model$diabetes_type_one <- as.numeric(data_model$`Diabetes Type 1 (controlled by insulin)`)
# data_model$how_unwell <- as.numeric(data_model$How.Unwell)
# data_model$no_days_symptoms <- as.numeric(data_model$Number.Of.Days.Symptoms.Showing)
# data_model$age <- as.numeric(data_model$Age)
# data_model$covid_tested <- as.factor(data_model$Covid_tested)
# 
#   
# data_final_categorical <- data_model %>%
#   dplyr::select(ID, gender, country, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, 
#                 nausea_vomiting, self_diagnosis, shortness_breath, sore_throat, sputum, temperature, health_care_worker, care_home_worker, 
#                 asthma, diabetes_type_one, obesity, hypertension, heart_disease, kidney_disease, lung_condition, liver_disease, diabetes_type_two, 
#                 how_unwell, no_days_symptoms, age, covid_tested)
# 
# 
# write.csv(data_final_categorical, file = "/Users/gabrielburcea/Rprojects/data/data_final_categorical.csv", row.names = FALSE)


