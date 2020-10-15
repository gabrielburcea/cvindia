#' age_adjusted_sympt_dst
#'
#' @param data 
#' @param country_select 
#' @param sympt 
#' @param table 
#'
#' @return
#' @export
#'
#' @examples
age_adjusted_sympt_dst <- function(data, country_select, sympt, table = TRUE) {
  
  data_select <- data %>%
    dplyr::select(id, age, Country, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, 
                  nausea_vomiting, shortness_breath, sore_throat, sputum, temperature, loss_appetite, covid_tested) %>%
    dplyr::mutate(age_recoded = replace(age, age > 100, NA_real_)) %>%
    dplyr::rename(country = Country) %>%
    dplyr::filter(covid_tested == "positive")
  
  #get the age bands
  data_age_band <- data_select %>%
    dplyr::mutate(age_recoded_band = dplyr::case_when(
      age_recoded == 0 | age_recoded <= 19 ~ '0-19',
      age_recoded == 20 | age_recoded <= 39 ~ '20-39',
      age_recoded == 40 | age_recoded <= 59 ~ '40-59',
      age_recoded >= 60 ~ "60+"))

  # get the country age_recoded_bands counts
  
  data_country_age_band <- data_age_band %>%
    dplyr::select(id, country, age_recoded_band) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_study_pop = dplyr::n())
  
  
  # get the country age_recoded_bands and specific pre-existing condition 
  # 1.use pivot_loger to get comorbidities as rows 
  age_band_symptoms_pv <- data_age_band %>%
    tidyr::pivot_longer(cols = 4:21, 
                        names_to = "symptoms", 
                        values_to = "Bolean") %>%
    dplyr::filter(Bolean != "No")
  

  # get the counts of a pre-existing cond for a certain country across age_bands
  cnt_country_age_band_symptoms <- age_band_symptoms_pv %>%
    dplyr::filter(country == country_select & symptoms == sympt) %>% 
    dplyr::group_by(age_recoded_band, country, symptoms) %>%
    dplyr::summarise(count_study_pop_sympt = dplyr::n()) %>%
    tidyr::drop_na()
  
  # join the data country age band and age band comorbidities
  dt_study_pop_age_sympt <- dplyr::left_join(data_country_age_band, cnt_country_age_band_symptoms) %>% 
    tidyr::drop_na()
  
  dt_study_pop <- dt_study_pop_age_sympt %>%
    dplyr::mutate(study_symptom_rate = count_study_pop_sympt/count_age_study_pop)
  
  # get the counts of respondents by age band in the standard population
  dt_cnt_age_band_standard_pop <- data_age_band %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_group_standard_pop = dplyr::n()) %>% 
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  # join the dt_cnt_age_band_standard_pop to dt_study_pop_age_comorb
  
  study_pop_standard_pop <- dplyr::left_join(dt_study_pop, dt_cnt_age_band_standard_pop)
  
  # get the expected study population comorbidity
  
  dt_expected_study_pop_sympt <- study_pop_standard_pop %>%
    dplyr::mutate(expected_sympt_study_pop = count_age_group_standard_pop * study_symptom_rate) %>%
    tidyr::drop_na()
  
  
  
  final_adj_sympt_age_adj_rate <- dplyr::left_join(dt_expected_study_pop_sympt, study_pop_standard_pop)
  
  # get the total expected study pop comorb and total comorb age group in standard pop and the get total expected comorb in the study pop
  dt_total_expected_standard_pop <- final_adj_sympt_age_adj_rate %>%
    dplyr::ungroup() %>%
    dplyr::mutate(total_expected_study_pop_sympt = sum(expected_sympt_study_pop)) %>%
    dplyr::mutate(total_counts_stnd_pop = sum(count_age_group_standard_pop)) %>%
    dplyr::mutate(standardised_existing_sympt_rate = total_expected_study_pop_sympt/total_counts_stnd_pop *100)
  
  dt_select_final <-round(dt_total_expected_standard_pop[1, 11], digits = 2)
  
  title <- "Standardised"
  add_to_title <- sympt
  add_last_word <- " rate in"
  country = country_select
  
  whole_title <- paste(title, add_to_title, add_last_word, country)
  
  whole_title
  
  if(table == TRUE){ 
    
    dt_total_expected_standard_pop %>% rename(!!whole_title := standardised_existing_sympt_rate)
    
  }else{
    
    dt_select_final %>% rename(!!whole_title := standardised_existing_sympt_rate)
    
  }
  
}









  
  
