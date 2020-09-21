library(tidyverse)
library(naniar)
library(forcats)
data_rec <-  read_csv("/Users/gabrielburcea/rprojects/data/your.md/csvdata_21092020.csv")
nrow(distinct(data_rec))
data_rename <- data_rec %>%
  dplyr::rename(
    id = ID,
    age = Age,
    gender = Gender,
    location = Location,
    country = Country,
    chills = Chills,
    cough = Cough,
    diarrhoea = Diarrhoea,
    fatigue = Fatigue,
    headache = Headcahe,
    pregnant = Pregnant,
    sputum = Sputum,
    temperature = Temperature,
    sneezing = Sneezing,
    loss_of_smell_and_taste = "Loss of smell and taste",
    muscle_ache = 'Muscle Ache',
    nasal_congestion = "Nasal Congestion",
    nausea_vomiting = "Nausea and Vomiting",
    self_diagnosis = "Self Diagnosis",
    shortness_breath = "Shortness of Breath",
    sore_throat = "Sore Throat",
    loss_appetite = "Loss of Appetite",
    chest_pain = "Chest Pain",
    itchy_eyes = "Itchy Eyes",
    joint_pain = "Joint Pain",
    care_home_worker = 'Care Home Worker',
    health_care_worker = "Healthcare Worker",
    date_completed = 'Date Completed',
    how_unwell = "How Unwell",
    number_days_symptom_showing = "Number Of Days Symptoms Showing",
    reason_for_help = "Reason For Helping",
    language = Language,
    health_condition = "Long Standing Health Issues"
  ) %>%
  dplyr::mutate(id = str_sub(id, -10))

data_com <- data_rename %>%
  rowwise() %>%
  mutate(health_condition =
           str_extract_all(health_condition,
                           pattern = "None|Diabetes Type 2|Asthma \\(managed with an inhaler\\)|Obesity|High Blood Pressure \\(hypertension\\)|Long-Standing Lung Condition|Long-Standing Liver Disease|Long-Standing Heart Disease|Long-Standing Kidney Disease|Diabetes Type 1 \\(controlled by insulin\\)"),
         health_condition =  paste(health_condition, collapse = ","))
data_com$health_condition <- sub("^$", "None", data_com$health_condition)

unique(data_com$reason_for_help)
reason_for_help_levels_1 <-
  c(
    "negative" = "Curious",
    "negative" =  "Curious,Self-Isolating With No Symptoms" ,
    "negative" = "Live With Someone With Coronavirus",
    "negative" = "Live With Someone With Coronavirus,Curious" ,
    "negative" = "Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms",
    "negative" = "Live With Someone With Coronavirus,Self-Isolating With No Symptoms",
    "negative" = "Muscle Ache",
    "negative" = "No",
    "negative" = "None",
    "negative" = "Reason For Helping",
    "showing symptoms" = "Recovered But Have New Symptoms",
    "showing symptoms" = "Recovered But Have New Symptoms,Curious",
    "showing symptoms" = "Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Recovered But Have New Symptoms,Self-Isolating With No Symptoms",
    "negative" = "Self-Isolating With No Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested",
    "showing symptoms" = "Showing Symptoms But Not Tested,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Curious",
    "showing symptoms" = "Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus",
    "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "positive" = "Tested Positive",
    "positive" = "Tested Positive,Curious",
    "positive" = "Tested Positive,Live With Someone With Coronavirus",
    "positive" = "Tested Positive,Recovered But Have New Symptoms",
    "positive" = "Tested Positive,Recovered But Have New Symptoms,Curious",
    "positive" = "Tested Positive,Self-Isolating With No Symptom",
    "positive" = "Tested Positive,Showing Symptoms But Not Tested",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "positive" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptom)",
    "positive" =  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "positive" = "Tested Positive,Self-Isolating With No Symptoms"
  )


reason_for_help_levels_2 <-
  c(
    "negative" = "Curious",
    "negative" =  "Curious,Self-Isolating With No Symptoms" ,
    "negative" = "Live With Someone With Coronavirus",
    "negative" = "Live With Someone With Coronavirus,Curious" ,
    "negative" = "Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms",
    "negative" = "Live With Someone With Coronavirus,Self-Isolating With No Symptoms",
    "negative" = "Muscle Ache",
    "negative" = "No",
    "negative" = "None",
    "negative" = "Reason For Helping",
    "showing symptoms" = "Recovered But Have New Symptoms",
    "showing symptoms" = "Recovered But Have New Symptoms,Curious",
    "showing symptoms" = "Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Recovered But Have New Symptoms,Self-Isolating With No Symptoms",
    "negative" = "Self-Isolating With No Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested",
    "showing symptoms" = "Showing Symptoms But Not Tested,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms",
    "showing symptoms" = "Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious",
    "showing symptoms" = "Showing Symptoms But Not Tested,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Curious",
    "showing symptoms" = "Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus",
    "showing symptoms" = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Self-Isolating With No Symptoms",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
    "showing symptoms" = "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "positive" = "Tested Positive",
    "positive" = "Tested Positive,Curious",
    "positive" = "Tested Positive,Live With Someone With Coronavirus",
    "positive" = "Tested Positive,Recovered But Have New Symptoms",
    "positive" = "Tested Positive,Recovered But Have New Symptoms,Curious",
    "positive" = "Tested Positive,Self-Isolating With No Symptom",
    "showing_symptoms" = "Tested Positive,Showing Symptoms But Not Tested",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "showing_symptoms" = "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptom)",
    "showing_symptoms" =  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
    "positive" = "Tested Positive,Self-Isolating With No Symptoms"
  )




data_comorb <- data_com %>%
  tidyr::separate(
    health_condition,
    c(
      'Comorbidity_one',
      'Comorbidity_two',
      'Comorbidity_three',
      'Comorbidity_four',
      'Comorbidity_five',
      'Comorbidity_six',
      'Comorbidity_seven',
      'Comorbidity_eight',
      'Comorbidity_nine'
    ),
    sep = ","
  )
data_comorb %>% distinct(Comorbidity_one)
data_comorb %>% distinct(Comorbidity_two)
data_comorb %>% distinct(Comorbidity_three)
data_comorb %>% distinct(Comorbidity_four)
data_comorb %>% distinct(Comorbidity_five)
data_comorb %>% distinct(Comorbidity_six)
data_comorb %>% distinct(Comorbidity_seven)
data_comorb %>% distinct(Comorbidity_eight)
data_comorb %>% distinct(Comorbidity_nine)
data_long_wid <- data_comorb  %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'),
                      names_to = 'Comorbidity_count',
                      values_to = 'Comorbidity') %>%
  naniar::replace_with_na(replace = list(Comorbidity = "None")) %>%
  distinct() %>%
  dplyr::group_by(id) %>%
  dplyr::mutate(number_morbidities = sum(!is.na(Comorbidity))) %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 'Yes') %>%
  tidyr::pivot_wider(names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No'))
df_unique <- distinct(data_comorb, id, .keep_all = TRUE)
###########################################################
### Get patients without multiple comorbidities but also count the number of patients
### make sure count on unique number of patients  #########
##########################################################
data_c <- df_unique %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'),
                      names_to = 'Comorbidity_count',
                      values_to = 'Comorbidity') %>%
  dplyr::mutate(Comorbidity = if_else(Comorbidity == "None", NA_character_, Comorbidity)) %>%
  distinct() %>%
  dplyr::group_by(id) %>%
  mutate(number_morbidities = sum(!is.na(Comorbidity))) #%>%
  #dplyr::filter(Comorbidity_count == "Comorbidity_one") # if running only the for data viz then uncomment this line since it takes out all the other comorbidities
data_multiple_comorb <- data_c %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'),
                      names_to = 'Comorbidity_count',
                      values_to = 'Comorbidity') %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 'Yes') %>%
  tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
  dplyr::select(-Comorbidity_one)
# # # # #################################################
# # # # ######### Get a numeric dataset #################
# # # # #################################################
data_model <- data_multiple_comorb %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
  dplyr::mutate(covid_tested_1 = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels_1), 
                covid_tested_2 = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels_2)) %>%
  dplyr::select(-reason_for_help)



data_model$gender <- as.factor(data_model$gender)
data_model$country <- as.factor(data_model$country)
data_model$chills <- as.factor(data_model$chills)
data_model$cough  <- as.factor(data_model$cough)
data_model$diarrhoea  <- as.factor(data_model$diarrhoea)
data_model$fatigue  <- as.factor(data_model$fatigue)
data_model$headache   <- as.factor(data_model$headache)
data_model$loss_of_smell_and_taste   <- as.factor(data_model$loss_of_smell_and_taste)
data_model$muscle_ache  <- as.factor(data_model$muscle_ache)
data_model$nasal_congestion <- as.factor(data_model$nasal_congestion)
data_model$nausea_vomiting  <- as.factor(data_model$nausea_vomiting)
data_model$self_diagnosis <- as.factor(data_model$self_diagnosis)
data_model$shortness_breath <- as.factor(data_model$shortness_breath)
data_model$sore_throat <- as.factor(data_model$sore_throat)
data_model$sputum <- as.factor(data_model$sputum)
data_model$temperature  <- as.factor(data_model$temperature)
data_model$health_care_worker <- as.factor(data_model$health_care_worker)
data_model$care_home_worker <- as.factor(data_model$care_home_worker)
data_model$asthma   <- as.factor(data_model$`Asthma (managed with an inhaler)`)
data_model$diabetes_type_two <- as.factor(data_model$`Diabetes Type 2`)
data_model$obesity <- as.factor(data_model$Obesity)
data_model$hypertension  <- as.factor(data_model$`High Blood Pressure (hypertension)`)
data_model$heart_disease  <- as.factor(data_model$`Long-Standing Heart Disease`)
data_model$kidney_disease <- as.factor(data_model$`Long-Standing Kidney Disease`)
data_model$lung_condition <- as.factor(data_model$`Long-Standing Lung Condition`)
data_model$liver_disease <- as.factor(data_model$`Long-Standing Liver Disease`)
data_model$diabetes_type_one <- as.factor(data_model$`Diabetes Type 1 (controlled by insulin)`)
data_model$how_unwell <- as.factor(data_model$how_unwell)
data_model$covid_tested <- as.factor(data_model$covid_tested)
data_model$id <- as.character(data_model$id)
data_model$age <- as.numeric(data_model$age)
data_model$gender <- as.factor(data_model$gender)
data_model$pregnant <- as.factor(data_model$pregnant)
data_model$date_completed <- as.Date(data_model$date_completed)
data_model$location <- as.factor(data_model$location)
data_model$loss_appetite <- as.factor(data_model$loss_appetite)
data_model$sneezing <- as.factor(data_model$sneezing)
data_model$chest_pain <- as.factor(data_model$chest_pain)
data_model$itchy_eyes <- as.factor(data_model$itchy_eyes)
data_model$joint_pain <- as.factor(data_model$joint_pain)
# # #### Refactor the levels ##################################################
data_sel <- data_model %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
  dplyr::select(
    id,
    covid_tested,
    age,
    gender,
    country,
    location,
    date_completed,
    care_home_worker,
    chills,
    cough,
    diarrhoea,
    fatigue,
    headache,
    health_care_worker,
    how_unwell,
    loss_of_smell_and_taste,
    muscle_ache,
    nasal_congestion,
    nausea_vomiting,
    number_days_symptom_showing,
    pregnant,
    self_diagnosis,
    shortness_breath,
    sore_throat,
    sputum,
    temperature,
    language,
    loss_appetite,
    sneezing,
    chest_pain,
    itchy_eyes,
    joint_pain,
    covid_tested,
    asthma,
    diabetes_type_one,
    diabetes_type_two,
    obesity,
    hypertension,
    heart_disease,
    lung_condition,
    liver_disease,
    kidney_disease,
    number_morbidities
  )


unique(data_sel$'chills')

level_key_chills <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_chills <- c("Gender", "Chills")

data <- data_sel %>%
  dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills))
  
data_na <- data %>%
  dplyr::mutate(across(starts_with('chills'),
                       ~ replace(., . %in% na_strings_chills, NA)))

table(data_na$chills)



# Cough #
unique(data_sel$cough)

level_key_cough <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_cough <- c("Cough", "Location")

data <- data_sel %>%
  dplyr::mutate(cough = forcats::fct_recode(cough, !!!level_key_cough))

data_na <- data %>%
  dplyr::mutate(across(starts_with('cough'),
                       ~ replace(., . %in% na_strings_cough, NA)))

table(data_na$cough)



#  diarrhoea

level_key_diarrhoea <-
  c('Yes' = "Mild",
    'Yes' = "Moderate",
    'Yes' = "Severe")

unique(data_sel$diarrhoea)

na_strings_diarrhoea <- c("Diarrhoea", "Country")

data <- data_sel %>%
  dplyr::mutate(diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea))

data_na <- data %>%
  dplyr::mutate(across(starts_with('diarrhoea'),
                       ~ replace(., . %in% na_strings_diarrhoea, NA)))

table(data_na$diarrhoea)




# fatigue


unique(data_sel$fatigue)

level_key_fatigue <-
  c( 
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe"
  )

na_strings_fatigue <- c('Date Completed', "Fatigue")

data <- data_sel %>%
  dplyr::mutate(fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue))

data_na <- data %>%
  dplyr::mutate(across(starts_with('fatigue'),
                       ~ replace(., . %in% na_strings_fatigue, NA)))

table(data_na$fatigue)


### headache


unique(data_sel$headache)

level_key_headache <-
  c(
    'Yes' = "Mild",
    'Yes' = "Moderate",
    'Yes' = "Severe")

na_strings_headache <- c('Headache', 'Care Home Worker')

data <- data_sel %>%
  dplyr::mutate(headache = forcats::fct_recode(headache, !!!level_key_headache))

data_na <- data %>%
  dplyr::mutate(across(starts_with('headache'),
                       ~ replace(., . %in% na_strings_headache, NA)))

table(data_na$headache)



# loss of smell and taste

loss_smell_unique <- unique(data_sel$loss_of_smell_and_taste)

level_key_loss_smell_taste <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")


na_strings_loss_smell_taste <- c('Loss of smell and taste',
                                 'Brazil', 'Peru', 'Fatigue', 'Obesity', 'Diabetes Type 2', 
                                 'Diabetes Type 1 (controlled by insulin)', 
                                 'High Blood Pressure (hypertension)', 'Long-Standing Kidney Disease')

data <- data_sel %>%
  dplyr::mutate(loss_smell_taste = forcats::fct_recode(loss_of_smell_and_taste, !!!level_key_loss_smell_taste))

data_na <- data %>%
  dplyr::mutate(across(starts_with('loss_smell_taste'),
                       ~ replace(., . %in% na_strings_loss_smell_taste, NA)))

table(data_na$loss_smell_taste)




# Muscle Ache 


unique(data_sel$muscle_ache)

level_key_muscle_ache <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")


na_strings_muscle_ache <- c( "Muscle Ache",
                             "2020-08-04 17:11:00",
                             "2020-08-02 01:55:00",
                             "2020-08-01 15:11:00",
                             "Headcahe", "Diabetes Type 2", "Long-Standing Liver Disease", "Obesity")

data <- data_sel %>%
  dplyr::mutate(muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muscle_ache))

data_na <- data %>%
  dplyr::mutate(across(starts_with('muscle_ache'),
                       ~ replace(., . %in% na_strings_muscle_ache, NA)))

table(data_na$muscle_ache)


# nasal congestion


unique(data_sel$nasal_congestion)

level_key_nasal_congestion <-
  c( 
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_nasal_congestion <- c("Healthcare Worker",
                            "Nasal Congestion",
                            "Obesity")

data <- data_sel %>%
  dplyr::mutate(nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion))

data_na <- data %>%
  dplyr::mutate(across(starts_with('nasal_congestion'),
                       ~ replace(., . %in% na_strings_nasal_congestion, NA)))

table(data_na$nasal_congestion)


# nausea and vomiting 

unique(data_sel$nausea_vomiting)

level_key_nausea_vomiting <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_nausea_vomiting <- c("Healthcare Worker", "How Unwell",  "Nausea and Vomiting", "Nasal Congestion", "Obesity")

data <- data_sel %>%
  dplyr::mutate(nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting))

data_na <- data %>%
  dplyr::mutate(across(starts_with('nausea_vomiting'),
                       ~ replace(., . %in% na_strings_nausea_vomiting, NA)))

table(data_na$nausea_vomiting)



# self diagnosis

unique(data_sel$self_diagnosis)

level_key_self_diagnosis <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")


na_strings_self_diagnosis <- c("None", "Self Diagnosis",
                               "Nasal Congestion", "Showing Symptoms But Not Tested", "Tested Positive",                  
                               "Recovered But Have New Symptoms", "Tested Negative But Have Symptoms",  
                               "Self-Isolating With No Symptoms", "0")

data <- data_sel %>%
  dplyr::mutate(self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis))

data_na <- data %>%
  dplyr::mutate(across(starts_with('self_diagnosis'),
                       ~ replace(., . %in% na_strings_self_diagnosis, NA)))

table(data_na$self_diagnosis)




# shortness of breath

unique(data_sel$shortness_breath)

level_key_short_breath <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_shortness_breath <- c("Shortness of Breath", "Nausea and Vomiting", "Showing Symptoms But Not Tested", 
                               "Tested Positive", "Self-Isolating With No Symptoms", "None", "Recovered But Have New Symptoms",
                               "Tested Negative But Have Symptoms")

data <- data_sel %>%
  dplyr::mutate(shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath))

data_na <- data %>%
  dplyr::mutate(across(starts_with('shortness_breath'),
                       ~ replace(., . %in% na_strings_shortness_breath, NA)))

table(data_na$shortness_breath)


#sore_throat

unique(data_sel$sore_throat)
level_key_sore_throat <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")


na_strings_sore_throat <- c( "Number Of Days Symptoms Showing",
                             '1', "Sore Throat",
                             "No Number Of Days Symptoms Showing", 
                             "Sore Throat", "Tested Positive")

data <- data_sel %>%
  dplyr::mutate(sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat))

data_na <- data %>%
  dplyr::mutate(across(starts_with('sore_throat'),
                       ~ replace(., . %in% na_strings_sore_throat, NA)))

table(data_na$sore_throat)

# sputum 
unique(data_sel$sputum)
level_key_sputum <-
  c( 'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")

na_strings_sputum <- c( "None",
                             "Long-Standing Lung Condition",
                             "Pregnant",
                             'High Blood Pressure (hypertension),No,No,Yes,No,2,No,Showing Symptoms But Not Tested,Mild,No,No,No,No,Portuguese,No, No,No,No,No\n380a7278-700f-441f-9c7c-6013e80f2f78,62,Male,"Cd. Madero Tamaulipas',
                             "Sputum")

data <- data_sel %>%
  dplyr::mutate(sputum = forcats::fct_recode(sputum, !!!level_key_sputum))

data_na <- data %>%
  dplyr::mutate(across(starts_with('sputum'),
                       ~ replace(., . %in% na_strings_sputum, NA)))

table(data_na$sputum)


# care home worker
na_strings_care_home_worker <- c('Care Home Worker', 'Age')

data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('care_home_worker'),
                       ~ replace(., . %in% na_strings_care_home_worker, NA)))

table(data_na$care_home_worker)


# temperature

unique(data_sel$temperature)


level_key_temperature <-
  c('Yes' = "37.5-38",
    'Yes' = "38.1-39",
    'Yes' = "39.1-41",
    'Yes' = "38.2-39", 
    'Yes' = "38.2-39")

na_strings_temperature <- c( 'Temperature', "Mexico", "Reason For Helping")

data <- data_sel %>%
  dplyr::mutate(temperature = forcats::fct_recode(temperature, !!!level_key_temperature))

data_na <- data %>%
  dplyr::mutate(across(starts_with('temperature'),
                       ~ replace(., . %in% na_strings_temperature, NA)))

table(data_na$temperature)



# loss_appetite

unique(data_sel$loss_appetite)


na_strings_loss_appetite <- c("Loss of Appetite", "Shortness of Breath", "Spanish", "Portuguese")

data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('loss_appetite'),
                       ~ replace(., . %in% na_strings_loss_appetite, NA)))

table(data_na$loss_appetite)


# sneezing
unique(data_sel$sneezing)

na_strings_sneezing <-
  c("Sneezing",  "Sore Throat", "Portuguese", "Spanish")


data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('sneezing'),
                       ~ replace(., . %in% na_strings_sneezing, NA)))

table(data_na$sneezing)


# chest pain
unique(data_sel$chest_pain)
na_strings_chest_poin <-
  c('Chest Pain', '0','Sputum', 'Spanish')


data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('chest_pain'),
                       ~ replace(., . %in% na_strings_chest_poin, NA)))

table(data_na$chest_pain)


#itchy_eyes
unique(data_sel$itchy_eyes)
na_strings_itchy_eyes <-
  c( "Itchy Eyes","Temperature")

data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('itchy_eyes'),
                       ~ replace(., . %in% na_strings_itchy_eyes, NA)))

table(data_na$itchy_eyes)



# joint_pain

unique(data_sel$joint_pain)

na_strings_joint_pain <-
  c('Joint Pain', "Showing Symptoms But Not Tested", "Language")

data_na <- data_sel %>%
  dplyr::mutate(across(starts_with('joint_pain'),
                       ~ replace(., . %in% na_strings_joint_pain, NA)))


# make sure you know which structure of comorbidities written as  one patient may encounter multiple comorbidities, yet when running stats on it make the patient has only one comorbidity
#write.csv(data_categ_nosev, file = "/Users/gabrielburcea/Rprojects/data/your.md/cleaned_data_18_08_2020_unique_comorbidities.csv", row.names = FALSE)
