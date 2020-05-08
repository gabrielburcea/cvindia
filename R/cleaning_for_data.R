# library(tidyverse)
# #### Capitalises the first letter of strings for variable location 
# data_loc <- str_to_title(data$Location)

#data_loc <- mutate_geocode(location_df, location)
#####

# 
# clean_and_recode <- function(data, which_vars = c(ID, AGE), vars_recode = c(Age, Gender) , age_recode = TRUE){
#   
#   select_dt <- data %>% 
#     dplyr::select(which_vars) %>%
#     dplyr::rename(vars_recode)
#   
#   if(age_recode == TRUE) {
#     
#    select_dt <- selec_dt %>%
#       dplyr::mutate(age_band = case_when(Age == 0 ~ '0',
#                                          Age == 1 | Age <= 4 ~ '1-4',
#                                          Age == 5 | Age <= 9 ~ '5-9',
#                                          Age == 10 | Age <= 14 ~ '10-14',
#                                          Age == 15 | Age <= 19 ~ '15-19',
#                                          Age == 20 | Age <= 24 ~ '20-24',
#                                          Age == 25 | Age <= 29 ~ '25-29',
#                                          Age == 30 | Age <= 34 ~ '30-34',
#                                          Age == 35 | Age <= 39 ~ '35-39',
#                                          Age == 40 | Age <= 44 ~ '40-44',
#                                          Age == 45 | Age <= 49 ~ '45-49',
#                                          Age == 50 | Age <= 54 ~ '50-54',
#                                          Age == 55 | Age <= 59 ~ '55-59',
#                                          Age == 60 | Age <= 64 ~ '60-64',
#                                          Age == 65 | Age <= 69 ~ '65-69',
#                                          Age == 70 | Age <= 74 ~ '70-74',
#                                          Age == 75 | Age <= 79 ~ '75-79',
#                                          Age == 80 | Age <= 84 ~ '80-84',
#                                          Age == 85 | Age <= 89 ~ '85-89',
#                                          Age == 90 | Age <= 94 ~ '90-94',
#                                          Age >= 95  ~ '95+'))
#     
#     
#   }else{
#     
#     
#     
#   }
#     
#    
#   
#   
# 
#     
#     
#   
# }
# 
# 
# count_plot_self_diagnosis <- function(data, data_completed, plot = TRUE, title = "Test") {
#   
#   
#   #### Count self diagnosis ############
#   count_self_diagnosis <- select_dt %>%
#     dplyr::select(id, self_diagnosis) %>%
#     dplyr::group_by(self_diagnosis) %>%
#     dplyr::summarise(Count_groups = n()) %>%
#     dplyr::mutate(Freq = Count_groups/sum(Count_groups))
#   
#   
# }
# 
# 
#   
# 
# dplyr::select(ID, Age, Gender, Location, Country, Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell', 
#               'Long Standing Health Issues', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 'Number Of Days Symptoms Showing', 
#               'Pregnant', 'Self Diagnosis', 'Shortness of Breath', 'Sore Throat', 'Sputum', 'Temperature') %>%
#   dplyr::rename( id = ID,
#                  age = Age,
#                  gender = Gender,
#                  location =  Location, 
#                  country = Country,
#                  chills = Chills,
#                  diarrhoea = Diarrhoea, 
#                  fatigue = Fatigue, 
#                  headache = Headcahe, 
#                  healthcare_worker = 'Healthcare Worker', 
#                  how_unwell = 'How Unwell', 
#                  long_standing_health = 'Long Standing Health Issues', 
#                  loss_smell_taste = 'Loss of smell and taste', 
#                  muscle_ache = 'Muscle Ache', 
#                  nasal_congestion = 'Nasal Congestion', 
#                  nausea_vomiting = 'Nausea and Vomiting', 
#                  no_days_symptoms_show = 'Number Of Days Symptoms Showing', 
#                  pregnant =  'Pregnant', 
#                  shortness_breath = 'Shortness of Breath', 
#                  sore_throat = 'Sore Throat', 
#                  sputum = 'Sputum', 
#                  temperature = 'Temperature', 
#                  self_diagnosis = 'Self Diagnosis') #%>%
# 
# 
# 
# 
# data_ed_anonim %>%
#   dplyr::mutate(Age = case_when(Age == 0 ~ '0',
#                                      Age == 1 | Age <= 4 ~ '1-4',
#                                      Age == 5 | Age <= 9 ~ '5-9',
#                                      Age == 10 | Age <= 14 ~ '10-14',
#                                      Age == 15 | Age <= 19 ~ '15-19',
#                                      Age == 20 | Age <= 24 ~ '20-24',
#                                      Age == 25 | Age <= 29 ~ '25-29',
#                                      Age == 30 | Age <= 34 ~ '30-34',
#                                      Age == 35 | Age <= 39 ~ '35-39',
#                                      Age == 40 | Age <= 44 ~ '40-44',
#                                      Age == 45 | Age <= 49 ~ '45-49',
#                                      Age == 50 | Age <= 54 ~ '50-54',
#                                      Age == 55 | Age <= 59 ~ '55-59',
#                                      Age == 60 | Age <= 64 ~ '60-64',
#                                      Age == 65 | Age <= 69 ~ '65-69',
#                                      Age == 70 | Age <= 74 ~ '70-74',
#                                      Age == 75 | Age <= 79 ~ '75-79',
#                                      Age == 80 | Age <= 84 ~ '80-84',
#                                      Age == 85 | Age <= 89 ~ '85-89',
#                                      Age == 90 | Age <= 94 ~ '90-94',
#                                      Age >= 95  ~ '95+'))
