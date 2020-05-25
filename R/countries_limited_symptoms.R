#' countries_limited_symptoms
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
countries_limited_symptoms <- function(data, start_date = as.Date("2020-04-09", tz = "Europe/London"),
                                       end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE){
  
  levels <- c('United Kingdom' = "Great Britain", 'United Kingdom' = "England")
  comorb_divided <- data %>%
    dplyr::mutate(country = forcats::fct_recode(Country, !!!levels)) %>%
    tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four', 'Comorbidity_five', 
                                                     'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 'Comorbidity_nine'), sep = ",") %>%
    dplyr::select(ID,'Cough', 'Loss of smell and taste', 'Muscle Ache',
                  'Shortness of Breath', 'Temperature', Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four, Comorbidity_five, 
                  Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine, country) %>%
    dplyr::filter(country == "United Kingdom" | country == "India" |  country == "Phillipines" | country == "Pakistan" | country == "Nigeria")
  
  gather_divided <- comorb_divided %>%
    tidyr::pivot_longer(cols=2:6, names_to="Symptom", values_to="Severity") %>% 
    dplyr::filter(Severity!="No") %>%
    tidyr::pivot_longer(cols=starts_with("Comorbidity"), 
                        names_to=c("name","time"), names_sep="_",
                        values_to="Morbidity") %>%
    dplyr::group_by(country, Symptom) %>%
    dplyr::summarise(Count=n()) %>%
    dplyr::group_by(country) %>%
    dplyr::mutate(Percentage=Count/sum(Count) *100) %>%
    dplyr::filter(Symptom != 'Temperature')
  
  start_date <- as.Date("2020-04-09", tz = "Europe/London")
  end_date <- as.Date("2020-05-06",tz = "Europe/London")
  
  
  title_stub <- "SARS-Cov-19 symptom mapping accross per country\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  
  plot_comorb_cov_sympt <-
    ggplot2::ggplot(gather_divided, aes(x = reorder(country,-Percentage), Percentage, fill = Symptom)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::scale_x_discrete(limits = unique(gather_divided$country)) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(fill = guide_legend(nrow = 3)) +
    ggplot2::labs( title = chart_title,
                   subtitle = "Percentages: SARS-Cov-19 symptom mapping accross the five highest percentage of respondents per country",
                   y = "Percentages",
                   x = "Country",
                   caption = "Source: Dataset - Your.md Dataset") +
    ggplot2::theme(
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(
        t = 0,
        r = 21,
        b = 0,
        l = 0
      )),
      plot.title = ggplot2::element_text(size = 10, face = "bold"),
      plot.subtitle = ggplot2::element_text(size = 9),
      legend.position = "bottom",
      legend.box = "horizontal",
      axis.text.x = ggplot2::element_text(angle = 55, hjust = 1)
    )
  
  plot_comorb_cov_sympt
  
  
  if(plot_chart == TRUE){
    
    plot_comorb_cov_sympt
    
  }else{
    
    plot_comorb_cov_sympt$data %>%
      dplyr::select(country, Count, Percentage, Symptom) %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(20)
  }
  
}