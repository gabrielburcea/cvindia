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