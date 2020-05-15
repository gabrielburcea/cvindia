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
  
  
  self_diagnosis_dt<- data %>% 
    dplyr::filter(self_diagnosis == 'Severe')
  
  
  count_chills <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, chills) %>%
    dplyr::rename(Group = chills) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_chills = dplyr::n()) %>%
    dplyr::mutate(Chills = Count_chills / sum(Count_chills) *100)
  
  count_cough <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, Cough) %>%
    dplyr::rename(Group = Cough) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_cough = dplyr::n()) %>%
    dplyr::mutate(Cough = Count_cough / sum(Count_cough)*100)
  
  
  count_loss_smell_taste <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, loss_smell_taste) %>%
    dplyr::rename(Group = loss_smell_taste) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_loss_smell_taste = dplyr::n()) %>%
    dplyr::mutate('Loss Smell Taste' = Count_loss_smell_taste / sum(Count_loss_smell_taste)*100)
  
  
  count_diarrhoea <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, diarrhoea) %>%
    dplyr::rename(Group = diarrhoea) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_diarrhoea = dplyr::n()) %>%
    dplyr::mutate(Diarrhoea = Count_diarrhoea / sum(Count_diarrhoea)*100)
  
  count_fatigue <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, fatigue) %>%
    dplyr::rename(Group = fatigue) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_fatigue = dplyr::n()) %>%
    dplyr::mutate(Fatigue = Count_fatigue/sum(Count_fatigue)*100)
  
  
  count_headache <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, headache) %>%
    dplyr::rename(Group = headache) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_headache = dplyr::n()) %>%
    dplyr::mutate(Headache = Count_headache / sum(Count_headache)*100)
  
  
  count_muscle_ache <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, muscle_ache) %>%
    dplyr::rename(Group = muscle_ache) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_muscle_ache = dplyr::n()) %>%
    dplyr::mutate('Muscle Ache' = Count_muscle_ache / sum(Count_muscle_ache)*100)
  
  
  count_nasal_congestion <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, nasal_congestion) %>%
    dplyr::rename(Group = nasal_congestion) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_nasal_congestion = dplyr::n()) %>%
    dplyr::mutate('Nasal Congestion' = Count_nasal_congestion / sum(Count_nasal_congestion)*100)
  
  
  count_nausea_vomiting <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, nausea_vomiting) %>%
    dplyr::rename(Group = nausea_vomiting) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_nausea_vomiting = dplyr::n()) %>%
    dplyr::mutate('Nausea and Vomiting' = Count_nausea_vomiting / sum(Count_nausea_vomiting)*100)
  
  count_self_diagnosis <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, self_diagnosis) %>%
    dplyr::rename(Group = self_diagnosis) %>%
    dplyr::group_by(Group) %>% 
    dplyr::summarise(Count_self_diagnosis = dplyr::n()) %>%
    dplyr::mutate('Self Diagnosis' = Count_self_diagnosis / sum(Count_self_diagnosis)*100)
  
  
  
  count_shortness_breath <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, shortness_breath) %>%
    dplyr::rename(Group = shortness_breath) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_shortness_breath = dplyr::n()) %>%
    dplyr::mutate('Shortness of Breath' = Count_shortness_breath / sum(Count_shortness_breath)*100)
  
  
  count_sore_throat <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, sore_throat) %>%
    dplyr::rename(Group = sore_throat) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_sore_throat= dplyr::n()) %>%
    dplyr::mutate('Sore Throat' = Count_sore_throat / sum(Count_sore_throat)*100)
  
  
  count_sputum <- self_diagnosis_dt  %>%
    dplyr::select(id, self_diagnosis, sputum ) %>%
    dplyr::rename(Group = sputum) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_sputum = dplyr::n()) %>%
    dplyr::mutate('Sputum' = Count_sputum  / sum(Count_sputum)*100)
  
  
  count_temperature <- self_diagnosis_dt %>%
    dplyr::select(id, self_diagnosis, temperature) %>%
    dplyr::rename(Group = temperature) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_temperature = dplyr::n()) %>%
    dplyr::mutate('Temperature' = Count_temperature / sum(Count_temperature)*100)
  
  
  
  ch_cho <- dplyr::left_join(count_chills, count_cough,  by = c('Group'))
  
  ch_cho_diar <- dplyr::left_join(ch_cho, count_diarrhoea,  by = c('Group'))
  
  ch_cho_diar_fatig <- dplyr::left_join(ch_cho_diar, count_fatigue, by =c('Group'))
  
  ch_cho_diar_fatig_head <- dplyr::left_join(ch_cho_diar_fatig, count_headache, by = c('Group'))
  
  ch_cho_diar_fatig_head_ache <- dplyr::left_join(ch_cho_diar_fatig_head , count_muscle_ache, by = c('Group'))
  
  ch_cho_diar_fatig_head_ache_cong <- dplyr::left_join(ch_cho_diar_fatig_head_ache,  count_nasal_congestion,by = c('Group'))
  
  ch_cho_diar_fatig_head_ache_cong_short <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong, count_shortness_breath, by = c('Group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short, count_sore_throat, by = c('Group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore, 
                                                                         count_sputum, by = c('Group'))
  
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_sputum, 
                                                                                count_nausea_vomiting, by = c('Group'))
  
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_loss_smell <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea, 
                                                                                           count_loss_smell_taste, by = c('Group'))
  
  symptom_numbers <- ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_loss_smell  %>%
    dplyr::filter(Group != 'No')
  
  
  melted_symptom_frequency <- symptom_numbers  %>%
    tidyr::gather(key = "Event",
                  value = "Frequency",
                  Chills,'Sore Throat', 'Loss Smell Taste', Sputum, Diarrhoea, Fatigue, 
                  Headache, 'Nasal Congestion', 'Nausea and Vomiting', 
                  'Shortness of Breath', Cough, 'Muscle Ache') %>%
    dplyr::select(Group, Event, Frequency) %>%
    dplyr::arrange(desc(Frequency))
  melted_symptom_frequency
  
  
  melted_symptom_count <- symptom_numbers %>%
    dplyr::select(Group, Count_chills,Count_cough,Count_diarrhoea,
                  Count_fatigue, Count_headache, Count_muscle_ache, 
                  Count_nasal_congestion, Count_nausea_vomiting, 
                  Count_shortness_breath, Count_sore_throat, 
                  Count_sputum, Count_loss_smell_taste) %>%
    dplyr::rename(Chills = Count_chills, Cough = Count_cough, Diarrhoea = Count_diarrhoea,
                  Fatigue = Count_fatigue, Headache = Count_headache, 'Muscle Ache' = Count_muscle_ache, 
                  'Nasal Congestion' = Count_nasal_congestion, 'Nausea and Vomiting' = Count_nausea_vomiting, 
                  'Shortness of Breath' = Count_shortness_breath, 'Sore Throat' = Count_sore_throat, 
                  Sputum = Count_sputum, 'Loss Smell Taste' = Count_loss_smell_taste)
  
  melted_symp_count <- melted_symptom_count %>%
    tidyr::gather(key = "Event",
                  value = "Count", 
                  Chills,'Sore Throat', 'Loss Smell Taste', Sputum, Diarrhoea, Fatigue, 
                  Headache, 'Nasal Congestion', 'Nausea and Vomiting', 
                  'Shortness of Breath', Cough, 'Muscle Ache') %>%
    dplyr::select(Group, Event, Count) %>%
    dplyr::arrange(desc(Count))
  melted_symp_count
  
  number_joined <- dplyr::left_join(melted_symp_count, melted_symptom_frequency,by = c('Event', 'Group'))
  
  
  title_stub_freq <- "Moderate manifestation of Covid mapped to different symptoms, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  number_joined$Group <- factor(number_joined$Group)
  levels(number_joined$Group)
  
  number_joined$Group <- factor(number_joined$Group, 
                                levels = c("Mild", "Moderate", "Severe"), 
                                labels = c("Mild", "Moderate", "Severe"))
  
  
  
  plot_test <- ggplot2::ggplot(number_joined, ggplot2::aes(x = Event, Frequency, fill = Group)) +
    ggplot2::geom_col(ggplot2::aes(colour = Group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Reds') +
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
    
    number_joined <- number_joined %>%
      dplyr::select(Group, Event, Count, Frequency)
    number_joined
    
    
    
  }
  
}