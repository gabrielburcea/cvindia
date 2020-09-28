#' sympt_positive_age_band
#'
#' @param data a dataset that contains ids, showing symptoms of covid, and symptoms
#' @param start_date a min date passed in as.Date
#' @param end_date a max data passed as.Date
#' @param plot_chart if TRUE then give me a chart, if FALSE then give me a table with symptoms accross age, with counts and percentages
#'
#' @return
#' @export
#'
#' @examples
sympt_positive_age_band <- function(data, start_date = as.Date("2020-04-19"), end_date = as.Date("2020-09-01"), plot_chart = TRUE) {
  
  
  symptoms_cov_age_band <- data %>%
    dplyr::select(id, covid_tested, age_band, chills, cough, diarrhoea, fatigue, headache, loss_smell_taste, muscle_ache, nasal_congestion, nausea_vomiting, 
                  shortness_breath, sore_throat, sputum, temperature, loss_appetite, chest_pain, itchy_eyes, joint_pain) %>%
    tidyr::drop_na()
  
  gather_divided <- symptoms_cov_age_band %>%
    tidyr::pivot_longer(cols= 4:20, names_to="symptoms", values_to="yes_no") %>%
    dplyr::filter(age_band != "0-19")  %>%
    dplyr::group_by(age_band, symptoms, yes_no) %>%
    dplyr::summarise(count=n()) %>%
    dplyr::mutate(percentage=  count/sum(count) *100) %>%
    dplyr::filter(yes_no !="No") %>%
    dplyr::arrange(desc(percentage))
  
  gather_divided$age_band <- as.factor(gather_divided$age_band)
  gather_divided$symptoms <- as.factor(gather_divided$symptoms)
  
  start_date = as.Date("2020-04-19") 
  end_date = as.Date("2020-09-01")
  
  title_stub <- "SARS-Covid-19 symptoms across age band\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)

  
  sympt_show_age_band <- 
    ggplot2::ggplot(gather_divided, ggplot2::aes(x = reorder(symptoms, - count), count, fill = age_band)) +
    ggplot2::geom_col(ggplot2::aes(colour = age_band), width = 0.9 ) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Reds')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Symptoms accross age band",
                  y = "Count", x = "Symptoms", caption = "Source: Your.md Dataset, Global Digital Health") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  
  sympt_show_age_band
  
  if(plot_chart == TRUE){
    
  sympt_show_age_band
    
  }else{
    
    gather_divided_numbers <- gather_divided %>%
      dplyr::arrange(desc(count))
    
    gather_divided_numbers
  }

}
  
  


