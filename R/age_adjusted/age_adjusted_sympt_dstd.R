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
age_adjusted_sympt_dst <- function(data, country_select, sympt, table_gen = TRUE) {
  
  data_select <- cleaned_data_22092020 %>%
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
    tidyr::pivot_longer(cols = 4:17, 
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
  
  
  
  #get the age bands
  data_age_band <- data_select %>%
    dplyr::mutate(age_recoded_band = dplyr::case_when(
      age_recoded == 0 | age_recoded <= 19 ~ '0-19',
      age_recoded == 20 | age_recoded <= 39 ~ '20-39',
      age_recoded == 40 | age_recoded <= 59 ~ '40-59',
      age_recoded >= 60 ~ "60+")) %>%
    dplyr::mutate(age_recoded_band_5plus = dplyr::case_when(
      age_recoded == 5 | age_recoded <= 24 ~ '5-24',
      age_recoded == 25 | age_recoded <= 44 ~ '25-44',
      age_recoded == 45 | age_recoded <= 64 ~ '45-64',
      age_recoded >= 65 ~ "65+")) %>%
    dplyr::mutate(age_recoded_band_10plus = dplyr::case_when(
      age_recoded == 10 | age_recoded <= 29 ~ '10-29',
      age_recoded == 30 | age_recoded <= 49 ~ '30-49',
      age_recoded == 50 | age_recoded <= 69 ~ '50-69',
      age_recoded >= 70 ~ "70+"))
  
  
  
  # get the country age_recoded_bands counts
  data_country_age_band <- data_age_band %>%
    dplyr::select(id, country, age_recoded_band) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_study_pop = dplyr::n()) %>%
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  data_country_age_band_5plus <- data_age_band %>%
    dplyr::select(id, country, age_recoded_band_5plus) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band_5plus) %>%
    dplyr::summarise(count_age_study_pop_5plus = dplyr::n()) %>%
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  data_country_age_band_10plus <- data_age_band %>%
    dplyr::select(id, country, age_recoded_band_10plus) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band_10plus) %>%
    dplyr::summarise(count_age_study_pop_10plus = dplyr::n()) %>%
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  
  data_country_age_band_j <- bind_cols(data_country_age_band, data_country_age_band_5plus, data_country_age_band_10plus)
  
  # get the country age_recoded_bands and specific pre-existing condition 
  # 1.use pivot_loger to get comorbidities as rows 
  age_band_sympt_pv <- data_age_band %>%
    tidyr::pivot_longer(cols = 4:17, 
                        names_to = "symptoms", 
                        values_to = "Bolean") %>%
    dplyr::filter(Bolean != "No")
  
  
  
  # get the counts of a pre-existing cond for a certain country across age_bands
  cnt_country_age_band_sympt <- age_band_sympt_pv %>%
    dplyr::filter(country == country_select & symptoms == sympt) %>%
    dplyr::group_by(age_recoded_band, country, symptoms) %>%
    dplyr::summarise(count_study_pop_sympt = dplyr::n())
  
  cnt_country_age_band_sympt_5plus <- age_band_sympt_pv %>%
    dplyr::filter(country == country_select & symptoms == sympt) %>%
    dplyr::group_by(age_recoded_band_5plus) %>%
    dplyr::summarise(count_study_pop_sympt_5plus = dplyr::n()) 
  
  cnt_country_age_band_sympt_10plus <- age_band_sympt_pv %>%
    dplyr::filter(country == country_select & symptoms == sympt) %>%
    dplyr::group_by(age_recoded_band_10plus) %>%
    dplyr::summarise(count_study_pop_sympt_10plus = dplyr::n()) 
  
  
  cnt_country_age_band_sympt_j <- bind_cols(cnt_country_age_band_sympt, cnt_country_age_band_sympt_5plus, cnt_country_age_band_sympt_10plus)
  
  # join the data country age band and age band comorbidities
  dt_study_pop_age_comorb <- dplyr::left_join(data_country_age_band_j, cnt_country_age_band_sympt_j) %>% 
    tidyr::drop_na()
  
  dt_study_pop <- dt_study_pop_age_comorb %>%
    dplyr::mutate(study_sympt_rate = count_study_pop_sympt/count_age_study_pop, 
                  study_sympt_rate_5plus = count_study_pop_sympt_5plus/count_age_study_pop_5plus, 
                  study_sympt_rate_10plus = count_study_pop_sympt_10plus/count_age_study_pop_10plus)
  
  # get the counts of respondents by age band in the standard population
  dt_cnt_age_band_standard_pop <- data_age_band %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_group_standard_pop = dplyr::n()) %>% 
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  dt_cnt_age_band_standard_pop_5plus <- data_age_band %>%
    dplyr::group_by(age_recoded_band_5plus) %>%
    dplyr::summarise(count_age_group_standard_pop_5plus = dplyr::n()) %>% 
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  dt_cnt_age_band_standard_pop_10plus <- data_age_band %>%
    dplyr::group_by(age_recoded_band_10plus) %>%
    dplyr::summarise(count_age_group_standard_pop_10plus = dplyr::n()) %>% 
    dplyr::ungroup() %>%
    tidyr::drop_na()
  
  
  dt_cnt_age_band_standard_pop_j <- bind_cols(dt_cnt_age_band_standard_pop, dt_cnt_age_band_standard_pop_5plus, dt_cnt_age_band_standard_pop_10plus)
  
  # join the dt_cnt_age_band_standard_pop to dt_study_pop_age_comorb
  
  study_pop_standard_pop <- dplyr::left_join(dt_study_pop, dt_cnt_age_band_standard_pop_j)
  
  # get the expected study population comorbidity
  
  dt_expected_study_pop_sympt <- study_pop_standard_pop %>%
    dplyr::mutate(expected_sympt_study_pop = count_age_group_standard_pop * study_sympt_rate, 
                  expected_sympt_study_pop_5plus = count_age_group_standard_pop_5plus * study_sympt_rate_5plus, 
                  expected_sympt_study_pop_10plus = count_age_group_standard_pop_10plus * study_sympt_rate_10plus) %>%
    tidyr::drop_na()
  
  
  
  final_adj_sympt_age_adj_rate <- dplyr::left_join(dt_expected_study_pop_sympt, study_pop_standard_pop)
  
  # get the total expected study pop comorb and total comorb age group in standard pop and the get total expected comorb in the study pop
  numbers_only <- final_adj_sympt_age_adj_rate %>%
    dplyr::ungroup() %>%
    dplyr::mutate(total_expected_study_pop_sympt = sum(expected_sympt_study_pop), 
                  total_expected_study_pop_sympt_5plus = sum(expected_sympt_study_pop_5plus), 
                  total_expected_study_pop_sympt_10plus = sum(expected_sympt_study_pop_10plus)) %>%
    dplyr::mutate(total_counts_stnd_pop = sum(count_age_group_standard_pop), 
                  total_counts_stnd_pop_5plus = sum(count_age_group_standard_pop_5plus), 
                  total_counts_stnd_pop_10plus = sum(count_age_group_standard_pop_10plus)) %>%
    dplyr::mutate(standardised_existing_sympt_rate = total_expected_study_pop_sympt/total_counts_stnd_pop *100, 
                  standardised_existing_sympt_rate_5plus = total_expected_study_pop_sympt/total_counts_stnd_pop_5plus *100, 
                  standardised_existing_sympt_rate_10plus = total_expected_study_pop_sympt/total_counts_stnd_pop_10plus *100)
  
  numbers_only
  
  
  
  
  if(table_gen == TRUE){ 
    
    dt_total_expected_standard_pop
    
  }else{
    
    numbers_only
    
  }
  
}









  
  
