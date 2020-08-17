#' symptom_profile_showing_symptom
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
symptom_profile_showing_symptom <- function(data, start_date = as.Date("2020-04-09", format = "%Y-%m-%d"), 
                                           end_date = as.Date("2020-05-09", format = "%Y-%m-%d"),
                                           plot_chart = TRUE) {
  
  
  positive_tested_symptoms <- data %>% 
    dplyr::select(id, covid_tested, shortness_breath, muscle_ache, cough, loss_smell_taste, chills, diarrhoea, fatigue, headache, nasal_congestion, 
                  nausea_vomiting,sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain) %>%
    dplyr::filter(covid_tested == "showing symptoms")
  
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
  
  start_date = as.Date("2020-04-09", format = "%Y-%m-%d")
  end_date = as.Date("2020-05-09", format = "%Y-%m-%d")
  
  title_stub_freq <- "Respondents showing SARS-COVID-19 symptoms, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  plot_test <- ggplot2::ggplot(data_level_positive, ggplot2::aes(x = reorder(Symptom, -Percentage), y = Percentage, fill = Percentage)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::scale_x_discrete(limits = unique(data_level_positive$Symptom)) +
    ggplot2::scale_fill_viridis_c() + 
    ggplot2::theme_minimal() +
    ggplot2::labs( title = chart_title_2,
                   subtitle = "Covid-19 Symptoms in patients declaring showing symptoms",
                   y = "Frequency",
                   x = "Covid-19 Symptoms",
                   caption = "Source: Dataset - Your.md Dataset\nNote: i) excludes respondents tested positive; ii) results are intended for management information only") +
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
