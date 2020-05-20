#' map_mild_prof
#'
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#' @param item 
#'
#' @return
#' @export
#'
#' @examples
map_mild_prof <- function(data, item = "world", start_date = as.Date("2020-04-01", format = "%Y-%m-%d"),
                         end_date = as.Date("2020-05-09", format = "%Y-%m-%d"), plot_chart = TRUE) {
  
  item <- "world"
  start_date = as.Date("2020-04-01", format = "%Y-%m-%d")
  end_date = as.Date("2020-05-09", format = "%Y-%m-%d")
  
  
  map_item <- ggplot2::map_data(item) 
  data <- PivotMappe060520r
  as.factor(data$Country) %>% levels()
  data$country <- recode(data$Country, 'United States' = 'USA', 'United Kingdom' = 'UK', 'Great Britain' = 'UK')
 
  
  count_respondents <- data %>%
    dplyr::rename(Self_diagnosis = 'Self Diagnosis') %>%
    dplyr::select(ID, Country, Self_diagnosis) %>%
    dplyr::filter(Self_diagnosis != 'None') %>%
    dplyr::group_by(Country, Self_diagnosis) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::mutate(Frequency = Count/sum(Count), 
                  #find center of each symptom manifestation part along the bar 
                  Position = cumsum(Frequency) - 0.5*(Frequency)) %>% 
    dplyr::ungroup() %>%
    dplyr::arrange(desc(Count))
  
  
  count_respondents_mild <- count_respondents %>%
    dplyr::filter(Self_diagnosis == 'Mild')
    
   
  map.world_joined_mild <- left_join(map_item, count_respondents_mild, by = c('region' = 'Country'))

  # Set the title
  title_stub <- "Count of respondents with mild symptom per country,  "
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  map_mild <- ggplot2::ggplot() +
    ggplot2::geom_polygon(data =  map.world_joined_mild, ggplot2::aes(
      x = long,
      y = lat,
      group = group,
      fill = Count
    )) +
    ggplot2::geom_path(data =  map.world_joined_mild, ggplot2::aes(
      x = long,
      y = lat,
      group = group),
      color = "white", size = 0.1) +
    ggplot2::coord_equal() +
    ggthemes::theme_map() +
    viridis::scale_fill_viridis(option = "magma",  direction = -1) +
    # ggplot2::geom_sf(aes(fill  = region, geometry = region)) +
    #scale_fill_gradient(low = "#132B43", high = "#56B1F7") +
    ggplot2::labs(title = 'World Map: Symptom SARS-Covid-19 Mapping',
                  subtitle = chart_title,
                  y = NULL, x = NULL, caption = "Data Source: Your.md") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.box = "horizontal")
  
  map_mild

  if(plot_chart ==TRUE){
    
    map_mild
    
  }else{
    
    count_respondents_mild_n <- count_respondents_mild %>%
      dplyr::select(Country, Self_diagnosis, Count, Frequency) %>%
      dplyr::arrange(dplyr::desc(Count)) %>%
      dplyr::top_n(20)
    
    count_respondents_mild_n 
  }
  
}