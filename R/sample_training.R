# test <- structure(
#   list(
#     ID = c("1",
#            "2", "3",
#            "4", "5",
#            "6"),
#     Chills = c("No", "Mild", "No", "Mild", "No", "No"),
#     Cough = c("No", "Severe", "No", "Mild", "Mild", "No"),
#     Diarrhoea = c("No", "Mild", "No", "No", "No", "No"),
#     Fatigue = c("No", "Moderate", "Mild", "Mild", "Mild", "Mild"),
#     Headcahe = c("No", "No", "No", "Mild", "No", "No"),
#     `Loss of smell and taste` = c("No", "No", "No", "No", "No", "No"),
#     `Muscle Ache` = c("No", "Moderate", "No", "Moderate", "Mild", "Mild"),
#     `Nasal Congestion` = c("No", "No", "No", "No", "Mild", "No"),
#     `Nausea and Vomiting` = c("No", "No",
#                               "No", "No", "No", "No"),
#     `Shortness of Breath` = c("No",
#                               "Mild", "No", "No", "No", "Mild"),
#     `Sore Throat` = c("No",
#                       "No", "No", "No", "Mild", "No"),
#     Sputum = c("No", "Mild",
#                "No", "Mild", "Mild", "No"),
#     Temperature = c("No", "No",
#                     "No", "No", "No", "37.5-38"),
#     Comorbidity_one = c(
#       "Asthma (managed with an inhaler)",
#       "None",
#       "Obesity",
#       "High Blood Pressure (hypertension)",
#       "None",
#       "None"
#     ),
#     Comorbidity_two = c("Diabetes Type 2", NA,
#                         NA, "Obesity", NA, NA),
#     Comorbidity_three = c(
#       "Asthma (managed with an inhaler)",
#       "None",
#       "Obesity",
#       "High Blood Pressure (hypertension)",
#       "None",
#       NA_character_
#     ),
#     Comorbidity_four = c(
#       "Asthma (managed with an inhaler)",
#       "None",
#       "High Blood Pressure (hypertension)",
#       NA_character_,
#       NA_character_,
#       NA_character_
#     ),
#     Comorbidity_five = c(
#       "Asthma (managed with an inhaler)",
#       "None",
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_
#     ),
#     Comorbidity_six = c(
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_
#     ),
#     Comorbidity_seven = c(
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_
#     ),
#     Comorbidity_eight = c(
#       "High Blood Pressure (hypertension)",
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       NA_character_
#     ),
#     Comorbidity_nine = c(
#       NA_character_,
#       NA_character_,
#       NA_character_,
#       "High Blood Pressure (hypertension)",
#       NA_character_,
#       "High Blood Pressure (hypertension)"
#     )
#   ),
#   row.names = c(NA,-6L),
#   class = c("tbl_df",
#             "tbl", "data.frame")
# )
# 
# 
# Comorbidities <- c('Asthma', 'Asthma', 'Asthma', 'Diabetes', 'Diabetes', 'Diabetes', 'High blood Pressure',  'High blood Pressure',  'High blood Pressure')
# Symptoms <- c("Cough", "Cough", "Loss of smell and taste", "Cough", "Chills mild", "Loss of smell and taste", "Cough", "Chills", "Loss of smell and taste")
# Group <- c('Mild', 'Moderate', 'Severe', 'Mild', 'Moderate', 'Severe', 'Mild', 'Moderate', 'Severe')
# Count <- c(112, 10, 10, 123, 132, 153, 897, 98, 10)
# Percentage <- c(0.23, 0.3, 0.10, 0.6, 0.5, 0.3, 0.8, 0.9, 0.5)
# 
# answer <- tibble(Comorbidities, Symptoms, Group, Count, Percentage)
# 
# dput(answer)
# 
