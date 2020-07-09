#' no_cov
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
no_cov <- function(data,start_date = as.Date("2020-04-09", tz = "Europe/London"),
                              end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE){
  
  
  show_sympt_cov <- data %>%
    dplyr::select(id, covid_tested, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
                  shortness_breath, sore_throat, sputum, temperature) %>%
    tidyr::pivot_longer(cols=3:15, names_to="Symptom", values_to="Answer") %>%
    dplyr::filter(covid_tested == 'none') %>%
    dplyr::group_by(Symptom, Answer) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::mutate(Percent = Count/sum(Count)) %>%
    dplyr::filter(Symptom != 'temperature')
  
  
  title_stub <- "Symptoms in respondents with no covid\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  plot_show_symptoms <-
    ggplot2::ggplot(show_sympt_cov, ggplot2::aes(x = reorder(Symptom,-Count), Count, fill = Answer)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::scale_x_discrete(limits = unique(show_sympt_cov$Symptom)) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_fill_brewer(palette="Oranges")+
    ggplot2::theme_minimal() +
    ggplot2::guides(fill = ggplot2::guide_legend(nrow = 3)) +
    ggplot2::labs( title = chart_title,
                   subtitle = "Counts of symptoms in respondents with no Covid-19",
                   y = "Counts",
                   x = "Symptoms",
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
      legend.position = "bottom",
      legend.box = "horizontal",
      axis.text.x = ggplot2::element_text(angle = 55, hjust = 1)
    )
  
  plot_show_symptoms
  
  if(plot_chart == TRUE){
    
    
    plot_show_symptoms
    
  }else{
    
    show_sympt_cov
    
  }
}
