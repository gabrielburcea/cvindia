#' severe_manifestation_plot
#'
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#'
#' @return
#' @export
#'
#' @examples
severe_manifestation_plot <- function(data, start_date = as.Date("2020-04-09", format = "%Y-%m-%d"), 
                                 end_date = as.Date("2020-05-09", format = "%Y-%m-%d"),
                                 plot_chart = TRUE) {
  
  
  self_diagnosis_dt<- data_select %>% 
    dplyr::filter(self_diagnosis == 'Severe')
  
  count_chills <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, chills) %>%
    dplyr::rename(group = chills) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_chills = dplyr::n()) %>%
    dplyr::mutate(Chills = Count_chills / sum(Count_chills) *100)
  
  count_cough <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, Cough) %>%
    dplyr::rename(group = Cough) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_cough = dplyr::n()) %>%
    dplyr::mutate(Cough = Count_cough / sum(Count_cough)*100)
  
  
  count_diarrhoea <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, diarrhoea) %>%
    dplyr::rename(group = diarrhoea) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_diarrhoea = dplyr::n()) %>%
    dplyr::mutate(Diarrhoea = Count_diarrhoea / sum(Count_diarrhoea)*100)
  
  count_fatigue <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, fatigue) %>%
    dplyr::rename(group = fatigue) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_fatigue = dplyr::n()) %>%
    dplyr::mutate(Fatigue = Count_fatigue/sum(Count_fatigue)*100)
  
  
  count_headache <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, headache) %>%
    dplyr::rename(group = headache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_headache = dplyr::n()) %>%
    dplyr::mutate(Headache = Count_headache / sum(Count_headache)*100)
  
  
  count_muscle_ache <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, muscle_ache) %>%
    dplyr::rename(group = muscle_ache) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_muscle_ache = dplyr::n()) %>%
    dplyr::mutate('Muscle Ache' = Count_muscle_ache / sum(Count_muscle_ache)*100)
  
  
  count_nasal_congestion <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, nasal_congestion) %>%
    dplyr::rename(group = nasal_congestion) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nasal_congestion = dplyr::n()) %>%
    dplyr::mutate('Nasal Congestion' = Count_nasal_congestion / sum(Count_nasal_congestion)*100)
  
  
  count_nause_vomiting <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, nausea_vomiting) %>%
    dplyr::rename(group = nausea_vomiting) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_nausea_vomiting = dplyr::n()) %>%
    dplyr::mutate('Nausea and Vomiting' = Count_nausea_vomiting / sum(Count_nausea_vomiting)*100)
  
  count_self_diagnosis <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, self_diagnosis) %>%
    dplyr::rename(group = self_diagnosis) %>%
    dplyr::group_by(group) %>% 
    dplyr::summarise(Count_self_diagnosis = dplyr::n()) %>%
    dplyr::mutate('Self Diagnosis' = Count_self_diagnosis / sum(Count_self_diagnosis)*100)
  
  
  
  count_shortness_breath <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, shortness_breath) %>%
    dplyr::rename(group = shortness_breath) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_shortness_breath = dplyr::n()) %>%
    dplyr::mutate('Shortness of Breath' = Count_shortness_breath / sum(Count_shortness_breath)*100)
  
  
  count_sore_throat <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, sore_throat) %>%
    dplyr::rename(group = sore_throat) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sore_throat= dplyr::n()) %>%
    dplyr::mutate('Sore Throat' = Count_sore_throat / sum(Count_sore_throat)*100)
  
  
  
  count_sputum <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, sputum ) %>%
    dplyr::rename(group = sputum) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_sputum = dplyr::n()) %>%
    dplyr::mutate('Sputum' = Count_sputum  / sum(Count_sputum)*100)
  
  
  
  count_temperature <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, temperature) %>%
    dplyr::rename(group = temperature) %>%
    dplyr::group_by(group) %>%
    dplyr::summarise(Count_temperature = dplyr::n()) %>%
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
  
  
  symptom_numbers <- ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea %>%
    dplyr::filter(group != 'No')
  
  
  melted_symptom_frequency <- symptom_numbers  %>%
    tidyr::gather(key = "Event",
                  value = "Value",
                  Chills,'Sore Throat', Sputum, Diarrhoea, Fatigue, 
                  Headache, 'Nasal Congestion', 'Nausea and Vomiting', 
                  'Shortness of Breath',Cough,'Muscle Ache') %>%
    dplyr::select(group, Event, Value)
  
  
  title_stub_freq <- "Severe manifestation of Sars-Covid-19 mapped to different symptoms, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  melted_symptom_frequency$group <- factor(melted_symptom_frequency$group)
  levels(melted_symptom_frequency$group)
  
  melted_symptom_frequency$group <- factor(melted_symptom_frequency$group, 
                                           levels = c("Mild", "Moderate", "Severe"), 
                                           labels = c("Mild", "Moderate", "Severe"))
  
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_frequency, ggplot2::aes(x = Event, Value, fill = group)) +
    ggplot2::geom_col(ggplot2::aes(colour = group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'YlOrRd') +
    #ggplot2::scale_y_continuous(expand = c(0,0)) +
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
    
    melted_symptom_frequency <- symptom_numbers  %>%
      tidyr::gather(key = "Event",
                    value = "Value",
                    Chills,'Sore Throat', Sputum, Diarrhoea, Fatigue, 
                    Headache, 'Nasal Congestion', 'Nausea and Vomiting', 
                    'Shortness of Breath',Cough,'Muscle Ache') %>%
      dplyr::select(group, Event, Value) %>%
      dplyr::arrange(desc(Value)) %>%
      dplyr::rename(Frequency = Value) %>%
      dplyr::top_n(15)
    melted_symptom_frequency
    
    symptom_numbers <- symptom_numbers %>%
      tidyr::gather(key = "Event",
                    value = "Value", 
                    Count_chills, Count_cough, Count_diarrhoea,
                    Count_fatigue, Count_headache, Count_muscle_ache, Count_nasal_congestion, 
                    Count_nausea_vomiting, Count_shortness_breath, Count_sore_throat, Count_sore_throat, 
                    Count_sputum) %>%
      dplyr::select(group, Event, Value) %>%
      dplyr::arrange(desc(Value)) %>%
      dplyr::rename(Count = Value) %>%
      dplyr::top_n(15)
    symptom_numbers
    
  }
  
}