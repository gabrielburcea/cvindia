#' adjusted_age_sympt
#'
#' @param data contains id, age, country,  chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
#' shortness_breath, sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain
#' @param sympt contains chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
#' shortness_breath, sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain
#' @param country_select which country under analysis
#' @param table if TRUE gives a table with all the numbers of standard population and study population
#'
#' @return
#' @export
#'
#' @examples
adjusted_age_sympt <- function(data, sympt, country_select, table = TRUE){
  
  
  data_select <- cleaned_data_22092020 %>%
    dplyr::select(id, age, Country, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, 
                  nausea_vomiting, shortness_breath, sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain) %>%
    dplyr::mutate(age_recoded = replace(age, age > 100, NA_real_)) %>%
    dplyr::rename(country = Country)
  
  #get the age bands
  data_age_band <- data_select %>%
    dplyr::mutate(age_recoded_band = dplyr::case_when(
      age_recoded == 0 | age_recoded <= 19 ~ '0-19',
      age_recoded == 20 | age_recoded <= 39 ~ '20-39',
      age_recoded == 40 | age_recoded <= 59 ~ '40-59',
      age_recoded >= 60 ~ "60+"))
  
  # get the counts of respondents by age band in the study population
  dt_cnt_age_band_resp <- data_age_band %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(standard_population_age_band = dplyr::n()) %>% drop_na()
  
  age_band_symptoms_pv <- data_age_band %>%
    tidyr::pivot_longer(cols = 4:21, 
                        names_to = "symptoms", 
                        values_to = "Bolean") %>%
    dplyr::filter(Bolean != "No")

  
  # use the study population to get the symptom counts -> this will help get my standard pop
  all_age_struct_sympt <- age_band_symptoms_pv %>%
    dplyr::select(age_recoded_band, symptoms) %>%
    dplyr::filter(symptoms == sympt) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(standard_pop_sympt = dplyr::n()) %>%
    tidyr::drop_na()
  
  # 1. get the standard population - dividing the counts per age groups by symptoms count 
  # 2. first merge the dt_cnt_age_band_resp and all_age_struct_sympt 
  # then get the division at step 1
  
  dt_standard_pop <- dplyr::left_join(dt_cnt_age_band_resp, all_age_struct_sympt) %>% tidyr::drop_na()
  
  fnl_stand_pop <- dt_standard_pop %>%
    dplyr::mutate(standard_pop_rate = standard_pop_sympt/standard_population_age_band)
  
  # get the age group per country -> add them to the fnl_stand_pop 
  country_data <- age_band_symptoms_pv  %>%
    dplyr::select(id, age_recoded_band, country) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_group_study_pop = dplyr::n()) %>%
    tidyr::drop_na()
  
  country_fnl_stand_pop <- dplyr::left_join(fnl_stand_pop, country_data) 
  
  # get the expected study pop asthma per age group 
  
  country_expct_symptoms <- country_fnl_stand_pop %>%
    dplyr::mutate(expected_sympt_study_pop = standard_pop_rate * count_age_group_study_pop)
  
  # get the total number of country responders having a certain comorbidity
  
  # find a certain comorbidity in a study pop across age group 
  study_pop_rate <- age_band_symptoms_pv %>%
    dplyr::select(id, age_recoded_band, country, symptoms) %>%
    dplyr::filter(country == country_select & symptoms == sympt) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(sympt_age_group_study_pop = dplyr::n()) %>%
    tidyr::drop_na() 
  
  
  # attach pop rate (country/comorbidity) to country_expected_comorbidity
  final_adj_sympt_rate <- dplyr::left_join(country_expct_symptoms, study_pop_rate) %>% drop_na()
  
  # get the standardised comorbidity rate
  # get the total number number of a comorbidity across age group in a certain country 
  # get the sum of expected comorbidity in study group 
  # left join the figures together into a tibble and then divide the total number of comorbidity across age group in a certain country / sum of expected comorbidity in study group
  
  
  dt_total_sum_sympt_study_pop <- final_adj_sympt_rate %>%
    mutate(total_sympt_study_pop = sum(sympt_age_group_study_pop)) %>%
    mutate(total_expected_study_pop_sympt = sum(expected_sympt_study_pop)) %>%
    mutate(standardised_existing_sympt_rate = total_sympt_study_pop/total_expected_study_pop_sympt) 
  
  
  dt_select_final <-round(dt_total_sum_sympt_study_pop[1, 10], digits = 2)
  
  dt_select_final
  
  title <- "Standardised"
  add_to_title <- sympt
  add_last_word <- " rate in"
  country = country_select
  
  whole_title <- paste(title, add_to_title, add_last_word, country)
  
  whole_title
  

  if(table == TRUE){ 
    
    dt_total_sum_sympt_study_pop %>% rename(!!whole_title := standardised_existing_sympt_rate)
    
  }else{
    
    dt_select_final %>% rename(!!whole_title := standardised_existing_sympt_rate)
    
  }
  
}

  