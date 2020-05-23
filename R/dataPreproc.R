########################################
#### Loading libraries needed #########
#######################################
library(caret)
library(corrplot)
library(tidyverse)
library(e1071)
library(DMwR)
library(lattice)
library(pROC)
library(ROCR)
library(ggplot2)
library(reshape2)
library(leaps)
library(MASS)
library(rms)

######################################
########Reading the data ############
#####################################

data <- read.csv("~/Rprojects/data/PivotMappe060520r.csv", header = TRUE, sep = ",")

######################################################################################################
################ Get the LSHI into different columns as it contains more than 1 string per row #######
######################################################################################################

data_select <- data %>%
  #### rename reason for helping as it contains whether respondents have been tested negative or positive
  dplyr::rename(tested_or_not = 'Reason.For.Helping') %>%
  tidyr::separate('Long.Standing.Health.Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
                                                   'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 
                                                   'Comorbidity_nine'), sep = ",")

data_rec <- data_select  %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'), 
                      names_to = 'Comorbidity_count', 
                      values_to = 'Comorbidity') %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 2) %>%
  tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 1)) %>%
  dplyr::select(-None)

level_key <-
  c(
    None = 'negative',
    Curious = "negative",
    'Showing Symptoms But Not Tested,Curious' = "negative",
    'Showing Symptoms But Not Tested' = "negative",
    'Self-Isolating With No Symptoms' = "negative",
    'Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms' = "negative",
    'Tested Positive' = 'positive',
    'Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms' = 'negative',
    'Recovered But Have New Symptoms' = 'positive',
    'Live With Someone With Coronavirus' = 'positive',
    'Live With Someone With Coronavirus,Curious' = 'negative',
    'Tested Negative But Have Symptoms,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms,Curious' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'positive',
    'Tested Positive,Self-Isolating With No Symptoms' = 'positive',
    'Showing Symptoms But Not Tested,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'negative',
    'Showing Symptoms But Not Tested,Recovered But Have New Symptoms' = 'negative',
    'Tested Positive,Curious' = 'positive',
    'Tested Positive,Showing Symptoms But Not Tested' = 'positive',
    'Tested Positive,Live With Someone With Coronavirus' = 'positive',
    'Recovered But Have New Symptoms,Curious' = 'negative',
    'Live With Someone With Coronavirus,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Recovered But Have New Symptoms' = 'positive',
    'Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious' = 'negative',
    'Recovered But Have New Symptoms,Self-Isolating With No Symptoms' = 'negative',
    'Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms' = 'positive',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Showing Symptoms But Not Tested,Live With Someone With Coronavirus' = 'negative',
    'Tested Positive,Recovered But Have New Symptoms,Curious' = 'positive',
    'Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious'  = 'negative'
  )


data_model <- data_rec %>% 
  dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key))


data_model<- as.data.frame(data_model)
data_model$Covid_tested <- as.factor(data_model$Covid_tested)

data_model$gender <- data_model$Gender
data_model$Age <- data_model$Age
data_model$chills <- data_model$Chills
data_model$cough  <- data_model$Cough
data_model$diarrhoea  <-data_model$Diarrhoea
data_model$fatigue  <- data_model$Fatigue
data_model$headache   <- data_model$Headcahe
data_model$loss_smell_taste   <- data_model$Loss.of.smell.and.taste
data_model$muscle_ache  <- data_model$Muscle.Ache
data_model$nasal_congestion <-data_model$Nasal.Congestion
data_model$nausea_vomiting  <- data_model$Nausea.and.Vomiting

data_categorical <- data_model %>%
  dplyr::select(Covid_tested, age, gender, country, no_days_symptoms, how_unwell, 
                diabetes_type_one, diabetes_type_two, liver_disease, lung_condition, kidney_disease, 
                heart_disease, hypertension, obesity, asthma, temperature, sputum, sore_throat, self_diagnosis, 
                nausea_vomiting, nasal_congestion, muscle_ache, loss_smell_taste, headache, fatigue, 
                diarrhoea, cough, chills)


write.csv(data_categorical, file = "/Users/gabrielburcea/Rprojects/data/data_categorical.csv", row.names = FALSE)


data_model$self_diagnosis <- data_model$Self.Diagnosis
data_model$shortness_breath <- data_model$Shortness.of.Breath
data_model$sore_throat <- data_model$Sore.Throat
data_model$sputum <- data_model$Sputum
data_model$temperature  <- data_model$Temperature
data_model$asthma   <- data_model$`Asthma (managed with an inhaler)`
data_model$diabetes_type_two <- data_model$`Diabetes Type 2`
data_model$obesity <- data_model$Obesity
data_model$hypertension  <- data_model$`High Blood Pressure (hypertension)`
data_model$heart_disease  <- data_model$`Long-Standing Heart Disease`
data_model$kidney_disease <- data_model$`Long-Standing Kidney Disease`
data_model$lung_condition <- data_model$`Long-Standing Lung Condition`
data_model$liver_disease <- data_model$`Long-Standing Liver Disease`
data_model$diabetes_type_one <- data_model$`Diabetes Type 1 (controlled by insulin)`
data_model$care_home_worker <- data_model$Care.Home.Worker
data_model$health_care_worker <- data_model$Healthcare.Worker
data_model$how_unwell <- data_model$How.Unwell
data_model$no_days_symptoms <- data_model$Number.Of.Days.Symptoms.Showing
data_model$age <- data_model$Age
data_model$country <- data_model$Country
data_model$gender <- data_model$Gender