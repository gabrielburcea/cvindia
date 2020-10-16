#' plot_adjusted_sympt_covpos_rates
#'
#' @param data 
#' @param title 
#' @param plot_chart 
#'
#' @return
#' @export
#'
#' @examples
plot_adjusted_sympt_covpos_rates <- function(data, title = "Exampele", plot_chart = TRUE){
  
  
  adjusted_symptoms_rates_select <- adjusted_symptoms_covpos_rates %>%
    #dplyr::fil(age_recoded_band == "20-39") %>%
    dplyr::select(country, symptoms, standardised_existing_sympt_rate) 
  
  
  
  # pre_existing_levels <- c(
  # 
  #   "diabetes type two" = "diabetes_type_two", 
  #   "diabetes type one" = "diabetes_type_one", 
  #   "heart disease" = "heart_disease", 
  #   "lung condidition" = "lung_condition", 
  #   "liver disease" = "liver_disease",
  #   "kidney disease" = "kidney_disease"
  #   
  # )
  # 
  # 
  # adj_comorb_forcats <- adjusted_comorbididity_rates_select %>%
  #   dplyr::mutate("Pre-existing conditions" = forcats::fct_recode("Pre-existing conditions", !!!pre_existing_levels))
  
  cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#CC6600")

  plot_adjusted_rates <- ggplot2::ggplot(adjusted_symptoms_rates_select, 
                                         ggplot2::aes(x = symptoms, y = standardised_existing_sympt_rate, fill = country)) +
    ggplot2::coord_flip() +
    ggplot2::geom_bar(ggplot2::aes(fill = country), width = 0.4,
                      position = position_dodge(width = 0.5), stat = "identity", show.legend = TRUE) +
    # labels on the bar chart 
    #geom_text(aes(label = country), size = 3, hjust = -0.05, position = position_dodge2(width = 0.5)) + 
    ggplot2::scale_fill_manual(values = cbbPalette) + 
    ggplot2::labs(title = title,
                  subtitle = "\nNote: Adjusted rates for symptoms in responders tested covid positive  in %",
                  x = "Symptoms in covid positive", y = "Percentage", caption = "Source: Your.md Data") +
    ggplot2::theme(axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 21, b = 0, l = 0)),
                   plot.title = ggplot2::element_text(size = 12, face = "bold"),
                   plot.subtitle = ggplot2::element_text(size = 10), 
                   legend.position = "bottom" , legend.box = "horizontal") + 
  ggplot2::theme_bw()
  
  
  plot_adjusted_rates
  
}

