#' adjusr_age_comorbidity'
#'
#' @param data - contains id, pre-existing conditions, countries
#' @param comorb - preexisting conditions such as : asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease; 
#' all pre-existing condition to be passed exactly as written
#' @param country_select country which selected. for top 5 countries which has the highest number of responders
#' @param table if this TRUE then it will give a long table with all the standard population and study population across age groups. It gives the adjusted comorbidity rate as well in the last column
#'
#' @return
#' @export
#'
#' @examples
adjust_age_comorbidity <- function(data, comorb, country_select, table = TRUE){
  
  data_select <- data %>%
    dplyr::select(id, age, Country, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition, 
                  liver_disease, kidney_disease) %>%
    dplyr::mutate(age_recoded = replace(age, age > 100, NA_real_)) %>%
    dplyr::rename(country = Country)
  
  #get the age bands
  data_age_band <- data_select %>%
    dplyr::mutate(age_recoded_band = dplyr::case_when(
      age_recoded == 0 | age_recoded <= 19 ~ '0-19',
      age_recoded == 20 | age_recoded <= 39 ~ '20-39',
      age_recoded == 40 | age_recoded <= 59 ~ '40-59',
      age_recoded >= 60 ~ "60+"))
  
  world_wide_pop <- readr::read_csv("/Users/gabrielburcea/rprojects/cvindia/data/world_wide_pop_2020.csv")
  
  # get the counts of respondents by age band in the study population
  dt_cnt_age_band_resp <- data_age_band %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(standard_population_age_band = dplyr::n()) %>% drop_na()
  
  age_band_comorbidities_pv <- data_age_band %>%
    tidyr::pivot_longer(cols = 4:12, 
                        names_to = "comorbidities", 
                        values_to = "Bolean") %>%
    dplyr::filter(Bolean != "No")
  

  
  # use the study population to get the asthma counts -> this will help get my standard pop
  all_age_struct_comorb <- age_band_comorbidities_pv %>%
    dplyr::select(age_recoded_band, comorbidities) %>%
    dplyr::filter(comorbidities == comorb) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(standard_pop_comorb = dplyr::n()) %>%
    tidyr::drop_na()
  
  # 1. get the standard population - dividing the counts per age groups by comorbidities count 
  # 2. first merge the dt_cnt_age_band_resp and all_age_struct_comorb 
  # then get the division at step 1
  
  dt_standard_pop <- dplyr::left_join(dt_cnt_age_band_resp, all_age_struct_comorb) %>% tidyr::drop_na()
  
  fnl_stand_pop <- dt_standard_pop %>%
    dplyr::mutate(standard_pop_rate = standard_pop_comorb/standard_population_age_band)
  
  # get the age group per country -> add them to the fnl_stand_pop 
  country_data <- age_band_comorbidities_pv  %>%
    dplyr::select(id, age_recoded_band, country) %>%
    dplyr::filter(country == country_select) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(count_age_group_study_pop = dplyr::n()) %>%
    tidyr::drop_na()
  
  country_fnl_stand_pop <- dplyr::left_join(fnl_stand_pop, country_data) 
  
  # get the expected study pop asthma per age group 
  
  country_expct_comorbidity <- country_fnl_stand_pop %>%
    dplyr::mutate(expected_comorb_study_pop = standard_pop_rate * count_age_group_study_pop)
  
  # get the total number of country responders having a certain comorbidity
  
  # find a certain comorbidity in a study pop across age group 
  study_pop_rate <- age_band_comorbidities_pv %>%
    dplyr::select(id, age_recoded_band, country, comorbidities) %>%
    dplyr::filter(country == country_select & comorbidities == comorb) %>%
    dplyr::group_by(age_recoded_band) %>%
    dplyr::summarise(comorb_age_group_study_pop = dplyr::n()) %>%
    tidyr::drop_na() 
  
  
  # attach pop rate (country/comorbidity) to country_expected_comorbidity
  final_adj_comorbid_rate <- dplyr::left_join(country_expct_comorbidity, study_pop_rate) %>% drop_na()
  
  # get the standardised comorbidity rate
  # get the total number number of a comorbidity across age group in a certain country 
  # get the sum of expected comorbidity in study group 
  # left join the figures together into a tibble and then divide the total number of comorbidity across age group in a certain country / sum of expected comorbidity in study group
  
  
  dt_total_sum_comorbidit_study_pop <- final_adj_comorbid_rate %>%
    mutate(total_comorb_study_pop = sum(comorb_age_group_study_pop)) %>%
    mutate(total_expected_study_pop_comorb = sum(expected_comorb_study_pop)) %>%
    mutate(standardised_existing_cond_rate = total_comorb_study_pop/total_expected_study_pop_comorb) 
  
  
  dt_select_final <-round(dt_total_sum_comorbidit_study_pop[1, 10], digits = 2)
  
  dt_select_final
  
  title <- "Standardised"
  add_to_title <- comorb
  add_last_word <- " rate in"
  country = country_select
 
  whole_title <- paste(title, add_to_title, add_last_word, country)
  
  whole_title

  
  
  if(table == TRUE){ 
    
    dt_total_sum_comorbidit_study_pop %>% rename(!!whole_title := standardised_existing_cond_rate)
    
  }else{
      
    dt_select_final %>% rename(!!whole_title := standardised_existing_cond_rate)
    
    }
  

}




