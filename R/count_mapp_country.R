#' count_map_country
#'
#' @param data 
#' @param item 
#' @param plot_chart 
#'
#' @return
#' @export
#'
#' @examples
count_mapp_country <- function(data, item = "world", plot_chart = TRUE) {
    
    
   
  
    map_world <- read_csv("data/world_cities.csv") %>%
      dplyr::rename(Location = location)
    
    data <- dplyr::full_join(data, map_world, by = c("Location"))
    
    ######### Count respondents per country for original dataset ###################################################
    count_respondents <- data %>%
      dplyr::select(ID, country) %>%
      dplyr::group_by(country) %>%
      dplyr::summarise(Count = n()) %>%
      dplyr::ungroup() %>%
      dplyr::mutate(
        Ranking = case_when(
          Count == 0  | Count <= 100 ~ '0-100',
          Count == 101 |
            Count <= 300  ~ '101-300',
          Count == 301 |
            Count <= 600 ~ '301-600',
          Count == 601 |
            Count <= 1000 ~ '601-1000',
          Count == 1001 |
            Count <= 1500 ~ '1001-1500',
          Count == 1501 |
            Count <=  2000 ~ '1501-2000',
          Count == 2001 |
            Count <= 2500 ~ '2001-2500',
          Count == 2501 |
            Count <= 100000000 ~ '2501+'
        )
      ) %>%
      
      arrange(desc(Count))
    
    ######Join the count tibble to map_item
    
    count_map <- left_join(map.world, count_respondents, by = c('region' = 'country'))
    
    ###### Get the levels for setting the order of the legend #########
    count_map$Ranking <- as.factor(count_map$Ranking)
    
    levels(count_map$Ranking)
    #Reverse the order as follow
    count_map$Ranking <-
      factor(
        count_map$Ranking,
        levels = c(
          "0-100",
          "101-300" ,
          "301-600",
          "601-1000",
          "1001-1500",
          "1501-2000",
          "2501+"
        )
      )
    
    ###################################################################
    map <- ggplot2::ggplot() +
      geom_polygon(data = count_map, aes(
        x = long,
        y = lat,
        group = group,
        fill = Ranking
      )) +
      #scale_fill_gradient(low = "#132B43", high = "#56B1F7") +
      labs(title = 'Count of respondent per country, SARS-COVID-19'
           , subtitle = "source: GDHU unit, Public Health Department, Imperial College")
    
    map
    
    if(plot_chart ==TRUE){
      
      map
     
  }else{
    
    count_map_distinct <- count_map %>% 
      dplyr::select(region, Count, Ranking) %>%
      dplyr::distinct(region, Count, Ranking) %>%
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