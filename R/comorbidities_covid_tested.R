#' comorbidities_covid_status
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
comorbidities_covid_status <- function(data, start_date = as.Date("2020-04-19"), end_date = as.Date("2020-09-01"), plot_chart = TRUE) {
  
  
  comborbidities_covid_status <- data %>%
    dplyr::select(id, covid_tested, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition, 
                  liver_disease, kidney_disease) %>%
    tidyr::drop_na()
  
  options(digits = 2)
  
  gather_divided <- comborbidities_covid_status  %>%
    tidyr::pivot_longer(cols= 3:11, names_to="comorbidities", values_to="yes_no") %>%
    dplyr::filter(yes_no !="No") %>%
    dplyr::group_by(covid_tested, comorbidities) %>%
    dplyr::summarise(count=n()) %>%
    dplyr::mutate(percentage=  count/sum(count) *100)
  
  gather_divided$covid_tested <- as.factor(gather_divided$covid_tested)
  gather_divided$comorbidities <- as.factor(gather_divided$comorbidities)
  
  start_date = as.Date("2020-04-19") 
  end_date = as.Date("2020-09-01")
  
  title_stub <- "Comorbidities and covid status\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  comorbidities_covid_status <- 
    ggplot2::ggplot(gather_divided, ggplot2::aes(x = reorder(comorbidities, - percentage), percentage, fill = covid_tested)) +
    ggplot2::geom_col(ggplot2::aes(colour = covid_tested), width = 0.9) +
    #geom_text(aes(label = percentage, group = comorbidities)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Greens')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Responders with comorbidities and covid status",
                  y = "Percentage", x = "Comorbidities", caption = "Source: Your.md Dataset") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  
  comorbidities_covid_status
  
  if(plot_chart == TRUE){
    
    comorbidities_covid_status
    
  }else{
    
    gather_divided_numbers <- gather_divided %>%
      dplyr::arrange(desc(count))
    
    gather_divided_numbers
  }
  
}