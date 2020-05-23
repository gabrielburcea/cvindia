#### New Levels for the new dataset



#################################################
######### Get a numeric dataset #################
#################################################
# level_key_chills <- 
#   c( '1' = "Chills", 
#      '1' = "No",
#      '2' = "Mild", 
#       '3' = "Moderate", 
#       '4' = "Severe")
# 
# level_key_cough <- 
#   c( '1' = "Cough", 
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
#      '1' = "Headcahe",
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# level_key_loss_smell_taste <- 
#   c( '1' = "No",
#      '1' = "Loss of smell and taste", 
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# level_key_muschle_ache <- 
#   c( '1' = "No",
#      '1' = "Muscle Ache", 
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# level_key_nasal_congestion <-
#   c( '1' = "No",
#      '1' = "Nasal Congestion",
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# level_key_nausea_vomiting <- 
#   c( '1' = "No",
#      '1' = "Nausea and Vomiting",
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
#      '1' = "Shortness of Breath",
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# level_key_sore_throat <- 
#   c( '1' = "No",
#      '1' = "Sore Throat",
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# 
# level_key_sputum <- 
#   c( '1' = "No",
#      '1' = "Sputum", 
#      '2' = "Mild", 
#      '3' = "Moderate", 
#      '4' = "Severe")
# 
# 
# level_key_temperature <- 
#   c( "38.1-39" = '38.2-39', 
#      "38.1-39" = 'Temperature')
# 
# level_key_care_home_worker <- 
#   c('1' = 'Yes',
#     '2' = 'No')
# 
# level_key_gender <- 
#   c('1' = "Male", 
#     "2" = "Female", 
#     '99' = 'Other')

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
# data_rec <- data_select %>% 
#   dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key),
#                 chills = forcats::fct_recode(Chills, !!!level_key_chills), 
#                 cough = forcats::fct_recode(Cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(Diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(Fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(Headcahe, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(Loss.of.smell.and.taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(Muscle.Ache, !!!level_key_muschle_ache),
#                 nasal_congestion = forcats::fct_recode(Nasal.Congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(Nausea.and.Vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(Self.Diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath = forcats::fct_recode(Shortness.of.Breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(Sore.Throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(Sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(Temperature, !!!level_key_temperature), 
#                 care_home_worker = forcats::fct_recode(Care.Home.Worker, !!!level_key_care_home_worker), 
#                 gender = forcats::fct_recode(Gender, !!!level_key_gender)) %>%
#   dplyr::select(ID, Country, gender, Age, Covid_tested,  chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, 
#                 muscle_ache, nasal_congestion, nausea_vomiting, self_diagnosis, shortness_breath, sore_throat,
#                 sputum, temperature, care_home_worker,  Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four,
#                 Comorbidity_five, Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine)

############################################################################################################
########### Get the categories = morbidities into columns and set them with 1 = FALSE AND 2 TRUE ###########
###########in case the respondents have one of the comorbidities ###########################################

# data_model <- data_rec  %>%
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

#####################################
# data_final_numeric <- data_model
# 
# 
# 
# data_final_numeric <- data_final_numeric %>%
#   dplyr::select(ID, Country, gender, Age, Covid_tested, chills, 
#                 cough, diarrhoea, fatigue, headache, loss_smell_taste, 
#                 muscle_ache, nasal_congestion, nausea_vomiting, 
#                 self_diagnosis, shortness_breath, sore_throat, 
#                 sputum, temperature, care_home_worker, Asthma, 
#                 diabetes_type_two, obesity, hypertension, heart_disease, 
#                 lung_condition, liver_disease, diabetes_type_one, hypertension)
