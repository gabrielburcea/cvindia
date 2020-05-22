#' heart_disease_covsympt
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
heart_disease_covsympt <- function(data, start_date = as.Date("2020-04-09", tz = "Europe/London"),
                      end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE){
  
  
  comorb_divided <- data %>%
    tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four', 'Comorbidity_five', 
                                                     'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 'Comorbidity_nine'), sep = ",") %>%
    dplyr::select(ID,'Cough', 'Fatigue','Loss of smell and taste', 'Muscle Ache', 
                  'Shortness of Breath', Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four, Comorbidity_five, 
                  Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine) 
  
  gather_divided_heart_disease <- comorb_divided %>%
    tidyr::pivot_longer(cols=2:6, names_to="Symptom", values_to="Severity") %>%
    dplyr::filter(Severity!="No") %>%
    tidyr::pivot_longer(cols=starts_with("Comorbidity"), 
                        names_to=c("name","time"), names_sep="_",
                        values_to="Morbidity") %>%
    dplyr::filter(Morbidity != "None" & Morbidity == "Long-Standing Heart Disease") %>%
    dplyr::group_by(Morbidity, Symptom, Severity) %>%
    dplyr::summarise(Count=n()) %>%
    dplyr::group_by(Morbidity) %>%
    dplyr::mutate(Percentage=Count/sum(Count) *100) %>%
    dplyr::filter(Symptom != 'Temperature')
  
  
  
  # Set the title
  title_stub <- "Patients with heart disease and Covid symptoms\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  plot_heart_disease <- ggplot2::ggplot(gather_divided_heart_disease, ggplot2::aes(x = reorder(Symptom, -Count), Count, fill = Severity)) +
    ggplot2::geom_col(ggplot2::aes(colour = Severity)) +
    ggplot2::coord_flip() + 
    ggplot2::scale_fill_brewer(palette = 'OrRd')  +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Counts of patients with heart disease and severity of Covid symptoms",
                  y = "Counts", x = "Symptoms", caption = "Source: Your.md Dataset, Global Digital Health") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  plot_heart_disease 
  
  if(plot_chart == TRUE){
    
    plot_heart_disease 
    
  }else{
    
    gather_divided_heart_disease_numbers <- gather_divided_heart_disease %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(10)
    
    gather_divided_heart_disease_numbers
    
  }
  
  
}