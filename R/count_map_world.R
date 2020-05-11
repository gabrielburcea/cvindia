#' count_mapp_world
#'
#' @param data 
#' @param item 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#' @param title 
#'
#' @return
#' @export
#'
#' @examples
count_mapp_world <- function(data, item = "world",start_date = "2020-04-09", end_date = "2020-05-09", plot_chart = TRUE, title = "World Map") {
  
  
  map_item <- map_data(item)
  
  count_respondents <- data %>%
    dplyr::select(ID, Country) %>%
    dplyr::group_by(Country) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::mutate(Frequency = Count/sum(Count)) %>%
    dplyr::ungroup() %>%
    dplyr::arrange(desc(Count))
  
  ######Join the count tibble to map_item
  
  count_map <- left_join(map_item, count_respondents, by = c('region' = 'Country'))
  
  
  
  # Set the title
  title_stub <- ": Count of respondent per country, SARS-COVID-19, "
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title, title_stub, start_date_title, " to ", end_date_title)
  title = "World Map"
  
  ###################################################################
  map <- ggplot2::ggplot(data = count_map) +
    ggplot2::geom_polygon(ggplot2::aes(
      x = long,
      y = lat,
      group = group,
      fill = Count
    )) +
    # ggplot2::geom_sf(aes(fill  = region, geometry = region)) +
    scale_fill_gradient2_tableau(palette = "Orange-Blue Diverging")  +
    #scale_fill_gradient(low = "#132B43", high = "#56B1F7") +
    ggplot2::labs(title = chart_title,
                  subtitle = "\nNote: Results may change due to ongoing refresh of data",
                  y = "lat", x = "long", caption = "Source: GDHU, Public Health Department, Imperial College") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10),
                   legend.box = "horizontal")
  
  map
  
  if(plot_chart ==TRUE){
    
    map
    
  }else{
    
    count_map_distinct <- count_map %>% 
      dplyr::select(region, Count, Frequency) %>%
      dplyr::distinct(region, Count, Frequency) %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(10)
    
    
    count_map_distinct
    
  }
  
}

### Counts of Respondents per country 


########################### Ge levels so that able to recode some countries into same ##########################
# as.factor(data$Country) %>% 
#   levels()
# 
# data$country <- recode(data$Country, 'United States' = 'USA', 'United Kingdom' = 'UK', 'Great Britain' = 'UK') 

##### Join the new levels to the map_item 
#joined_data <- left_join(map_item, data, by = c('region' = 'country'))


###### Get Percentages In case we want it##########################

# count_respondents_per_region <- data %>%
#   dplyr::select(ID, Country) %>%
#   dplyr::group_by(Country) %>%
#   tally() %>%
#   mutate(Percentage = n / sum(n)) %>%
#   dplyr::arrange(desc(n))
# 
# knitr::kable(count_respondents_per_region)
###############################################