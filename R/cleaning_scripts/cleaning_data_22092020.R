# library(tidyverse)
# data_rec <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/PivotMapper.csv")
# nrow(distinct(data_rec))
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
#   ) %>%
#   dplyr::mutate(id = str_sub(id, -10))
# data_com <- data_rename %>%
#   rowwise() %>%
#   mutate(health_condition =
#            str_extract_all(health_condition,
#                            pattern = "None|Diabetes Type 2|Asthma \\(managed with an inhaler\\)|Obesity|High Blood Pressure \\(hypertension\\)|Long-Standing Lung Condition|Long-Standing Liver Disease|Long-Standing Heart Disease|Long-Standing Kidney Disease|Diabetes Type 1 \\(controlled by insulin\\)"),
#          health_condition =  paste(health_condition, collapse = ","))
# data_com$health_condition <- sub("^$", "None", data_com$health_condition)
# unique(data_com$reason_for_help)
# reason_for_help_levels <- c(
#     "negative" = "None",
#     "negative" =  "Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms",
#     "negative" = "Tested Negative But Have Symptoms,Self-Isolating With No Symptoms",
#      "negative" = "Tested Positive,Showing Symptoms But Not Tested",
#     "showing symptoms" =  "Showing Symptoms But Not Tested",
#     "negative" =  "Self-Isolating With No Symptoms" ,
#     "positive" = "Tested Positive" ,
#     "negative" = "Curious",
#     "showing symptoms" =  "Tested Negative But Have Symptoms",
#     "showing symptoms"  = "Showing Symptoms But Not Tested,Curious",
#     "showing symptoms" = "Recovered But Have New Symptoms",
#     "negative" =  "Curious,Self-Isolating With No Symptoms",
#     "showing symptoms" =  "Showing Symptoms But Not Tested,Recovered But Have New Symptoms",
#     "negative" =  "Live With Someone With Coronavirus",
#     "negative" =  "Live With Someone With Coronavirus,Curious",
#     "showing symptoms"  = "Recovered But Have New Symptoms,Curious",
#     "showing symptoms"  =  "Tested Negative But Have Symptoms,Curious",
#     "positive" =     "Tested Positive,Self-Isolating With No Symptoms",
#     "showing symptoms" =  "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
#     "showing symptoms"  =   "Tested Negative But Have Symptoms,Live With Someone With Coronavirus",
#     "positive" =    "Tested Positive,Curious",
#     "positive"  =    "Tested Positive,Live With Someone With Coronavirus",
#     "negative" =  "Live With Someone With Coronavirus,Self-Isolating With No Symptoms",
#     "positive" =  "Tested Positive,Recovered But Have New Symptoms",
#     "negative"  =   "Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms",
#     "showing symptoms" =   "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
#     "showing symptoms" =  "Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious",
#     "showing symptoms" =  "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Curious",
#     "showing symptoms" =  "Showing Symptoms But Not Tested,Live With Someone With Coronavirus",
#     "positive"  = "Tested Positive,Recovered But Have New Symptoms,Curious",
#     "showing symptoms"  =  "Tested Negative But Have Symptoms,Live With Someone With Coronavirus,Recovered But Have New Symptoms"
# 
#   )
# na_strings_reason_for_help <- c(
# 
#   "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
#   "Showing Symptoms But Not Tested,Self-Isolating With No Symptoms",
#   "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#   "Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms",
#   "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#   "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
#   "Tested Positive,Tested Negative But Have Symptoms",
#   "Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms",
#   "Recovered But Have New Symptoms,Self-Isolating With No Symptoms",
#   "Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#   "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
#   "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious")
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
# df_unique <- distinct(data_comorb, id, .keep_all = TRUE)
# # ###########################################################
# # ### Get patients without multiple comorbidities but also count the number of patients
# # ### make sure count on unique number of patients  #########
# # ##########################################################
# data_c <- df_unique %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   dplyr::mutate(Comorbidity = if_else(Comorbidity == "None", NA_character_, Comorbidity)) %>%
#   distinct() %>%
#   dplyr::group_by(id) %>%
#   mutate(number_morbidities = sum(!is.na(Comorbidity))) #%>%
# #dplyr::filter(Comorbidity_count == "Comorbidity_one") # if running only the for data viz then uncomment this line since it takes out all the other comorbidities
# data_multiple_comorb <- data_c %>%
#   tidyr::pivot_longer(cols = starts_with('Comorbidity'),
#                       names_to = 'Comorbidity_count',
#                       values_to = 'Comorbidity') %>%
#   tidyr::drop_na('Comorbidity') %>%
#   dplyr::select(-Comorbidity_count) %>%
#   dplyr::distinct() %>%
#   dplyr::mutate(Condition = 'Yes') %>%
#   tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 'No')) %>%
#   dplyr::select(-Comorbidity_one)
# # # # # # #################################################
# # # # # # ######### Get a numeric dataset #################
# # # # # # #################################################
# data_cov <- data_multiple_comorb %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
#   dplyr::mutate(covid_tested = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels))
# 
# data_na <- data_cov %>%
#   dplyr::mutate(across(starts_with('covid_tested'),
#                        ~ replace(., . %in% na_strings_reason_for_help, NA)))
# count_cov <- data_na %>%
#   dplyr::group_by(covid_tested) %>%
#   dplyr::tally()
# 
# count_cov
# 
# data_na$gender <- as.factor(data_na$gender)
# data_na$country <- as.factor(data_na$country)
# data_na$chills <- as.factor(data_na$chills)
# data_na$cough  <- as.factor(data_na$cough)
# data_na$diarrhoea  <- as.factor(data_na$diarrhoea)
# data_na$fatigue  <- as.factor(data_na$fatigue)
# data_na$headache   <- as.factor(data_na$headache)
# data_na$loss_of_smell_and_taste   <- as.factor(data_na$loss_of_smell_and_taste)
# data_na$muscle_ache  <- as.factor(data_na$muscle_ache)
# data_na$nasal_congestion <- as.factor(data_na$nasal_congestion)
# data_na$nausea_vomiting  <- as.factor(data_na$nausea_vomiting)
# data_na$self_diagnosis <- as.factor(data_na$self_diagnosis)
# data_na$shortness_breath <- as.factor(data_na$shortness_breath)
# data_na$sore_throat <- as.factor(data_na$sore_throat)
# data_na$sputum <- as.factor(data_na$sputum)
# data_na$temperature  <- as.factor(data_na$temperature)
# data_na$health_care_worker <- as.factor(data_na$health_care_worker)
# data_na$care_home_worker <- as.factor(data_na$care_home_worker)
# data_na$asthma   <- as.factor(data_na$`Asthma (managed with an inhaler)`)
# data_na$diabetes_type_two <- as.factor(data_na$`Diabetes Type 2`)
# data_na$obesity <- as.factor(data_na$Obesity)
# data_na$hypertension  <- as.factor(data_na$`High Blood Pressure (hypertension)`)
# data_na$heart_disease  <- as.factor(data_na$`Long-Standing Heart Disease`)
# data_na$kidney_disease <- as.factor(data_na$`Long-Standing Kidney Disease`)
# data_na$lung_condition <- as.factor(data_na$`Long-Standing Lung Condition`)
# data_na$liver_disease <- as.factor(data_na$`Long-Standing Liver Disease`)
# data_na$diabetes_type_one <- as.factor(data_na$`Diabetes Type 1 (controlled by insulin)`)
# data_na$how_unwell <- as.factor(data_na$how_unwell)
# data_na$covid_tested <- as.factor(data_na$covid_tested)
# data_na$id <- as.character(data_na$id)
# data_na$age <- as.numeric(data_na$age)
# data_na$gender <- as.factor(data_na$gender)
# data_na$pregnant <- as.factor(data_na$pregnant)
# data_na$date_completed <- as.Date(data_na$date_completed)
# data_na$location <- as.factor(data_na$location)
# data_na$loss_appetite <- as.factor(data_na$loss_appetite)
# data_na$sneezing <- as.factor(data_na$sneezing)
# data_na$chest_pain <- as.factor(data_na$chest_pain)
# data_na$itchy_eyes <- as.factor(data_na$itchy_eyes)
# data_na$joint_pain <- as.factor(data_na$joint_pain)
# # # # #### Refactor the levels ##################################################
# data_sel <- data_na %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
#   dplyr::select(
#     id,
#     #covid_tested,
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
#     asthma,
#     diabetes_type_one,
#     diabetes_type_two,
#     obesity,
#     hypertension,
#     heart_disease,
#     lung_condition,
#     liver_disease,
#     kidney_disease,
#     number_morbidities,
#     covid_tested,
#     number_morbidities,
#     reason_for_help
#   )
# # ## chills
# unique(data_sel$'chills')
# level_key_chills <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # # Cough #
# unique(data_sel$cough)
# level_key_cough <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# #  diarrhoea
# level_key_diarrhoea <-
#   c('Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe")
# unique(data_sel$diarrhoea)
# # fatigue
# unique(data_sel$fatigue)
# level_key_fatigue <-
#   c(
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe"
#   )
# ### headache
# unique(data_sel$headache)
# level_key_headache <-
#   c(
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe")
# # loss of smell and taste
# loss_smell_unique <- unique(data_sel$loss_of_smell_and_taste)
# level_key_loss_smell_taste <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # Muscle Ache
# unique(data_sel$muscle_ache)
# 
# level_key_muscle_ache <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # nasal congestion
# unique(data_sel$nasal_congestion)
# level_key_nasal_congestion <-
#   c(
#     'Yes' = "Mild",
#     'Yes' = "Moderate",
#     'Yes' = "Severe")
# # nausea and vomiting
# unique(data_sel$nausea_vomiting)
# level_key_nausea_vomiting <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # self diagnosis
# unique(data_sel$self_diagnosis)
# level_key_self_diagnosis <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # shortness of breath
# unique(data_sel$shortness_breath)
# level_key_short_breath <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# #sore_throat
# unique(data_sel$sore_throat)
# level_key_sore_throat <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # sputum
# unique(data_sel$sputum)
# level_key_sputum <-
#   c( 'Yes' = "Mild",
#      'Yes' = "Moderate",
#      'Yes' = "Severe")
# # care home worker
# na_strings_care_home_worker <- c('Care Home Worker', 'Age')
# # temperature
# unique(data_sel$temperature)
# level_key_temperature <-
#   c('Yes' = "37.5-38",
#     'Yes' = "38.1-39",
#     'Yes' = "39.1-41",
#     'Yes' = "38.2-39",
#     'Yes' = "38.2-39")
# # loss_appetite
# unique(data_sel$loss_appetite)
# # sneezing
# unique(data_sel$sneezing)
# # chest pain
# unique(data_sel$chest_pain)
# #itchy_eyes
# unique(data_sel$itchy_eyes)
# # joint_pain
# unique(data_sel$joint_pain)
# data_categ_nosev <- data_sel %>%
#   dplyr::mutate(chills = forcats::fct_recode(chills, !!!level_key_chills),
#                 cough = forcats::fct_recode(cough, !!!level_key_cough),
#                 diarrhoea = forcats::fct_recode(diarrhoea, !!!level_key_diarrhoea),
#                 fatigue = forcats::fct_recode(fatigue, !!!level_key_fatigue),
#                 headache = forcats::fct_recode(headache, !!!level_key_headache),
#                 loss_smell_taste = forcats::fct_recode(loss_of_smell_and_taste, !!!level_key_loss_smell_taste),
#                 muscle_ache = forcats::fct_recode(muscle_ache, !!!level_key_muscle_ache),
#                 nasal_congestion = forcats::fct_recode(nasal_congestion, !!!level_key_nasal_congestion),
#                 nausea_vomiting = forcats::fct_recode(nausea_vomiting, !!!level_key_nausea_vomiting),
#                 self_diagnosis = forcats::fct_recode(self_diagnosis, !!!level_key_self_diagnosis),
#                 shortness_breath = forcats::fct_recode(shortness_breath, !!!level_key_short_breath),
#                 sore_throat = forcats::fct_recode(sore_throat, !!!level_key_sore_throat),
#                 sputum = forcats::fct_recode(sputum, !!!level_key_sputum),
#                 temperature = forcats::fct_recode(temperature, !!!level_key_temperature))
# 
# 
# csvdata2209202 <- data_categ_nosev %>%
#   dplyr::mutate(age_band = dplyr::case_when(
#     age == 0 | age <= 19 ~ '0-19',
#     age == 20 | age <= 39 ~ '20-39',
#     age == 40 | age <= 59 ~ '40-59',
#     age >= 60 ~ "60+"))
# #
# country_levels <- c("United Kingdom" = "Great Britain",
#                     "USA" = "United States of America")
# 
# 
# # "Congo" = "Zair",
# # "France" = "Wallis & Futana Is",
# # "USA"    = "Virgin Islands (USA)",
# # "British Oversease Territory" = "Virgin Islands (Brit)",
# # "British Oversease Territory" = "Tuvalu",
# # "British Overseas Territory" = "Turks & Caicos Is",
# # "New Zeeland" = "Tokelau",
# # "Grenada" = "St Vincent & Grenadines"
# # "Netherlands" "St Maarten",
# # "British Overseas Territory"= "St Lucia",
# # "Pitcairn Island" =  "British Overseas Territory"  =  "St Helena",
# # "Netherlands" = "St Eustatius",
# # "British Overseas Territory"
# # "USA" =  "Saipan",
# # "USA" = "Palau Island"
# # "Nevis", "Nauru",
# # "British Overseas Territory" = "Montserrat"
# 
# csvdata_22092020 <- csvdata2209202 %>%
#   dplyr::mutate(Country = forcats::fct_recode(country, !!!country_levels))
# #
# country_unique <- as.data.frame(unique(csvdata_22092020$Country))
# 
# count_contries <- csvdata_22092020 %>%
#   dplyr::group_by(country) %>%
#   tally() %>%
#   dplyr::mutate(Perc = n/sum(n)*100)
# 
# count_contries
# 
# write.csv(csvdata_22092020, file = "/Users/gabrielburcea/Rprojects/data/your.md/cleaned_data_22092020.csv", row.names = FALSE)

# # # uplead the cleaned data into global environment and then get rid of the responders with multiple comorbidities
# # cleaned_data_22092020 <- cleaned_data_22092020 %>%
# #   dplyr::filter(number_morbidities <= 1)
# # 
# # # save the unique comorbidities dataseyt 
# cleaned_data_unique_22092020 <- cleaned_data_22092020
# write.csv(cleaned_data_unique_22092020, file = "/Users/gabrielburcea/Rprojects/data/your.md/cleaned_data_unique_22092020.csv", row.names = FALSE)