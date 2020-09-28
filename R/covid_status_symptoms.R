#' covid_status_symptoms
#'
#' @param data contains id, covid_tested (with categories - positive, negative, showin symptoms) and comorbidities
#' @param start_date  min date as.Date
#' @param end_date max date as.Date
#' @param plot_chart if plot_chart == TRUE a plot with percentages of symptoms across covid tested categories 
#'
#' @return
#' @export
#'
#' @examples
covid_status_symptoms <- function(data, start_date = as.Date("2020-04-09"), end_date = as.Date("2020-09-01"), 
                                  plot_chart = TRUE) { 
  
  covid_status_symptoms <- data %>%
    dplyr::select(id, covid_tested, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
                  shortness_breath, sore_throat, sputum, temperature, loss_appetite, chest_pain, itchy_eyes, joint_pain) %>%
    tidyr::drop_na()
  
  gather_divided <- covid_status_symptoms %>%
    tidyr::pivot_longer(cols= 3:19, names_to="symptoms", values_to="yes_no") %>%
    dplyr::group_by(covid_tested, symptoms, yes_no) %>%
    dplyr::summarise(count=n()) %>%
    dplyr::mutate(percentage=  count/sum(count) *100) %>%
    dplyr::arrange(desc(percentage)) %>%
    dplyr::filter(yes_no !="No")
   
  
  gather_divided$covid_tested <- as.factor(gather_divided$covid_tested)
  gather_divided$symptoms <- as.factor(gather_divided$symptoms)
  
  title_stub <- "Responders with Covid-19 symptoms and covid status\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  comorbid_covid_tested <- 
    ggplot2::ggplot(gather_divided, ggplot2::aes(x = reorder(symptoms, - count), count, fill = covid_tested)) +
    ggplot2::geom_col(ggplot2::aes(colour = covid_tested), width = 0.9) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Reds')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Symptoms and covid status",
                  y = "Counts", x = "Symptoms", caption = "Source: Your.md Dataset, Global Digital Health") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  
  comorbid_covid_tested
  
  if(plot_chart == TRUE){
    
    comorbid_covid_tested
    
  }else{
    
    gather_divided_numbers <- gather_divided %>%
      dplyr::arrange(desc(count))
    
    gather_divided_numbers
  }
  
  }