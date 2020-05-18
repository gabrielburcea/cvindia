data <- PivotMappe060520r

data$'Long Standing Health Issues' <- as.factor(data$'Long Standing Health Issues' )

library(tidyverse)

test_data <- data %>%
  tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four'), sep = ",") %>%
  tidyr::replace_na(list('Comorbidity_one' = 'None', 'Comorbidity_two' = 'None', 'Comorbidity_three' = 'None', 'Comorbidity_four' = 'None'))


sample <- data %>%
  head(16) %>%
  select('Long Standing Health Issues')
  




comorbidities <- c(" 'Asthma','Heart Disease', 'Lung issues", "None", "'Heart Disease', 'Lung issues' " )

my_data <- c(id, comorbidities)

test_data <- data %>%
  tidyr::separate('Long Standing Health Issues', c(Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four), sep = ",") %>%
  tidyr::replace_na(list(Comorbidity_one = None, Comorbidity_two = None, Comorbidity_three = None, Comorbidity_four = None)) %>%
  dplyr::filter(Comorbidity_one == 'Asthma (managed with an inhaler)')



asthma <- test_data %>%
  dplyr::filter(Comorbidity_one == 'Asthma (managed with an inhaler)' | Comorbidity_one == "None") 

high_blood_pressure <- test_data %>% 
  dplyr::filter(Comorbidity_one == 'High Blood Pressure (hypertension)' | Comorbidity_one == "None") 

obesity <- test_data %>%
  dplyr::filter(Comorbidity_three == 'Obesity' | Comorbidity_one == "None") 


  dplyr::filter(Comorbidity_four == 'Asthma (managed with an inhaler)' | Comorbidity_one == "None")


count_comorbidities_1 <- test_data %>%
  dplyr::select(ID, Comorbidity_one) %>%
  dplyr::group_by(Comorbidity_one) %>%
  dplyr::tally()


count_comorbidities_2 <- test_data %>%
  dplyr::select(ID, Comorbidity_two) %>%
  dplyr::group_by(Comorbidity_two) %>%
  dplyr::tally()


count_comorbidities_3 <- test_data %>%
  dplyr::select(ID, Comorbidity_three) %>%
  dplyr::group_by(Comorbidity_three) %>%
  dplyr::tally()

count_comorbidities_4 <- test_data %>%
  dplyr::select(ID, Comorbidity_four) %>%
  dplyr::group_by(Comorbidity_four) %>%
  dplyr::tally()
