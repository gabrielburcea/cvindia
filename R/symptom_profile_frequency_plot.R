#' symptom_profile_frequency_plot
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
symptom_profile_frequency_plot <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                            end_date = as.Date("2020-02-01", format = "%Y-%m-%d"),
                                            plot_chart = TRUE, title = "Testt") {
  
  
  positive_tested_symptoms <- data %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)
  
  count_chills <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, chills) %>%
    dplyr::rename(group = chills) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_chills = n()) %>%
    dplyr::mutate(Chills = Count_chills / sum(Count_chills) *100)
   
  
  
  count_cough <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, Cough) %>%
    dplyr::rename(group = Cough) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_cough = n()) %>%
    dplyr::mutate(Cough = Count_cough / sum(Count_cough)*100)
  
 
  
  count_diarrhoea <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, diarrhoea) %>%
    dplyr::rename(group = diarrhoea) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_diarrhoea = n()) %>%
    dplyr::mutate(Diarrhoea = Count_diarrhoea / sum(Count_diarrhoea)*100)
  
 
  
  count_fatigue <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, fatigue) %>%
    dplyr::rename(group = fatigue) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_fatigue = n()) %>%
    dplyr::mutate(Fatigue = Count_fatigue/sum(Count_fatigue)*100)
  
  
  
  count_headache <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, headache) %>%
    dplyr::rename(group = headache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_headache = n()) %>%
    dplyr::mutate(Headache = Count_headache / sum(Count_headache)*100)
  
  
  
  count_muscle_ache <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, muscle_ache) %>%
    dplyr::rename(group = muscle_ache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_muscle_ache = n()) %>%
    dplyr::mutate('Muscle Ache' = Count_muscle_ache / sum(Count_muscle_ache)*100)
  
  
  
  count_nasal_congestion <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nasal_congestion) %>%
    dplyr::rename(group = nasal_congestion) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nasal_congestion = n()) %>%
    dplyr::mutate('Nasal Congestion' = Count_nasal_congestion / sum(Count_nasal_congestion)*100)
  
  
  
  count_nause_vomiting <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nausea_vomiting) %>%
    dplyr::rename(group = nausea_vomiting) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nausea_vomiting = n()) %>%
    dplyr::mutate('Nausea and Vomiting' = Count_nausea_vomiting / sum(Count_nausea_vomiting)*100)
  
  
  
  count_self_diagnosis <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, self_diagnosis) %>%
    dplyr::rename(group = self_diagnosis) %>%
    dplyr::group_by(group) %>% 
    dplyr::summarise(Count_self_diagnosis = n()) %>%
    dplyr::mutate('Self Diagnosis' = Count_self_diagnosis / sum(Count_self_diagnosis)*100)
  
  
  
  count_shortness_breath <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, shortness_breath) %>%
    dplyr::rename(group = shortness_breath) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_shortness_breath = n()) %>%
    dplyr::mutate('Shortness of Breath' = Count_shortness_breath / sum(Count_shortness_breath)*100)
  
  
  
  
  count_sore_throat <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, sore_throat) %>%
    dplyr::rename(group = sore_throat) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sore_throat= n()) %>%
    dplyr::mutate('Sore Throat' = Count_sore_throat / sum(Count_sore_throat)*100)
  
  
  
  count_sputum <- positive_tested_symptoms  %>%
    dplyr::select(id, tested_positive, sputum ) %>%
    dplyr::rename(group = sputum) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sputum = n()) %>%
    dplyr::mutate('Sputum' = Count_sputum  / sum(Count_sputum)*100)
  
  
  
  
  count_temperature <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(group = temperature) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_temperature = n()) %>%
    dplyr::mutate('Temperature' = Count_temperature / sum(Count_temperature)*100)
  
  
  
  ch_cho <- dplyr::left_join(count_chills, count_cough,  by = c('group'))
  
  
  ch_cho_diar <- dplyr::left_join(ch_cho, count_diarrhoea,  by = c('group'))
  
  ch_cho_diar_fatig <- dplyr::left_join(ch_cho_diar, count_fatigue, by =c('group'))
  
  ch_cho_diar_fatig_head <- dplyr::left_join(ch_cho_diar_fatig, count_headache, by = c('group'))

  ch_cho_diar_fatig_head_ache <- dplyr::left_join(ch_cho_diar_fatig_head , count_muscle_ache, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong <- dplyr::left_join(ch_cho_diar_fatig_head_ache,  count_nasal_congestion,by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong, count_shortness_breath, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short, count_sore_throat, by = c('group'))
 
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore, 
                                                                         count_sputum, by = c('group'))

  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_sputum, 
                                                                                count_nause_vomiting, by = c('group'))
  
  
  symptom_numbers <- ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea

  
  melted_symptom_frequency <- symptom_numbers  %>%
    tidyr::gather(key = "Event",
                  value = "Value",
                  Chills, Cough, Diarrhoea, Fatigue, 
                  Headache, 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 
                  'Shortness of Breath', 'Sore Throat', Sputum) %>%
    dplyr::select(group, Event, Value)
  
 
  title_stub_freq <- ": Symptom maping in SARS-COVID-19 positive tested patients, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title, title_stub_freq, start_date_title, " to ", end_date_title)
  
  melted_symptom_frequency$group <- factor(melted_symptom_frequency$group)
  levels(melted_symptom_frequency$group)
  
  melted_symptom_frequency$group <- factor(melted_symptom_frequency$group, 
                                           levels = c("Mild", "Moderate", "Severe", "No"), 
                                           labels = c("Mild", "Moderate", "Severe", "No"))
    
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_frequency, ggplot2::aes(x = Event, Value, fill = group)) +
    ggplot2::geom_col(ggplot2::aes(colour = group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Blues') +
    ggplot2::scale_y_continuous(expand = c(0,0)) +
    ggplot2::labs(title = chart_title_2,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  x = "Symptoms manifestation in Covid Patients, tested positive", y = "Frequency", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.position = "bottom" , legend.box = "horizontal") +
    ggplot2::theme_bw()
   

  if(plot_chart == TRUE){
    
    plot_test
    
  }else{
    
    symptom_numbers <- symptom_numbers %>%
      dplyr::select_all()
    
  }
   
}




#' symptom_profile_count_plot
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
symptom_profile_count_plot <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                           end_date = as.Date("2020-02-01", format = "%Y-%m-%d"),
                                           plot_chart = TRUE, title = "Test") {
  
  
  positive_tested_symptoms <- data %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)

  
  count_chills_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, chills) %>%
    dplyr::rename(group = chills) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Chills = n())
  
  
  count_cough_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, Cough) %>%
    dplyr::rename(group = Cough) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Cough = n()) 
  
  
  count_diarrhoea_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, diarrhoea) %>%
    dplyr::rename(group = diarrhoea) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Diarrhoea = n())
  
  
  count_fatigue_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, fatigue) %>%
    dplyr::rename(group = fatigue) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Fatigue = n())
  
  
  count_headache_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, headache) %>%
    dplyr::rename(group = headache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Headache = n()) 

  
  count_muscle_ache_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, muscle_ache) %>%
    dplyr::rename(group = muscle_ache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Muscle Ache' = n())
  
  
  count_nasal_congestion_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nasal_congestion) %>%
    dplyr::rename(group = nasal_congestion) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Nasal Congestion' = n()) 
  
  count_nause_vomiting_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, nausea_vomiting) %>%
    dplyr::rename(group = nausea_vomiting) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Nausea and Vomiting' = n()) 
  

  
  count_self_diagnosis_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, self_diagnosis) %>%
    dplyr::rename(group = self_diagnosis) %>%
    dplyr::group_by(group) %>% 
    dplyr::summarise('Self diagnosis' = n()) 
  
  
  count_shortness_breath_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, shortness_breath) %>%
    dplyr::rename(group = shortness_breath) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Shortness of Breath'  = n()) 

  
  count_sore_throat_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, sore_throat) %>%
    dplyr::rename(group = sore_throat) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Sore Throat'= n())
  
  
  count_sputum_n <- positive_tested_symptoms  %>%
    dplyr::select(id, tested_positive, sputum ) %>%
    dplyr::rename(group = sputum) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Sputum' = n())

  
  
  count_temperature_n <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(group = temperature) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise('Temperature'  = n()) 
  
  
  ch_cho_n <- dplyr::left_join(count_chills_n, count_cough_n,  by = c('group'))
  
  ch_cho_diar_n <- dplyr::left_join(ch_cho_n, count_diarrhoea_n,  by = c('group'))
  
  ch_cho_diar_fatig_n <- dplyr::left_join(ch_cho_diar_n, count_fatigue_n, by =c('group'))
  
  ch_cho_diar_fatig_head_n <- dplyr::left_join(ch_cho_diar_fatig_n, count_headache_n, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_n <- dplyr::left_join(ch_cho_diar_fatig_head_n, count_muscle_ache_n, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_n,  count_nasal_congestion_n,by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_n, count_shortness_breath_n, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_n, count_sore_throat_n, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_n, 
                                                                         count_sputum_n, by = c('group'))
  
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_n, 
                                                                                count_nause_vomiting_n, by = c('group'))
  
  
  symptom_numbers_n <- ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_n
  
  melted_symptom_counts <- symptom_numbers_n  %>%
    tidyr::gather(key = "Event",
                  value = "Value",
                  Chills, Cough,Diarrhoea, Fatigue, 
                  Headache, 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 
                  'Shortness of Breath', 'Sore Throat', Sputum) %>%
    dplyr::select(group, Event, Value)
  

  title_stub_count <- ": Symptom maping in SARS-COVID-19 positive tested patients,Count\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_count <- paste0(title, title_stub_count, start_date_title, " to ", end_date_title)
  
  melted_symptom_counts$group <- factor(melted_symptom_counts$group)
  levels(melted_symptom_counts$group)
  
  melted_symptom_counts$group <- factor(melted_symptom_counts$group, 
                                           levels = c("Mild", "Moderate", "Severe", "No"), 
                                           labels = c("Mild", "Moderate", "Severe", "No"))
  
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_counts, ggplot2::aes(x = reorder(Event, -Value), Value, fill = group)) +
    ggplot2::geom_col(ggplot2::aes(colour = group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Blues') +
    ggplot2::scale_y_continuous(expand = c(0,0)) +
    ggplot2::labs(title = chart_title_count,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  y  = "Counts" , x = "Symptoms manifestation in Covid Patients tested positive", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.position = "bottom" , legend.box = "horizontal") +
    ggplot2::theme_bw()
  
  plot_test
}

