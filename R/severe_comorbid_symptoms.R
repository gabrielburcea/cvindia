#' severe_comorbid_symptoms
#'
#' @param data 
#' @param start_date 
#' @param end_date 
#' @param plot_chart 
#' @param breaks_plot 
#'
#' @return
#' @export
#'
#' @examples
severe_comorbid_symptoms <- function(data, start_date = as.Date("2020-04-09", tz = "Europe/London"),
                                       end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE, breaks_plot = seq(0, 100, by = 20)){
  
  
  comorb_divided <- data %>%
    tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four', 'Comorbidity_five', 
                                                     'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 'Comorbidity_nine'), sep = ",") %>%
    dplyr::select(ID, 'Chills', 'Cough', 'Diarrhoea', 'Fatigue', 'Headcahe', 'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 
                  'Nausea and Vomiting', 'Shortness of Breath', 'Sore Throat', 'Sputum', 'Temperature', Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four, Comorbidity_five, 
                  Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine) 
  
  gather_divided <- comorb_divided %>%
    tidyr::pivot_longer(cols=2:14, names_to="Symptom", values_to="Severity") %>%
    dplyr::filter(Severity!="No") %>%
    tidyr::pivot_longer(cols=starts_with("Comorbidity"), 
                        names_to=c("name","time"), names_sep="_",
                        values_to="Morbidity") %>%
    dplyr::filter(Morbidity != "None") %>%
    dplyr::group_by(Morbidity, Symptom, Severity) %>%
    dplyr::summarise(Count=n()) %>%
    dplyr::group_by(Morbidity) %>%
    dplyr::mutate(Percentage=Count/sum(Count) *100) %>%
    dplyr::filter(Symptom != 'Temperature')
  
  
  gather_divided_severe <- gather_divided %>%
    dplyr::filter(Severity == "Severe")
  
  
  # Set the title
  title_stub <- "Symptom profile accross comorbidities\n"
  start_date_title <- format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <- paste0(title_stub, start_date_title, " to ", end_date_title)
  
  # plot the admissions and discharges (non-emergency appears as well )
  plot_comorb_severe <- ggplot2::ggplot(gather_divided_severe,  ggplot2::aes(Morbidity, Count, group = Symptom)) + #shape = Event,  colour = Event
    # ggplot2::geom_bar(stat = "identity", position = "identity" , alpha=0.4, width = 0.5, fill = "slateblue4") +
    ggplot2::geom_line(ggplot2::aes(linetype = Symptom, color = Symptom), size = 1.0) +
    #ggplot2::geom_point(ggplot2::aes(shape = Symptom), size = 1.0) +
    ggplot2::scale_y_continuous(limits = c(0, NA), breaks = breaks_plot) +
    # ggplot2::scale_shape_manual(values = c(7, 6, 5)) +
    #ggplot2::scale_linetype_manual(values = c("solid", "solid" , "twodash")) +
    #ggplot2::scale_color_manual(values=c( 'blue', "orange",  "red")) +
    ggplot2::theme_bw() +
    ggplot2::labs(title = chart_title,
                  subtitle = "Counts of symptoms by comorbidities for patients with severe version of covid",
                  y = "Counts", x = "Comorbidities", caption = "Source: Your.md Dataset, Global Digital Health") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 10, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 9),
                   legend.position = "bottom", legend.box = "horizontal",
                   axis.text.x = ggplot2::element_text(angle = 55, hjust = 1))
  
  plot_comorb_severe
  
  if(plot_chart == TRUE){
    
    plot_comorb_severe
    
  }else{
    
    gather_divided_severe_numbers <- gather_divided_severe %>%
      dplyr::arrange(desc(Count)) %>%
      dplyr::top_n(10)
    
    gather_divided_severe_numbers
  }
}
