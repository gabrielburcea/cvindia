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


##################################################################
############### Rename the categories in different variables #####
##################################################################
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

level_key_chills <- 
  c( '1' = "Chills", 
     '1' = "No",
     '2' = "Mild", 
      '3' = "Moderate", 
      '4' = "Severe")

level_key_cough <- 
  c( '1' = "Cough", 
     '1' = "No",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_diarrhoea <- 
  c( '1' = "No",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")
     
level_key_fatigue <- 
  c( '1' = "No",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")


level_key_headache <- 
  c( '1' = "No",
     '1' = "Headcahe",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_loss_smell_taste <- 
  c( '1' = "No",
     '1' = "Loss of smell and taste", 
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_muschle_ache <- 
  c( '1' = "No",
     '1' = "Muscle Ache", 
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_nasal_congestion <-
  c( '1' = "No",
     '1' = "Nasal Congestion",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_nausea_vomiting <- 
  c( '1' = "No",
     '1' = "Nausea and Vomiting",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_self_diagnosis <- 
  c( '1' = "None",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_short_breath <- 
  c( '1' = "No",
     '1' = "Shortness of Breath",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_sore_throat <- 
  c( '1' = "No",
     '1' = "Sore Throat",
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")

level_key_sputum <- 
  c( '1' = "No",
     '1' = "Sputum", 
     '2' = "Mild", 
     '3' = "Moderate", 
     '4' = "Severe")


level_key_temperature <- 
  c( "38.1-39" = '38.2-39', 
     "38.1-39" = 'Temperature')

level_key_care_home_worker <- 
  c('1' = 'Yes',
    '2' = 'No')

level_key_gender <- 
  c('1' = "Male", 
    "2" = "Female")

#################################################################################################
##########Set the independent variables as factor and transform data into dataframe ############
################################################################################################

data_select$tested_or_not <- as.factor(data_select$tested_or_not)
data_select <- as.data.frame(data_select)

#################################################################################
################# Recode the levels into the ones set up above ##################
#################################################################################

#################################################################################
############Recoding into numerical values for categorical variables ############
#################################################################################
data_rec <- data_select %>% 
  dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key),
                chills = forcats::fct_recode(Chills, !!!level_key_chills), 
                cough = forcats::fct_recode(Cough, !!!level_key_cough),
                diarrhoea = forcats::fct_recode(Diarrhoea, !!!level_key_diarrhoea),
                fatigue = forcats::fct_recode(Fatigue, !!!level_key_fatigue),
                headache = forcats::fct_recode(Headcahe, !!!level_key_headache),
                loss_smell_taste = forcats::fct_recode(Loss.of.smell.and.taste, !!!level_key_loss_smell_taste),
                muscle_ache = forcats::fct_recode(Muscle.Ache, !!!level_key_muschle_ache),
                nasal_congestion = forcats::fct_recode(Nasal.Congestion, !!!level_key_nasal_congestion),
                nausea_vomiting = forcats::fct_recode(Nausea.and.Vomiting, !!!level_key_nausea_vomiting),
                self_diagnosis = forcats::fct_recode(Self.Diagnosis, !!!level_key_self_diagnosis),
                shortness_breath = forcats::fct_recode(Shortness.of.Breath, !!!level_key_short_breath),
                sore_throat = forcats::fct_recode(Sore.Throat, !!!level_key_sore_throat),
                sputum = forcats::fct_recode(Sputum, !!!level_key_sputum),
                temperature = forcats::fct_recode(Temperature, !!!level_key_temperature), 
                care_home_worker = forcats::fct_recode(Care.Home.Worker, !!!level_key_care_home_worker), 
                gender = forcats::fct_recode(Gender, !!!level_key_gender)) %>%
  dplyr::select(ID, Country, gender, Age, Covid_tested,  chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, 
                muscle_ache, nasal_congestion, nausea_vomiting, self_diagnosis, shortness_breath, sore_throat,
                sputum, temperature, care_home_worker,  Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four,
                Comorbidity_five, Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine)

############################################################################################################
########### Get the categories = morbidities into columns and set them with 1 = FALSE AND 2 TRUE ###########
###########in case the respondents have one of the comorbidities ###########################################

data_model <- data_rec  %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'), 
                      names_to = 'Comorbidity_count', 
                      values_to = 'Comorbidity') %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 2) %>%
  tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 1)) %>%
  dplyr::select(-None)


#####################################
data_final_numeric <- data_model

#write.csv(data_final_numeric, file = "/Users/gabrielburcea/Rprojects/data/data_final_numeric.csv", row.names = FALSE)

