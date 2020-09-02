library(tidyverse)
library(naniar)
library(forcats)
# data_rec <-
#   read_csv("/Users/gabrielburcea/rprojects/data/your.md/18_08_csvdata.csv")

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
reason_for_help_levels <-
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
# ###########################################################
# ### Get patients without multiple comorbidities but also count the number of patients
# make sure count on unique number of patients  #########
# ##########################################################
data_c <- df_unique %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'),
                      names_to = 'Comorbidity_count',
                      values_to = 'Comorbidity') %>%
  dplyr::mutate(Comorbidity = if_else(Comorbidity == "None", NA_character_, Comorbidity)) %>%
  distinct() %>%
  dplyr::group_by(id) %>%
  mutate(number_morbidities = sum(!is.na(Comorbidity))) %>%
  dplyr::filter(Comorbidity_count == "Comorbidity_one") # if running only the for data viz then uncomment this line since it takes out all the other comorbidities
data_unique_comorb <- data_c %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'),
                      names_to = 'Comorbidity_count',
                      values_to = 'Comorbidity') %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 'Yes') %>%
  tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
  dplyr::select(-Comorbidity_one)
# # # # # #################################################
# # # # # ######### Get a numeric dataset #################
# # # # # #################################################
data_model <- data_unique_comorb %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
  dplyr::mutate(covid_tested = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels)) %>%
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
# # # #### Refactor the levels ##################################################
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
data_sel %>% distinct(cough)

data_model %>% distinct(chills)

level_key_chills <-
  c( 'Yes' = "Chills",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe",
     'No' = "Location",
     'No' = "Gender")
level_key_cough <-
  c( 'Yes' = "Cough",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe",
     'Yes' = 'Cough')
data_sel %>% distinct(diarrhoea)
level_key_diarrhoea <-
  c(
    'Yes' = "Mild",
    'Yes' = "Moderate",
    'Yes' = "Severe",
    'No' = "Diarrhoea",
    'No' ='Country')
data_sel %>% distinct(fatigue)
level_key_fatigue <-
  c( 'No' = 'Date Completed',
     'No' = "Fatigue",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe"
  )
data_sel %>% distinct(headache)
level_key_headache <-
  c('No' = 'Headache',
    'No' = 'Care Home Worker',
    'Yes' = "Mild",
    'Yes' = "Moderate",
    'Yes' = "Severe",
    'Yes' = "Headcahe")
data_sel %>% distinct(loss_of_smell_and_taste)
level_key_loss_smell_taste <-
  c( 'No' = "Loss of smell and taste",
     'No' = 'Brazil',
     'No' = 'Peru',
     'No' = 'Fatigue',
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(muscle_ache)
level_key_muschle_ache <-
  c( 'No' = "Muscle Ache",
     'No' = "2020-08-04 17:11:00",
     'No' = "2020-08-02 01:55:00",
     'No' = "2020-08-01 15:11:00",
     'No' = "Headcahe",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(nasal_congestion)
level_key_nasal_congestion <-
  c( 'No' = "Healthcare Worker",
     'Yes' = "Nasal Congestion",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(nausea_vomiting)
level_key_nausea_vomiting <-
  c( 'No' = "How Unwell",
     'Yes' = "Nausea and Vomiting",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(self_diagnosis)
level_key_self_diagnosis <-
  c( 'No' = "None",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe",
     'No' = "Self Diagnosis",
     'No' = "Nasal Congestion")
data_sel %>% distinct(shortness_breath)
level_key_short_breath <-
  c( 'No' = "Nausea and Vomiting",
     'Yes' = "Shortness of Breath",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(sore_throat)
level_key_sore_throat <-
  c( 'No' = "Number Of Days Symptoms Showing",
     'No' = '1',
     'No' = "Sore Throat",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
data_sel %>% distinct(sputum)
level_key_sputum <-
  c( 'No' = "None",
     'No' =  "Long-Standing Lung Condition",
     'No' = "Pregnant",
     "No" = 'High Blood Pressure (hypertension),No,No,Yes,No,2,No,Showing Symptoms But Not Tested,Mild,No,No,No,No,Portuguese,No, No,No,No,No\n380a7278-700f-441f-9c7c-6013e80f2f78,62,Male,"Cd. Madero Tamaulipas',
     'Yes' = "Sputum",
     'Yes' = "Mild",
     'Yes' = "Moderate",
     'Yes' = "Severe")
level_key_care_home_worker <-
  c(
    'No' = 'Care Home Worker',
    'No' = 'Age')
data_sel %>% distinct(temperature)
level_key_temperature <-
  c('No' = 'Temperature',
    'No' = "Mexico",
    'No' = "Reason For Helping",
    'Yes' = "37.5-38",
    'Yes' = "38.1-39",
    'Yes' = "39.1-41",
    'Yes' = "38.2-39")
data_sel %>% distinct(loss_appetite)
level_key_loss_appetite <-
  c('No' = "Loss of Appetite",
    'No' = "Shortness of Breath")
data_sel %>% distinct(sneezing)
level_key_sneezing <-
  c('No' = "Sneezing",
    'No' = "Sore Throat")
data_sel %>% distinct(chest_pain)
level_key_chest_pain <-
  c('No' = 'Chest Pain',
    'No' = '0',
    'No' = 'Sputum')
data_sel %>% distinct(itchy_eyes)
level_key_itchy_eyes <-
  c('No' = "Itchy Eyes",
    'No' = "Temperature")
data_sel %>% distinct(joint_pain)
level_key_joint_pain <-
  c('No' = 'Joint Pain',
    'No' = "Showing Symptoms But Not Tested",
    'No' = "Language")
itchy_eyes_t <- table(data_sel$itchy_eyes)
# # #### Refactor the levels ##################################################
data_categ_nosev <- data_sel %>%
  dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills),
                cough = forcats::fct_recode(cough, !!!level_key_cough),
                diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
                fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
                headache = forcats::fct_recode(headache, !!!level_key_headache),
                loss_smell_taste = forcats::fct_recode(loss_of_smell_and_taste, !!!level_key_loss_smell_taste),
                muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muschle_ache),
                nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
                nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
                self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
                shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
                sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
                sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
                temperature = forcats::fct_recode(temperature, !!!level_key_temperature),
                loss_appetite = forcats::fct_recode(loss_appetite, !!!level_key_loss_appetite),
                sneezing = forcats::fct_recode(sneezing, !!!level_key_sneezing),
                chest_pain = forcats::fct_recode(chest_pain, !!!level_key_chest_pain),
                itchy_eyes = forcats::fct_recode(itchy_eyes, !!!level_key_itchy_eyes),
                joint_pain = forcats::fct_recode(joint_pain, !!!level_key_joint_pain))
sputum_lev <- table(data_categ_nosev$sputum)
# make sure you know which structure of comorbidities written as  one patient may encounter multiple comorbidities, yet when running stats on it make the patient has only one comorbidity
#write.csv(data_categ_nosev, file = "/Users/gabrielburcea/Rprojects/data/your.md/cleaned_data_18_08_2020_unique_comorbidities.csv", row.names = FALSE)
