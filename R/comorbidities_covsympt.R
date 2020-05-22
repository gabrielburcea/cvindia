#' covsympt
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
comorbidities_covsympt <- function(data, start_date = as.Date("2020-04-09", tz = "Europe/London"),
                     end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE){
  
  
  comorb_divided <- data %>%
    tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four', 'Comorbidity_five', 
                                                     'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 'Comorbidity_nine'), sep = ",") %>%
    dplyr::select(ID,'Cough', 'Chills', 'Diarrhoea', 'Fatigue', 'Headcahe','Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting',
                  'Shortness of Breath', 'Sore Throat', 'Sputum', 'Temperature', Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four, Comorbidity_five, 
                  Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine) 
  
  gather_divided <- comorb_divided %>%
    tidyr::pivot_longer(cols=2:14, names_to="Symptom", values_to="Severity") %>%
    dplyr::filter(Severity!="No") %>%
    tidyr::pivot_longer(cols=starts_with("Comorbidity"), 
                        names_to=c("name","time"), names_sep="_",
                        values_to="Morbidity") %>%
    dplyr::filter(Morbidity != "None" ) %>%
    dplyr::group_by(Morbidity, Symptom, Severity) %>%
    dplyr::summarise(Count=n()) %>%
    dplyr::group_by(Morbidity) %>%
    dplyr::mutate(Percentage=Count/sum(Count) *100) %>%
    dplyr::filter(Symptom != 'Temperature')
  
  
  
  # Set the title
  title_stub <- "Comorbidities and Covid symptoms\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  plot_comorb_cov_sympt <- ggplot2::ggplot( gather_divided_asthma, ggplot2::aes(x = reorder(Symptom, -Count), Count, fill = Severity)) +
    ggplot2::geom_col(ggplot2::aes(colour = Severity)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'Blues')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Counts of patients with comorbidities accross covid symptoms",
                  y = "Counts", x = "Symptoms", caption = "Source: Your.md Dataset, Global Digital Health") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  plot_comorb_cov_sympt
  
  if(plot_chart == TRUE){
    
    plot_comorb_cov_sympt
    
  }else{
    
    gather_divided_numbers <- gather_divided %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(20)
    
    gather_divided_numbers
  }
  
  
}
