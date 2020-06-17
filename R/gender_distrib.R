#' gender_distrib
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
gender_distrib <- function(data, start_date = as.Date("2020-04-09", tz = "Europe/London"),
                          end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE){
  
  gender_tb <- data %>%
    dplyr::select(ID, Gender) %>%
    dplyr::group_by(Gender) %>%
    tally() %>%
    dplyr::mutate(percent = n/sum(n))
  

  title_stub <- "Gender distribution in the dataset\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  bp <- ggplot2::ggplot(gender_tb, aes(x = "", y = percent, fill = Gender)) + 
    geom_bar(width = 1, stat = "identity")
  
  gender_pie <- bp + ggplot2::coord_polar("y", start = 0) + 
    ggplot2::scale_fill_brewer(palette = "Blues") +
    ggplot2::theme(axis.text.x = ggplot2::element_blank()) +
    ggplot2::labs( title = chart_title,
                   caption = "Source: Dataset - Your.md Dataset")
    
  gender_pie
  
  
  if(plot_chart == TRUE){
    
    gender_pie
    
  }else{
    
    gender_tb  <- gender_tb %>% dplyr::arrange(desc(n))
    
    gender_tb
  }
  
}

