#' symptom_comorbidities_no_cv counting non covid
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
symptom_comorbidities_no_cv <- function(data= data,start_date = as.Date("2020-04-09", tz = "Europe/London"),
                                        end_date = as.Date("2020-05-06",tz = "Europe/London"), plot_chart = TRUE) {
  
  
  symptom_morbidities_no_cv <- data %>%
    dplyr::select(
      id,
      covid_tested,
      chills,
      cough,
      diarrhoea,
      fatigue,
      headache,
      loss_smell_taste,
      muscle_ache,
      nasal_congestion,
      nausea_vomiting,
      shortness_breath,
      sore_throat,
      sputum,
      temperature,
      asthma,
      diabetes_type_one,
      diabetes_type_two,
      obesity,
      hypertension,
      heart_disease,
      lung_condition,
      liver_disease,
      kidney_disease
    ) %>%
    tidyr::pivot_longer(cols = 3:15,
                        names_to = "Symptom",
                        values_to = "Answer") %>%
    dplyr::filter(covid_tested == 'none' & Answer == "Yes") %>%
    tidyr::pivot_longer(cols = 3:11, names_to = "Morbidities") %>%
    dplyr::filter(value == "Yes") %>%
    dplyr::group_by(Morbidities, Symptom, Answer) %>%
    dplyr::summarise(Count = n()) %>%
    dplyr::filter(Symptom != 'temperature') %>%
    dplyr::arrange(desc(Count))
  
  
  
  start_date = as.Date("2020-04-09", tz = "Europe/London")
  end_date = as.Date("2020-05-06", tz = "Europe/London")
  
  title_stub <-
    "Symptoms accross comorbidities in respondents with no covid\n"
  start_date_title <-
    format(as.Date(start_date), format = "%d %B %Y")
  end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
  chart_title <-
    paste0(title_stub, start_date_title, " to ", end_date_title)
  
  
  plot_comorb_cov_sympt <-
    ggplot2::ggplot(symptom_morbidities_no_cv,
                    ggplot2::aes(x = Morbidities, Count, fill = Symptom)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::scale_x_discrete(limits = unique(symptom_morbidities_no_cv$Morbidities)) +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::guides(fill = ggplot2::guide_legend(nrow = 3)) +
    ggplot2::theme_minimal() +
    ggplot2::labs(
      title = chart_title,
      subtitle = "Counts of patients with comorbidities accross symptoms",
      y = "Counts",
      x = "Symptoms",
      caption = "Source: Dataset - Your.md Dataset"
    ) +
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
  
  if (plot_chart == TRUE) {
    
    plot_comorb_cov_sympt
    
  } else{
    symptom_morbidities_no_cv
    
  }
  
  
  
}