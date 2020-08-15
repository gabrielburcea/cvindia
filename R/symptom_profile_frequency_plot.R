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
symptom_profile_frequency_plot <- function(data, start_date = as.Date("2020-04-09", format = "%Y-%m-%d"), 
                                            end_date = as.Date("2020-05-09", format = "%Y-%m-%d"),
                                            plot_chart = TRUE) {
  
  

  
  positive_tested_symptoms <- data %>% 
    dplyr::select(id, covid_tested, shortness_breath, muscle_ache, cough, loss_smell_taste, chills, diarrhoea, fatigue, headache, nasal_congestion, 
                  nausea_vomiting,sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain) %>%
    dplyr::filter(covid_tested == "positive")
  
  data_piv <- positive_tested_symptoms %>% 
    tidyr::pivot_longer(cols=3:18, names_to="Symptom", values_to="Event") %>%
    dplyr::group_by(Symptom, Event) %>%
    dplyr::summarise(Count=n()) %>%
    dplyr::mutate(Percentage=Count/sum(Count) *100)
  
  symptom_levels <- c('Shorthness of breath' = "shortness_breath", 
                      'Muscle ache' = "muscle_ache", 
                      "Cough" = "cough", 
                      "Loss of smell and taste" = "loss_smell_taste", 
                      "Chills" = "chills", 
                      "Diarrhoea" = "diarrhoea", 
                      "Fatigue" = "fatigue", 
                      "Headache" = "headache", 
                      "Nasal congestion" = "nasal_congestion", 
                      "Nausea and vomiting" = "nausea_vomiting", 
                      "Sore throat" = "sore_throat", 
                      "Sputum" = "sputum", 
                      "Temperature" = "temperature", 
                      "Loss of appetite" = "loss_appetite", 
                      "Sneezing" = "sneezing", 
                      "Chest pain" = "chest_pain", 
                      "Itchy eyes" = "itchy_eyes", 
                      "Joint pain" = "joint_pain")
  
  
  data_levels <- data_piv %>% 
    dplyr::mutate(Symptom = forcats::fct_recode(Symptom, !!!symptom_levels))  %>%
    dplyr::arrange(desc(Count))
  
  data_level_positive <- data_levels %>%
    dplyr::filter(Event == "Yes")
  
  title_stub_freq <- "SARS-COVID-19 positive tested patients, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  plot_test <- ggplot2::ggplot(data_level_positive, ggplot2::aes(x = reorder(Symptom, -Percentage), y = Percentage, fill = Percentage)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    #ggplot2::scale_fill_brewer(palette = 'Reds') + 
    ggplot2::scale_fill_viridis_c(option = "magma", direction = -1) +
    ggplot2::scale_x_discrete(limits = unique(data_level_positive$Symptom)) +
    #ggplot2::theme(legend.position = "bottom") +
    #ggplot2::guides(fill = ggplot2::guide_legend(nrow = 3)) +
    ggplot2::theme_minimal() +
    ggplot2::labs( title = chart_title_2,
                   subtitle = "Covid-19 Symptoms in patients tested positive",
                   y = "Frequency",
                   x = "Covid-19 Symptoms",
                   caption = "Source: Dataset - Your.md Dataset") +
    ggplot2::theme(
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(
        t = 0,
        r = 21,
        b = 0,
        l = 0
      )),
      plot.title = ggplot2::element_text(size = 10, face = "bold"),
      plot.subtitle = ggplot2::element_text(size = 9),
      axis.text.x = ggplot2::element_text(angle = 55, hjust = 1)
    )
  
  
  if(plot_chart == TRUE){
    
    plot_test
    
  }else{
    
    data_levels
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
  
  ch_cho_diar_fatig_head_ache_n <- dplyr::left_join(ch_cho_diar_fatig_head_n,  by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_n,  count_nasal_congestion_n,by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_n,  by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_n, count_sore_throat_n, by = c('group'))
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_n, 
                                                                         count_sputum_n, by = c('group'))
  
  
  ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_n <- dplyr::left_join(ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_n, 
                                                                                count_nause_vomiting_n, by = c('group'))

  
  symptom_numbers_n <- ch_cho_diar_fatig_head_ache_cong_short_sore_sputum_nausea_n %>%
    dplyr::filter(group != "No")
  
  melted_symptom_counts <- symptom_numbers_n  %>%
    tidyr::gather(key = "Event",
                  value = "Value",
                  Cough,'Shortness of Breath', 'Muscle Ache', Diarrhoea, Fatigue, 
                  Headache,  'Nasal Congestion', 'Nausea and Vomiting', 
                   'Sore Throat', Sputum, Chills) %>%
    dplyr::select(group, Event, Value)
  

  title_stub_count <- ": Symptom maping in SARS-COVID-19 positive tested patients,Count\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_count <- paste0(title, title_stub_count, start_date_title, " to ", end_date_title)
  
  melted_symptom_counts$group <- factor(melted_symptom_counts$group)
  levels(melted_symptom_counts$group)
  
  melted_symptom_counts$group <- factor(melted_symptom_counts$group, 
                                           levels = c("Mild", "Moderate", "Severe"), 
                                           labels = c("Mild", "Moderate", "Severe"))
  
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_counts, ggplot2::aes(x = reorder(Event, -Value), Value, fill = group)) +
    ggplot2::geom_col(ggplot2::aes(colour = group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Blues') +
    #ggplot2::scale_y_continuous(expand = c(0,0)) +
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

