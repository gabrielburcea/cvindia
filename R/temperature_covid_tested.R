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
  
  
  positive_tested_symptoms <- data_select %>% 
    dplyr::mutate(tested_positive = stringr::str_detect(tested_or_not, pattern = "Positive" )) %>%
    dplyr::filter(tested_positive == TRUE)
  
  
  count_temperature <- positive_tested_symptoms %>%
    dplyr::select(id, tested_positive, temperature) %>%
    dplyr::rename(Group = temperature) %>%
    dplyr::group_by(Group) %>%
    dplyr::summarise(Count_temperature = dplyr::n()) %>%
    dplyr::mutate('Temperature' = Count_temperature / sum(Count_temperature)*100) %>%
    dplyr::filter(Group != "No")
  
  start_date = as.Date("2020-04-09", format = "%Y-%m-%d") 
  end_date = as.Date("2020-05-09", format = "%Y-%m-%d")
  
  title_stub_freq <- "Temperature in SARS-COVID-19 positive tested patients, Frequency\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title_2 <- paste0(title_stub_freq, start_date_title, " to ", end_date_title)
  
  count_temperature$Group <- factor(count_temperature$Group)
  levels(count_temperature$Group)
  
  count_temperature$Group <- factor(count_temperature$Group, 
                                           levels = c("37.5-38", "38.1-39", "39.1-41"), 
                                           labels = c("37.5-38", "38.1-39", "39.1-41"))
  
  
  
  plot_test <- ggplot2::ggplot(count_temperature, ggplot2::aes(x = Group, y = Temperature)) +
    ggplot2::geom_bar(stat = 'identity', fill = "#FF6666") +
    ggplot2::coord_flip() + 
    #ggplot2::scale_fill_brewer(palette = "RdYIGn") +
    ggplot2::labs(title = chart_title_2,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  x = "Symptoms manifestation in Covid Patients, tested positive", y = "Frequency", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.position = "bottom" , legend.box = "horizontal") +
    ggplot2::theme_bw()
  
  
  if(plot_chart == TRUE){
    
    plotly::ggplotly(plot_test)
    
  }else{
    
    count_temperature <- count_temperature %>%
      dplyr::select_all() %>%
      dplyr::rename(Count = Count_temperature, Frequency = Temperature)
    
   count_temperature
  }
  
}
