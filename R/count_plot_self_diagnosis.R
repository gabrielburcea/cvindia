#' count_plot_self_diagnosis
#'
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot 
#' @param title 
#'
#' @return
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
count_plot_self_diagnosis <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), end_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                      plot_chart = TRUE, title = "Test") {
  
  
  #### Count self diagnosis ############
  count_self_diagnosis <- data %>%
    dplyr::select(id, self_diagnosis) %>%
    dplyr::rename(Group = self_diagnosis) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::mutate(Frequency = Count/sum(Count))
  
    # Set the title
  title_stub <- ": Count of self diagnosis, SARS-COVID-19, "
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title, title_stub, start_date_title, " to ", end_date_title)              
                  
  ######### setting the blank theme to set up my pie chart as minimal as possible 
  ########### try without the function bellow and they pie chart appears with circular coordinate.
    
    
  ###### Get the levels for setting the order of the legend #########
  count_self_diagnosis$Group <- as.factor(count_self_diagnosis$Group)

  levels(count_self_diagnosis$Group)
  #Reverse the order as follow
  
      
  count_self_diagnosis  <- count_self_diagnosis  %>%
    dplyr::mutate(Group = factor(Group,levels = c('None', 'Mild', 'Moderate','Severe')))

  plot <- ggplot2::ggplot(data = count_self_diagnosis, ggplot2::aes(x = Group,y = Count, fill = Group)) +
    ggplot2::geom_bar(stat = 'identity') +
    ggplot2::scale_fill_brewer(palette = "Oranges") +
    ggplot2::labs(title = chart_title,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  y = "Count of Resondents, n", x = "Symptom Ranking", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.box = "horizontal") +
   
    ggplot2::theme_bw()
  
  if(plot_chart == TRUE){
    
    plot
  
  }else{
    
    count_self_diagnosis <- count_self_diagnosis %>%
      dplyr::select(Group, Count, Frequency) %>%
      dplyr::arrange(desc(Count))
  
  
  
  }
  
  
}

#' self_diagnosis_mild_mod_severe
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
self_diagnosis_mild_mod_severe <- function(data, start_date = as.Date("2020-01-01", format = "%Y-%m-%d"), end_date = as.Date("2020-01-01", format = "%Y-%m-%d"), 
                                      plot_chart = TRUE, title = "Test") {
  
  
  #### Count self diagnosis ############
  count_self_diagnosis <- data %>%
    dplyr::select(id, self_diagnosis) %>%
    dplyr::filter(self_diagnosis != 'None') %>%
    dplyr::rename(Group = self_diagnosis) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::mutate(Frequency = Count/sum(Count))
  
  # Set the title
  title_stub <- ": Count of self diagnosis, SARS-COVID-19, "
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title, title_stub, start_date_title, " to ", end_date_title)              
  
  ######### setting the blank theme to set up my pie chart as minimal as possible 
  ########### try without the function bellow and they pie chart appears with circular coordinate.
  
  
  ###### Get the levels for setting the order of the legend #########
  count_self_diagnosis$Group <- as.factor(count_self_diagnosis$Group)
  
  levels(count_self_diagnosis$Group)
  #Reverse the order as follow
  
  
  count_self_diagnosis  <- count_self_diagnosis  %>%
    dplyr::mutate(Group = factor(Group,levels = c('Mild', 'Moderate','Severe')))
  
  plot <- ggplot2::ggplot(data = count_self_diagnosis, ggplot2::aes(x = Group,y = Count, fill = Group)) +
    ggplot2::geom_bar(stat = 'identity') +
    ggplot2::scale_fill_brewer(palette = "Oranges") +
    ggplot2::labs(title = chart_title,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  y = "Count of Resondents, n", x = "Symptom Ranking", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.box = "horizontal") +
    
    ggplot2::theme_bw()
  
  if(plot_chart == TRUE){
    
    plot
    
  }else{
    
    count_self_diagnosis <- count_self_diagnosis %>%
      dplyr::select(Group, Count, Frequency) %>%
      dplyr::arrange(desc(Count))
    
    
    
  }
  
  
}




#### #data <- PivotMappe060520

###### Before runinng the count_plot_self_diagnose - run the bellow lines first 

# dt_select <- data %>% dplyr::select(ID, Age, Gender, Location,'Date Completed', Country, Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell',
#               'Long Standing Health Issues', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 'Number Of Days Symptoms Showing',
#               'Pregnant', 'Self Diagnosis', 'Shortness of Breath', 'Sore Throat', 'Sputum', 'Temperature') %>%
#   dplyr::rename( id = ID,
#                  age = Age,
#                  gender = Gender,
#                  location =  Location,
#                  date_completed = 'Date Completed',
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
#                  self_diagnosis = 'Self Diagnosis') #%>%



###Finding the min max date ###########

# data <- as.data.frame(data)              
# 
# datadates <- data %>%
#   dplyr::select('Date Completed') %>%
#   dplyr::rename(date_completed = 'Date Completed')
# 
# 
# datadates$date_completed <-  as.Date(datadates$date_completed)
# 
# datadates <- tibble::tibble(datadates)
# start_date <- summarise(datadates, min(date_completed))            
# 
# end_date <- summarise(datadates, max(datadates$date_completed)) 



# dt_select <- dt_select %>%
#   dplyr::mutate(Age_band = case_when(age == 0 ~ '0',
#                                      age == 1 | age <= 4 ~ '1-4',
#                                      age == 5 | age <= 9 ~ '5-9',
#                                      age == 10 | age <= 14 ~ '10-14',
#                                      age == 15 | age <= 19 ~ '15-19',
#                                      age == 20 | age <= 24 ~ '20-24',
#                                      age == 25 | age <= 29 ~ '25-29',
#                                      age == 30 | age <= 34 ~ '30-34',
#                                      age == 35 | age <= 39 ~ '35-39',
#                                      age == 40 | age <= 44 ~ '40-44',
#                                      age == 45 | age <= 49 ~ '45-49',
#                                      age == 50 | age <= 54 ~ '50-54',
#                                      age == 55 | age <= 59 ~ '55-59',
#                                      age == 60 | age <= 64 ~ '60-64',
#                                      age == 65 | age <= 69 ~ '65-69',
#                                      age == 70 | age <= 74 ~ '70-74',
#                                      age == 75 | age <= 79 ~ '75-79',
#                                      age == 80 | age <= 84 ~ '80-84',
#                                      age == 85 | age <= 89 ~ '85-89',
#                                      age == 90 | age <= 94 ~ '90-94',
#                                      age >= 95  ~ '95+'))
