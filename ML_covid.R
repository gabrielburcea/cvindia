#### Loading libraries needed 
library(caret)
library(corrplot)
library(tidyverse)
library(e1071)
library(DMwR)
library(lattice)
library(pROC)
library(ROCR)
library(ggplot2)
library(reshape2)
library(leaps)
library(MASS)
library(rms)

data <- PivotMappe060520r


data_select <- data %>%
  dplyr::rename(tested_or_not = 'Reason For Helping') %>%
  tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four',
                                          'Comorbidity_five', 'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 
                                          'Comorbidity_nine'), sep = ",")

level_key <-
  c(
    None = 'negative',
    Curious = "negative",
    'Showing Symptoms But Not Tested,Curious' = "negative",
    'Showing Symptoms But Not Tested' = "negative",
    'Self-Isolating With No Symptoms' = "negative",
    'Showing Symptoms But Not Tested,Curious,Self-Isolating With No Symptoms' = "negative",
    'Tested Positive' = 'positive',
    'Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms' = 'negative',
    'Recovered But Have New Symptoms' = 'positive',
    'Live With Someone With Coronavirus' = 'positive',
    'Live With Someone With Coronavirus,Curious' = 'negative',
    'Tested Negative But Have Symptoms,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms,Curious' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'positive',
    'Tested Positive,Self-Isolating With No Symptoms' = 'positive',
    'Showing Symptoms But Not Tested,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested' = 'negative',
    'Showing Symptoms But Not Tested,Recovered But Have New Symptoms' = 'negative',
    'Tested Positive,Curious' = 'positive',
    'Tested Positive,Showing Symptoms But Not Tested' = 'positive',
    'Tested Positive,Live With Someone With Coronavirus' = 'positive',
    'Recovered But Have New Symptoms,Curious' = 'negative',
    'Live With Someone With Coronavirus,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Recovered But Have New Symptoms' = 'positive',
    'Live With Someone With Coronavirus,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious' = 'negative',
    'Recovered But Have New Symptoms,Self-Isolating With No Symptoms' = 'negative',
    'Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Positive,Tested Negative But Have Symptoms,Recovered But Have New Symptoms' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Live With Someone With Coronavirus,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious' = 'positive',
    'Tested Positive,Tested Negative But Have Symptoms' = 'positive',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Recovered But Have New Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Showing Symptoms But Not Tested,Live With Someone With Coronavirus' = 'negative',
    'Tested Positive,Recovered But Have New Symptoms,Curious' = 'positive',
    'Tested Negative But Have Symptoms,Curious,Self-Isolating With No Symptoms' = 'negative',
    'Tested Negative But Have Symptoms,Showing Symptoms But Not Tested,Curious'  = 'negative'
  )

data_select$tested_or_not <- as.factor(data_select$tested_or_not)
data_select <- as.data.frame(data_select)

data_rec <- data_select %>% 
  dplyr::mutate(Covid_tested = dplyr::recode(tested_or_not, !!!level_key))

data_model <- data_rec  %>%
  tidyr::pivot_longer(cols = starts_with('Comorbidity'), 
                      names_to = 'Comorbidity_count', 
                      values_to = 'Comorbidity') %>%
  tidyr::drop_na('Comorbidity') %>%
  dplyr::select(-Comorbidity_count) %>%
  dplyr::distinct() %>%
  dplyr::mutate(Condition = 2) %>%
  tidyr::pivot_wider(id_cols = -c(Comorbidity, Condition), names_from = Comorbidity, values_from = Condition, values_fill = list(Condition = 1)) %>%
  dplyr::select(-None)

data_final <- data_model %>%
  dplyr::select(ID, Age, Gender, Country, 'Care Home Worker', Chills, Cough, Diarrhoea, Fatigue, Headcahe, 'Healthcare Worker', 'How Unwell',
              'Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting', 
              'Number Of Days Symptoms Showing', 'Self Diagnosis','Shortness of Breath',
              'Sore Throat','Sputum', 'Temperature', 'Asthma (managed with an inhaler)', 'Diabetes Type 1 (controlled by insulin)', 
              'Diabetes Type 2', Obesity, 'High Blood Pressure (hypertension)', 
              'Long-Standing Heart Disease', 'Long-Standing Kidney Disease', 'Long-Standing Liver Disease', Covid_tested)
  

### Dividing data into train and test
#data_model <- read_csv("/Users/gabrielburcea/Rprojects/data/data_model.csv")

#data_model <- as.data.frame(data_model)
data_final$Covid_tested <- as.factor(data_final$Covid_tested)



train <- createDataPartition(data_final$Covid_tested, p = 0.5, list = FALSE)
dataTrain <- data_model[train,]
dataTest <- data_model[-train,]

dataTrain$ID <- NULL
# classes_count <- dataTrain %>% 
#   dplyr::group_by(tested_covid) %>%
#   tally()


prop.table(table(dataTrain$Covid_tested))

set.seed(22)

smote_train <- SMOTE(Covid_tested ~., data = dataTrain, perc.over = 10, perc.under = 20)


fiveStats <- function(...) c(twoClassSummary(...), defaultSummary(...))


ctrl <- trainControl(method = "repeatedcv",
                     number = 10, 
                     repeats = 5,
                     classProbs = TRUE,
                     allowParallel = TRUE, 
                     summaryFunction = fiveStats,
                     verboseIter = TRUE,
                     sampling = smotest)


lrFull <- train(data_100,
                y = data_100$tested_covid, 
                method = "glm", 
                metric = "ROC", 
                trControl = ctrl)

