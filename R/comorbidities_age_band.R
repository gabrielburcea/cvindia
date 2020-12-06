#' comorbidities_age_band
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#'
#' @return
#' @export
#'
#' @examples
comorbidities_age_band <- function(data, start_date = as.Date("2020-04-19"), end_date = as.Date("2020-09-01"), plot_chart = TRUE) {
  
  
  comborbidities_age_band <- data %>%
    dplyr::select(id, covid_tested, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition, 
                  liver_disease, kidney_disease) %>%
    tidyr::drop_na()
  

  
  gather_divided <-  comborbidities_age_band  %>%
    tidyr::pivot_longer(cols= 4:12, names_to="comorbidities", values_to="yes_no") %>%
    dplyr::group_by(age_band, covid_tested, comorbidities, yes_no) %>%
    dplyr::summarise(count=n()) %>%
    dplyr::mutate(percentage=  count/sum(count) *100) %>%
    dplyr::filter(yes_no !="No" & age_band != "0-19" & covid_tested != "negative") %>%
    dplyr::arrange(desc(percentage))
  
  gather_divided$yes_no <- NULL
  
  
  gather_divided$comorbidities <- as.factor(gather_divided$comorbidities)
  gather_divided$age_band <- as.factor(gather_divided$age_band)
  gather_divided$percentage <- round(gather_divided$percentage, digits = 1)
  
  start_date = as.Date("2020-04-19") 
  end_date = as.Date("2020-09-01")
  
  title_stub <- "Comorbidities across age band\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  comorbidities_age_band <- 
    ggplot2::ggplot(gather_divided, ggplot2::aes(x = reorder(comorbidities, - count), count, fill = age_band)) +
    ggplot2::geom_col(ggplot2::aes(colour = age_band), width = 0.9) +
    #geom_text(aes(label = count, group = comorbidities)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Greens')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Responders with comorbidities and age band",
                  y = "Count", x = "Comorbidities", caption = "Source: Your.md Dataset") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  
  comorbidities_age_band
  
  if(plot_chart == TRUE){
    
    comorbidities_age_band
    
  }else{
    
    gather_divided_numbers <- gather_divided %>%
      dplyr::arrange(desc(count))
    
    gather_divided_numbers
  }
  
}
