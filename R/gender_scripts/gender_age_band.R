#' gender_age_band
#'
#' @param data contains id, age_band and gender
#' @param age_category categories to choose are 20-39; 40-59; 60+
#' @param plot_chart if plot_chart == TRUE gives as an output a pie chart of percentages of gender, if FALSE it gives me a table with counts and percentages of gender accross age band chosen 
#'
#' @return
#' @export
#'
#' @examples
gender_age_band <- function(data, age_category = "20-39", plot_chart = TRUE) {
  

    gender_age_band <- data %>%
    dplyr::filter(age_band == age_category) %>% 
    dplyr::group_by(age_band, gender) %>% 
    dplyr::summarise(count = n()) %>% 
    dplyr::mutate(percent = count/sum(count)*100)
  
  
  title_stub <- "Gender distribution in age category: "
 
  chart_title <- paste0(title_stub,age_category)
  
  bp <- ggplot2::ggplot(gender_age_band, ggplot2::aes(x = "", y = percent, fill = gender)) + 
    ggplot2::geom_bar(width = 1, stat = "identity") +
    ggplot2::coord_polar("y", start = 0) + 
    ggplot2::scale_fill_brewer(palette = "Blues") +
    ggplot2::theme(axis.text.x = ggplot2::element_blank()) + 
    ggplot2::labs(title = chart_title,
                  subtitle = "Gender distribution per age band",
                  y = "Percentage", caption = "Source: Your.md Dataset, Global Digital Health")
  
  if(plot_chart == TRUE){
    
    bp
    
  }else{
    
      gender_age_band
    
    
    }

}

