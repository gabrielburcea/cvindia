#' comorbidiites_age_band_table
#'
#' @param data 
#'
#' @return
#' @export
#'
#' @examples
comorbidities_age_band_table <- function(data) {
  
  comborbidities_age_band <- phillipines_data %>%
    dplyr::select(id, covid_tested, age_band, asthma, diabetes_type_one, diabetes_type_two, obesity, hypertension, heart_disease, lung_condition, 
                  liver_disease, kidney_disease) %>%
    tidyr::drop_na()
  
  
  # gather_divided <-  comborbidities_age_band  %>%
  #   tidyr::pivot_longer(cols= 4:12, names_to="comorbidities", values_to="yes_no") %>%
  #   dplyr::group_by(age_band, covid_tested, comorbidities, yes_no) %>%
  #   dplyr::summarise(count=n()) %>%
  #   dplyr::mutate(perc =  count/sum(count) *100) %>%
  #   dplyr::filter(yes_no !="No" & age_band != "0-19" & covid_tested != "negative") 
  # 
  # gather_divided$yes_no <- NULL
  # 
  # 
  # gather_divided$comorbidities <- as.factor(gather_divided$comorbidities)
  # gather_divided$age_band <- as.factor(gather_divided$age_band)
  # gather_divided$perc <- round(gather_divided$perc, digits = 1)
  # 
  # gather_divided

  

  }
  


