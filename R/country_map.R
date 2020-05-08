#' country_map
#'
#' @param country 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#' @param which_country 
#'
#' @return
#' @export
#'
#' @examples data
country_map <- function(country, start_date, end_date, plot_chart, which_country){
  
 

  ######### Count respondents per country for original dataset ###################################################
  count_respondents <- data %>%
    dplyr::select(ID, Country, Location) %>%
    dplyr::filter(Country == "India") %>%
    dplyr::group_by(Location, Country) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::ungroup() %>%
    dplyr::select(Country, Location,Count)
  
 count_respondents <- count_respondents %>%
    dplyr::mutate(Ranking = case_when(Count == 0 | Count <= 10 ~ '0-10',
                                      Count == 11  | Count <= 20 ~ '11-20', 
                                      Count == 21  | Count <= 30 ~ '21-30',
                                      Count == 31  | Count <= 40 ~ '31-40',
                                      Count == 41  | Count <= 50 ~ '41-50',
                                      Count == 51  | Count <= 60 ~ '51-60',
                                      Count == 61  | Count <= 70 ~ '61-70',
                                      Count == 71  | Count <= 80 ~ '71-80',
                                      Count == 81  | Count <= 90 ~ '81-90',
                                      Count == 91  | Count <= 100 ~ '91-100',
                                      Count == 101 | Count <= 150  ~ '101-150',
                                      Count == 151 | Count <= 200  ~ '151-200',
                                      Count == 201 | Count <= 250  ~ '201-250',
                                      Count == 251 | Count <= 300  ~ '251-300',
                                      Count == 301 | Count <= 400  ~ '301-400',
                                      Count == 401 | Count <= 500 ~ '401-500',
                                      Count == 601 | Count <= 700 ~ '601-700',
                                      Count == 701 | Count <= 800 ~ '701-800',
                                      Count == 801 | Count <= 900 ~ '801-900',
                                      Count == 901 | Count <= 1000 ~ '901-1000',
                                      Count == 1001 | Count <= 1250 ~ '1001-1250',
                                      Count == 1251 | Count <= 1500 ~ '1251-1500',
                                      Count == 1501 | Count <=  2000 ~ '1501-2000', 
                                      Count == 2001 | Count <= 2500 ~ '2001-2500',
                                      Count == 2501 | Count <= 100000000 ~ '2501+')
                  ) %>%
   dplyr::arrange(Count)
   
  
  ######Join the count tibble to map_item
  
  count_map <- left_join(map_item, count_respondents, by = c('region' = 'Country', 'subregion' = 'Location'))
  
  ###### Get the levels for setting the order of the legend #########
  count_map$Ranking <- as.factor(count_map$Ranking)
  
  levels(count_map$Ranking)
  count_map$Ranking <- factor(
    count_map$Ranking,
    levels = c(
      '0-10',
      '11-20',
      '21-30',
      '31-40',
      '41-50',
      '51-60',
      '61-70',
      '71-80',
      '81-90',
      '91-100',
      '101-150',
      '151-200',
      '201-250',
      '251-300',
      '301-400',
      '401-500',
      '601-700',
      '701-800',
      '801-900',
      '901-1000',
      '1001-1250',
      '1251-1500',
      '1501-2000',
      '2001-2500',
      '2501+'
    )
  )
  

  
  # Set the title
  title_stub <- " Count of respondent per country, SARS-COVID-19, "
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(which_country, title_stub, start_date_title, " to ", end_date_title)
  
  ###################################################################
  map <- ggplot2::ggplot(data = count_map) +
    geom_polygon(aes(
      x = long,
      y = lat,
      group = group,
      fill = Ranking
    )) +
    #scale_fill_gradient(low = "#132B43", high = "#56B1F7") +
    labs(title = chart_title,
         subtitle = "source: GDHU unit, Public Health Department, Imperial College")
  
  map
  
  if(plot_chart ==TRUE){
    
    map
    
  }else{
    
    count_map_distinct <- count_map %>% 
      dplyr::select(region, subregion, Count, Ranking) %>%
      dplyr::distinct(region, subregion, Count, Ranking) %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(10)
    
    
    count_map_distinct
    
  }
  
  
}

