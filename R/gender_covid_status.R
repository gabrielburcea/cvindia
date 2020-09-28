#'gender_covid_status
#'
#' @param data 
#' @param covid_status 
#' @param plot_chart 
#'
#' @return
#' @export
#'
#' @examples
gender_covid_status <- function(data, covid_status = "negative", plot_chart = TRUE) {
  
  
  gender_covid_status <- data %>%
    dplyr::filter(covid_tested == covid_status) %>% 
    dplyr::group_by(covid_tested, gender) %>% 
    dplyr::summarise(count = n()) %>% 
    dplyr::mutate(percent = count/sum(count)*100)
  
  
  title_stub <- "Gender distribution in responders with SARS-Covid19 "
  
  
  chart_title <- paste0(title_stub,covid_status)
  
  bp <- ggplot2::ggplot(gender_covid_status, ggplot2::aes(x = "", y = percent, fill = gender)) + 
    ggplot2::geom_bar(width = 1, stat = "identity") +
    ggplot2::coord_polar("y", start = 0) + 
    ggplot2::scale_fill_brewer(palette = "Blues") +
    ggplot2::theme(axis.text.x = ggplot2::element_blank()) + 
    ggplot2::labs(title = chart_title,
                  y = "Percentage", caption = "Source: Your.md Dataset, Global Digital Health")
  
  if(plot_chart == TRUE){
    
    bp
    
  }else{
    
    gender_covid_status
    
    
  }
  
}