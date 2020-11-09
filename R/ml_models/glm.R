library(conflicted)
library(tidymodels)
library(ggrepel)
library(corrplot)
library(tidymodels)
library(dplyr)
library(corrr) 
library(themis)
library(rsample)
library(caret)

### ML for Mixed - categorical and numerica data ####

data_categ_four_countries <- read.csv("/Users/gabrielburcea/Rprojects/data/data_categ_four_countries.csv", header = TRUE, sep = ",")

###########################################################################################
### Transforming variables in factor format ###############################################
data_categ_four_countries$gender <- as.factor(data_categ_four_countries$gender)
data_categ_four_countries$country <- as.factor(data_categ_four_countries$country)
data_categ_four_countries$chills <- as.factor(data_categ_four_countries$chills)
data_categ_four_countries$cough  <- as.factor(data_categ_four_countries$cough)
data_categ_four_countries$diarrhoea  <- as.factor(data_categ_four_countries$diarrhoea)
data_categ_four_countries$fatigue  <- as.factor(data_categ_four_countries$fatigue)
data_categ_four_countries$headache   <- as.factor(data_categ_four_countries$headache)
data_categ_four_countries$loss_smell_taste   <- as.factor(data_categ_four_countries$loss_smell_taste)
data_categ_four_countries$muscle_ache  <- as.factor(data_categ_four_countries$muscle_ache)
data_categ_four_countries$nasal_congestion <- as.factor(data_categ_four_countries$nasal_congestion)
data_categ_four_countries$nausea_vomiting  <- as.factor(data_categ_four_countries$nausea_vomiting)
data_categ_four_countries$self_diagnosis <- as.factor(data_categ_four_countries$self_diagnosis)
data_categ_four_countries$shortness_breath <- as.factor(data_categ_four_countries$shortness_breath)
data_categ_four_countries$sore_throat <- as.factor(data_categ_four_countries$sore_throat)
data_categ_four_countries$sputum <- as.factor(data_categ_four_countries$sputum)
data_categ_four_countries$temperature  <- as.factor(data_categ_four_countries$temperature)
data_categ_four_countries$health_care_worker <- as.factor(data_categ_four_countries$health_care_worker)
data_categ_four_countries$care_home_worker <- as.factor(data_categ_four_countries$care_home_worker)
### Transforming variables in numerical format  #########################################################
data_categ_four_countries$asthma   <- as.numeric(data_categ_four_countries$asthma)
data_categ_four_countries$diabetes_type_two <- as.numeric(data_categ_four_countries$diabetes_type_two)
data_categ_four_countries$obesity <- as.numeric(data_categ_four_countries$obesity)
data_categ_four_countries$hypertension  <- as.numeric(data_categ_four_countries$hypertension)
data_categ_four_countries$heart_disease  <- as.numeric(data_categ_four_countries$heart_disease)
data_categ_four_countries$kidney_disease <- as.numeric(data_categ_four_countries$kidney_disease)
data_categ_four_countries$lung_condition <- as.numeric(data_categ_four_countries$lung_condition)
data_categ_four_countries$liver_disease <- as.numeric(data_categ_four_countries$liver_disease)
data_categ_four_countries$diabetes_type_one <- as.numeric(data_categ_four_countries$diabetes_type_one)
data_categ_four_countries$how_unwell <- as.numeric(data_categ_four_countries$how_unwell)
data_categ_four_countries$no_days_symptoms <- as.numeric(data_categ_four_countries$no_days_symptoms)
data_categ_four_countries$age <- as.numeric(data_categ_four_countries$age)
data_categ_four_countries$covid_tested <- as.factor(data_categ_four_countries$covid_tested)
#########################################################################################################
data_categ_four_countries <- as.data.frame(data_categ_four_countries)




#write.csv(data_categ_four_countries, file = "/Users/gabrielburcea/Rprojects/data/data_categ_four_countries.csv", row.names = FALSE)

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(nausea_vomiting != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(sputum != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(chills != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(cough != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(fatigue != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(headache != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(loss_smell_taste != "No")


data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(muscle_ache != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(nasal_congestion != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(nausea_vomiting != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(self_diagnosis != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(shortness_breath != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(sore_throat != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(temperature != "No")

data_categorical_four_countries <- data_categ_four_countries %>%
  dplyr::filter(temperature != "38.2-39")

data_categorical_four_countries <- data_categ_four_countries %>%
  drop_na()

###Set seed #####
set.seed(22)
##################
split1 <- createDataPartition(data_categorical_four_countries$covid_tested, p = 0.8, list = FALSE)
training_data_categorical_four_coutries <- data_categorical_four_countries[split1,]
testing_data_categ_four_countries <- data_categorical_four_countries[-split1,]



glmnGrid <- expand.grid(alpha = 0:1, 
                        .lambda = seq(0.0001, 1, length = 100))

smotest <- list(name = "SMOTE with more neighbors!",
                func = function (x, y) {
                  115
                  library(DMwR)
                  dat <- if (is.data.frame(x)) x else as.data.frame(x)
                  dat$.y <- y
                  dat <- SMOTE(.y ~ ., data = dat, k = 3, perc.over = 100, perc.under =
                                 200)
                  list(x = dat[, !grepl(".y", colnames(dat), fixed = TRUE)],
                       y = dat$.y) },
                first = TRUE)

ctrlInside <- trainControl(method = "repeatedcv", 
                           number = 10,
                           repeats = 5,
                           summaryFunction = twoClassSummary,
                           classProbs = TRUE,
                           savePredictions = TRUE, 
                           search = "grid",
                           sampling = smotest)

glm_model <- train(covid_tested ~.,
                   data = training_data_categorical_four_coutries,
                   #tuneGrid = glmnGrid,
                   method = "glmnet",
                   #preProc = c("center", "scale"),
                   metric = "ROC",
                   family = "binomial",
                   trControl = ctrlInside)

glm_model

evalResults <- predict(glm_model, testing_data_four_countries, type = "prob")[,1]
predict_glm <- ifelse(evalResults < 0.5,  "positive", "negative")


glm_pred <- caret::confusionMatrix(evalResults, testing_data_four_countries$covid_tested, positive = "positive")


glm_pred
library(pROC)
library(caret)

glm_roc <- pROC::roc(evalResults$covid_tested, testing_data_four_countries)
