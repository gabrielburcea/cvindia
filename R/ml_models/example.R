library(tidyverse)
library(AppliedPredictiveModeling)
library(caret)
library(stargazer)

cleaned_data_22092020 <- read.csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")


cleaned_data_22092020 <- cleaned_data_22092020 %>%
  dplyr::filter(country == "Brazil" | country == "India" | country == "Pakistan" | country == "United Kingdom" | country == "Mexico")


stargazer(cleaned_data_22092020, type = "text", title = "Descriptive statistics", digits = 1)

cleaned_data_22092020$covid_tested <- as.factor(cleaned_data_22092020$covid_tested)
cleaned_data_22092020$id <- NULL
cleaned_data_22092020$sneezing <- NULL

cleaned_data_22092020 <- as.data.frame(cleaned_data_22092020)
class = sapply(cleaned_data_22092020, class)
table(class)

cleaned_data_22092020$country <- as.factor(cleaned_data_22092020$country)
cleaned_data_22092020$age <- as.numeric(cleaned_data_22092020$age)
cleaned_data_22092020$gender <- as.factor(cleaned_data_22092020$gender)
cleaned_data_22092020$number_days_symptom_showing <- as.numeric(cleaned_data_22092020$number_days_symptom_showing)

cleaned_data_22092020$how_unwell <- as.numeric(cleaned_data_22092020$how_unwell)

cleaned_data_22092020$diabetes_type_one <- as.factor(cleaned_data_22092020$diabetes_type_one)

cleaned_data_22092020$diabetes_type_two <- as.factor(cleaned_data_22092020$diabetes_type_two)

cleaned_data_22092020$liver_disease <- as.factor(cleaned_data_22092020$liver_disease)


cleaned_data_22092020$lung_condition <- as.factor(cleaned_data_22092020$lung_condition)


cleaned_data_22092020$kidney_disease <- as.factor(cleaned_data_22092020$kidney_disease)

cleaned_data_22092020$heart_disease <- as.factor(cleaned_data_22092020$heart_disease)


cleaned_data_22092020$hypertension <- as.factor(cleaned_data_22092020$hypertension)


cleaned_data_22092020$obesity <- as.factor(cleaned_data_22092020$obesity)


cleaned_data_22092020$asthma <- as.factor(cleaned_data_22092020$asthma)


cleaned_data_22092020$temperature <- as.factor(cleaned_data_22092020$temperature)

cleaned_data_22092020$sputum <- as.factor(cleaned_data_22092020$sputum)

cleaned_data_22092020$sore_throat <- as.factor(cleaned_data_22092020$sore_throat)

cleaned_data_22092020$self_diagnosis <- as.factor(cleaned_data_22092020$self_diagnosis)

cleaned_data_22092020$nausea_vomiting <- as.factor(cleaned_data_22092020$nausea_vomiting)

cleaned_data_22092020$nasal_congestion <- as.factor(cleaned_data_22092020$nasal_congestion)

cleaned_data_22092020$muscle_ache <- as.factor(cleaned_data_22092020$muscle_ache)

cleaned_data_22092020$loss_smell_taste <- as.factor(cleaned_data_22092020$loss_smell_taste)

cleaned_data_22092020$headache <- as.factor(cleaned_data_22092020$headache)

cleaned_data_22092020$fatigue <- as.factor(cleaned_data_22092020$fatigue)

cleaned_data_22092020$diarrhoea <- as.factor(cleaned_data_22092020$diarrhoea)

cleaned_data_22092020$cough <- as.factor(cleaned_data_22092020$cough)

cleaned_data_22092020$chills <- as.factor(cleaned_data_22092020$chills)

cleaned_data_22092020$health_care_worker <- as.factor(cleaned_data_22092020$health_care_worker)

cleaned_data_22092020$shortness_breath <- as.factor(cleaned_data_22092020$shortness_breath)

cleaned_data_22092020$sputum <- as.factor(cleaned_data_22092020$sputum)

cleaned_data_22092020$pregnant <- as.factor(cleaned_data_22092020$pregnant)

cleaned_data_22092020$loss_appetite <- as.factor(cleaned_data_22092020$loss_appetite)

cleaned_data_22092020$chest_pain <- as.factor(cleaned_data_22092020$chest_pain)

cleaned_data_22092020$itchy_eyes <- as.factor(cleaned_data_22092020$itchy_eyes)

cleaned_data_22092020$joint_pain <- as.factor(cleaned_data_22092020$joint_pain)

cleaned_data_22092020$care_home_worker <- as.factor(cleaned_data_22092020$care_home_worker)

covid_tested_levels <- c(
  "positive" = "showing symptoms"
)

cleaned_data_22092020 <- cleaned_data_22092020 %>%
  dplyr::mutate(covid_tested = forcats::fct_recode(covid_tested, !!!covid_tested_levels))

cleaned_data_22092020$country <- NULL
cleaned_data_22092020$location <- NULL
cleaned_data_22092020$date_completed <- NULL
cleaned_data_22092020$Country <- NULL
cleaned_data_22092020$loss_of_smell_and_taste <- NULL
cleaned_data_22092020$language <- NULL
cleaned_data_22092020$age_band <- NULL
cleaned_data_22092020$fatigue <- NULL


library(caret)

set.seed(22)

split1 <- createDataPartition(cleaned_data_22092020$covid_tested, p = .50)[[1]]
training <- cleaned_data_22092020[split1,]
testing <- cleaned_data_22092020[-split1,]

prop.table(table(training$covid_tested))


train <- head(training, 100)

library(DMwR)

smote_train <- SMOTE(covid_tested ~., data = training, perc.over = 100, perc.under = 200)

table(smote_train$covid_tested)


preProcValues <- preProcess(smote_train[, -35], 
                            method = c("center", "scale", "YeoJohnson", "nzv"))

transformed <- predict(preProcValues, newdata = training)

transformed <- transformed %>%
  tidyr::drop_na()


# Obtain different perfomances measures, two wrapper functions
# For Accuracy, Kappa, the area under the ROC curve, 
# sensitivity and specificity
fiveStats <- function (...)c(twoClassSummary(...),
                             defaultSummary(...))

# Everything but the area under the ROC curv
fourStats <- function(data, lev=levels(data$obs), model =NULL)
{
  
  accKapp <- postResample(data[, "pred"], data[, "obs"])
  out<- c(accKapp,
          sensitivity(data[,"pred"], data[,"obs"], lev[1]),
          specificity(data[,"pred"], data[,"obs"], lev[2]))
  names(out)[3:4] <- c("Sens", "Spec")
  out
}


table_perf = data.frame(model=character(0),
                        auc=numeric(0),
                        accuracy=numeric(0),
                        sensitivity=numeric(0),
                        specificity=numeric(0),
                        kappa=numeric(0),
                        stringsAsFactors = FALSE)


ctrl <- trainControl(method = "cv", 
                     number = 10, 
                     repeats = 5,
                     classProbs = TRUE,
                     summaryFunction = fiveStats,
                     verboseIter = TRUE,
                     allowParallel = TRUE)

set.seed(22)

rf.Fit <-train(covid_tested ~., data=transformed,
               method = "rf",
               trControl =ctrl,
               ntree = 1500,
               tuneLength= 5,
               metric="ROC")


eval_results <- predict(rf.Fit,  testing, type = "prob")

predict_rf<- ifelse(eval_results < 0.5, "positive", "negative")
cm_rf <- confusionMatrix(predict_rf, testing$covid_tested, "positive")




# IF get an error like this Error: `data` and `reference` should be factors with the same levels.then check the sources of
# of error 

head(eval_results)

colnames(eval_results)[max.col(eval_results)]
evalResult.rf <- predict(rf.Fit, testing, type = "prob")
predict_rf <- factor(colnames(evalResult.rf)[max.col(evalResult.rf)])

plot(rf.Fit)

cm_rf_forest <- confusionMatrix(predict_rf, testing$covid_tested, "positive")

cm_rf_forest


var_imp_rf <- varImp(rf.Fit)

plot(var_imp_rf)





