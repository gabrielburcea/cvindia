#' symptom_profile_covid_tested
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
symptom_profile_covid_tested <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                           end_date = as.Date("2020-02-01", format = "%Y-%m-%d"),
                                           plot_chart = TRUE) {
  
  
  positive_tested_symptoms <- data %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)
  
  count_cough <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, Cough) %>%
    dplyr::rename(Group = Cough) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_cough = dplyr::n()) %>%
    dplyr::mutate(Cough = Count_cough / sum(Count_cough)*100) %>%
    dplyr::filter(Group != 'No')
  
  count_muscle_ache <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, muscle_ache) %>%
    dplyr::rename(Group = muscle_ache) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_muscle_ache = dplyr::n()) %>%
    dplyr::mutate('Muscle Ache' = Count_muscle_ache / sum(Count_muscle_ache)*100) %>%
    dplyr::filter(Group != 'No')
  

  count_shortness_breath <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, shortness_breath) %>%
    dplyr::rename(Group = shortness_breath) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_shortness_breath = dplyr::n()) %>%
    dplyr::mutate('Shortness of Breath' = Count_shortness_breath / sum(Count_shortness_breath)*100) %>%
    dplyr::filter(Group != 'No')
  

  
  count_temperature <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(Group = temperature) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_temperature = dplyr::n()) %>%
    dplyr::mutate('Temperature' = Count_temperature / sum(Count_temperature)*100) %>%
    dplyr::filter(Group != 'No')
  
  
  cough_muscle <- dplyr::left_join(count_cough, count_muscle_ache ,  by = c('Group'))
  
  cough_muscle_shortness <- dplyr::left_join(cough_muscle,count_shortness_breath,  by = c("Group"))
  

  
  melted_symptom_frequency <- cough_muscle_shortness %>%
    tidyr::gather(key = "Event",
                  value = "Value",
                  Cough,  'Muscle Ache',
                  'Shortness of Breath') %>%
    dplyr::select(Group, Event, Value)

  
  title_stub_freq <- "Covid symptom maping in SARS-COVID-19 positive tested patients, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  melted_symptom_frequency$Group <- factor(melted_symptom_frequency$Group)
  levels(melted_symptom_frequency$Group)
  
  melted_symptom_frequency$Group <- factor(melted_symptom_frequency$Group, 
                                           levels = c("Mild", "Moderate", "Severe"), 
                                           labels = c("Mild", "Moderate", "Severe"))
  
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_frequency, ggplot2::aes(x = Event, Value, fill = Group)) +
    ggplot2::geom_col(ggplot2::aes(colour = Group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Oranges') +
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
    
    cough_muscle_shortness <- cough_muscle_shortness %>%
      dplyr::select_all()
    
    knitr::kable(cough_muscle_shortness)
  }
  
}


#' temperature_covid_tested
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
temparature_covid_tested <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                         end_date = as.Date("2020-02-01", format = "%Y-%m-%d"),
                                         plot_chart = TRUE) {
  
  
  positive_tested_symptoms <-data %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)

  
  count_temperature <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(Group = temperature) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_temperature = dplyr::n()) %>%
    dplyr::mutate('Temperature' = Count_temperature / sum(Count_temperature)*100) %>%
    dplyr::filter(Group != "No")
  

  
  title_stub_freq <- "Temperature in SARS-COVID-19 positive tested patients, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  count_temperature$Group <- factor(count_temperature$Group)
  levels(count_temperature$Group)
  
  melted_symptom_frequency$Group <- factor(melted_symptom_frequency$Group, 
                                           levels = c("37.5-38", "38.1-39", "39.1-41"), 
                                           labels = c("37.5-38", "38.1-39", "39.1-41"))
  
  
  
  plot_test <- ggplot2::ggplot(melted_symptom_frequency, ggplot2::aes(x = Group, y = Temperature)) +
    ggplot2::geom_col(ggplot2::aes(colour = Group)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Oranges') +
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
    
    cough_muscle_shortness <- cough_muscle_shortness %>%
      dplyr::select_all()
    
    knitr::kable(cough_muscle_shortness)
  }
  
}



# data_select <- data %>%
#   dplyr::select(ID, Age, Gender, Location, Country, Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell',
#               'Long Standing Health Issues', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 'Number Of Days Symptoms Showing',
#               'Pregnant', 'Self Diagnosis', 'Shortness of Breath', 'Sore Throat','Reason For Helping', 'Sputum', 'Temperature') %>%
#   dplyr::rename( id = ID,
#                  age = Age,
#                  gender = Gender,
#                  location =  Location,
#                  country = Country,
#                  chills = Chills,
#                  diarrhoea = Diarrhoea,
#                  fatigue = Fatigue,
#                  headache = Headcahe,
#                  healthcare_worker = 'Healthcare Worker',
#                  how_unwell = 'How Unwell',
#                  long_standing_health = 'Long Standing Health Issues',
#                  loss_smell_taste = 'Loss of smell and taste',
#                  muscle_ache = 'Muscle Ache',
#                  nasal_congestion = 'Nasal Congestion',
#                  nausea_vomiting = 'Nausea and Vomiting',
#                  no_days_symptoms_show = 'Number Of Days Symptoms Showing',
#                  pregnant =  'Pregnant',
#                  shortness_breath = 'Shortness of Breath',
#                  sore_throat = 'Sore Throat',
#                  sputum = 'Sputum',
#                  temperature = 'Temperature',
#                  self_diagnosis = 'Self Diagnosis',
#                  tested_or_not = 'Reason For Helping')
