data_rename <- PivotMapper %>%
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



reason_for_help_levels_2 <- c(
  "negative" = "Tested Negative But Have Symptoms,Self-Isolating With No Symptoms",
  "negative"  = "Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms",
  "showing symptoms" =  "Showing Symptoms But Not Tested",
  "positive" = "Tested Positive" ,
  "negative" =  "Tested Negative But Have Symptoms",
  "showing symptoms"  = "Showing Symptoms But Not Tested,Curious",
  "showing symptoms" = "Recovered But Have New Symptoms",
  "showing symptoms" =  "Showing Symptoms But Not Tested,Recovered But Have New Symptoms",
  "showing symptoms"  = "Recovered But Have New Symptoms,Curious",
  "negative"  =  "Tested Negative But Have Symptoms,Curious",
  "positive" =  "Tested Positive,Self-Isolating With No Symptoms",
  "showing symptoms" =  "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
  "negative"  = "Tested Negative But Have Symptoms,Live With Someone With Coronavirus",
  "positive" = "Tested Positive,Curious",
  "positive"  =  "Tested Positive,Live With Someone With Coronavirus",
  "positive" =  "Tested Positive,Recovered But Have New Symptoms",
  "showing symptoms" =   "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms",
  "showing symptoms" =  "Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious",
  "showing symptoms" =  "Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Curious",
  "showing symptoms" =  "Showing Symptoms But Not Tested,Live With Someone With Coronavirus",
  "positive"  = "Tested Positive,Recovered But Have New Symptoms,Curious",
  "negative"  =  "Tested Negative But Have Symptoms,Live With Someone With Coronavirus,Recovered But Have New Symptoms"
  
)
na_strings_reason_for_help_2 <- c(
  "None",
  "Self-Isolating With No Symptoms" ,
  "Curious",
  "Curious,Self-Isolating With No Symptoms",
  "Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms",
  "Live With Someone With Coronavirus",
  "Live With Someone With Coronavirus,Curious",
  "Live With Someone With Coronavirus,Self-Isolating With No Symptoms",
  "Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms",
  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested",
  "Showing Symptoms But Not Tested,Self-Isolating With No Symptoms",
  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
  "Tested Positive,Showing Symptoms But Not Tested",
  "Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms",
  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
  "Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious",
  "Tested Positive,Tested Negative But Have Symptoms",
  "Recovered But Have New Symptoms,Self-Isolating With No Symptoms",
  "Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
  "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms",
  "Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious")

data_cov <- data_rename %>% # here make sure the dataset is ritght - either patients with multiple comorbidities or patients without multitple comorbidties
  dplyr::mutate(covid_tested = forcats::fct_recode(reason_for_help, !!!reason_for_help_levels_2))

data_na <- data_cov %>%
  dplyr::mutate(across(starts_with('covid_tested'),
                       ~ replace(., . %in% na_strings_reason_for_help_2, NA)))
count_cov <- data_na %>%
  dplyr::group_by(covid_tested) %>%
  dplyr::tally()
