#' system_profile_test
#'
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#' @param title 
#'
#' @return
#' @export
#'
#' @examples
symptom_profile_test <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                            end_date = as.Date("2020-02-01", format = "%Y-%m-%d"),
                                            plot_chart = TRUE, title = "Testt") {
  
  
  
  positive_tested_symptoms <- data_select %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)
  
  count_chills <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, chills) %>%
    dplyr::rename(group = chills) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_chills = n()) %>%
    dplyr::mutate(Frequency_chills = Count_chills / sum(Count_chills)) %>%
    dplyr::filter(group != 'No')
   
  count_cough <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, Cough) %>%
    dplyr::rename(group = Cough) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_cough = n()) %>%
    dplyr::mutate(Frequency_cough = Count_cough / sum(Count_cough)) %>%
    dplyr::filter(group != 'No')
  
  count_diarrhoea <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, diarrhoea) %>%
    dplyr::rename(group = diarrhoea) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_diarrhoea = n()) %>%
    dplyr::mutate(Frequency_diarrhoea = Count_diarrhoea / sum(Count_diarrhoea)) %>%
    dplyr::filter(group != 'No')
  
  count_fatigue <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, fatigue) %>%
    dplyr::rename(group = fatigue) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_fatigue = n()) %>%
    dplyr::mutate(Frequency_fatigue = Count_fatigue/sum(Count_fatigue)) %>%
    dplyr::filter(group != 'No')
  
  count_headache <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, headache) %>%
    dplyr::rename(group = headache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_headache = n()) %>%
    dplyr::mutate(Frequency_headache = Count_headache / sum(Count_headache)) %>%
    dplyr::filter(group != 'No')
  
  count_muscle_ache <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, muscle_ache) %>%
    dplyr::rename(group = muscle_ache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_muscle_ache = n()) %>%
    dplyr::mutate(Frequency_muscle_ache = Count_muscle_ache / sum(Count_muscle_ache)) %>%
    dplyr::filter(group != 'No')
  
  
  count_nasal_congestion <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nasal_congestion) %>%
    dplyr::rename(group = nasal_congestion) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nasal_congestion = n()) %>%
    dplyr::mutate(Frequency_nasal_congestion = Count_nasal_congestion / sum(Count_nasal_congestion)) %>%
    dplyr::filter(group != 'No')
  
  count_nause_vomiting <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nausea_vomiting) %>%
    dplyr::rename(group = nausea_vomiting) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nausea_vomiting = n()) %>%
    dplyr::mutate(Frequency_nausea = Count_nausea_vomiting / sum(Count_nausea_vomiting)) %>%
    dplyr::filter(group != 'No')
  
  
  count_self_diagnosis <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, self_diagnosis) %>%
    dplyr::rename(group = self_diagnosis) %>%
    dplyr::group_by(group) %>% 
    dplyr::summarise(Count_self_diagnosis = n()) %>%
    dplyr::mutate(Frequency_self_diagnosis = Count_self_diagnosis / sum(Count_self_diagnosis)) %>%
    dplyr::filter(group != 'No')
  
  
  count_shortness_breath <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, shortness_breath) %>%
    dplyr::rename(group = shortness_breath) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_shortness_breath = n()) %>%
    dplyr::mutate(Frequency_shortness_breath= Count_shortness_breath / sum(Count_shortness_breath)) %>%
    dplyr::filter(group != 'No')
  
  count_sore_throat <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, sore_throat) %>%
    dplyr::rename(group = sore_throat) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sore_throat= n()) %>%
    dplyr::mutate(Frequency_sore_throat = Count_sore_throat / sum(Count_sore_throat)) %>%
    dplyr::filter(group != 'No')
  
  count_sputum <- positive_tested_symptoms  %>%
    dplyr::select(id, tested_positive, sputum ) %>%
    dplyr::rename(group = sputum) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sputum = n()) %>%
    dplyr::mutate(Frequency_sputum = Count_sputum  / sum(Count_sputum)) %>%
    dplyr::filter(group != 'No')
  
  count_temperature <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(group = temperature) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_temperature = n()) %>%
    dplyr::mutate(Frequency_temperature = Count_temperature / sum(Count_temperature)) %>%
    dplyr::filter(group != 'No')
  
  ch_cho_diar <- dplyr::left_join(count_chills, count_cough, count_diarrhoea, by = c('group'))
  
  
  ch_cho_diar_fat_head <- dplyr::left_join(ch_cho_diar, count_fatigue, count_headache,  by = c('group'))
  
  
  ch_cho_diar_fat_head_musc_nause_nasal <- dplyr::left_join(ch_cho_diar_fat_head, count_muscle_ache,count_nasal_congestion,  by = c('group'))
  
  ch_cho_diar_fat_head_musc_nause_nasal_shorth_sore <- dplyr::left_join(ch_cho_diar_fat_head_musc_nause_nasal, count_shortness_breath, 
                                                                               count_sore_throat, by = c('group'))
  
  ch_cho_diar_fat_head_musc_nause_nasal_shorth_sore_sputum <- dplyr::left_join(ch_cho_diar_fat_head_musc_nause_nasal_shorth_sore, 
                                                                               count_sputum, by = c('group'))
  
  
  symptom_numbers <- ch_cho_diar_fat_head_musc_nause_nasal_shorth_sore_sputum
  
  symptom_numbers$group <- factor(symptom_numbers$group)
  levels(symptom_numbers$group)
  
  symptom_numbers$group <- factor(symptom_numbers$group, 
                                  levels = c("Mild", "Moderate", "Severe"))

  

  
}
