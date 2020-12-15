
library(tidyverse)
library(AppliedPredictiveModeling)
library(caret)
library(stargazer)
stargazer(data_categorical, type = "text", title = "Descriptive statistics", digits = 1)

data_categorical$Covid_tested <- as.factor(data_categorical$Covid_tested)
data_categorical$ID <- NULL
data_categorical <- as.data.frame(data_categorical)
class = sapply(data_categorical, class)
table(class)

data_categorical$country <- as.factor(data_categorical$country)
data_categorical$age <- as.numeric(data_categorical$age)
data_categorical$gender <- as.factor(data_categorical$gender)
data_categorical$no_days_symptoms <- as.numeric(data_categorical$no_days_symptoms)

data_categorical$how_unwell <- as.numeric(data_categorical$how_unwell)

data_categorical$diabetes_type_one <- as.numeric(data_categorical$diabetes_type_one)

data_categorical$diabetes_type_two <- as.numeric(data_categorical$diabetes_type_two)

data_categorical$liver_disease <- as.numeric(data_categorical$liver_disease)


data_categorical$lung_condition <- as.numeric(data_categorical$lung_condition)


data_categorical$kidney_disease <- as.numeric(data_categorical$kidney_disease)

data_categorical$heart_disease <- as.numeric(data_categorical$heart_disease)


data_categorical$hypertension <- as.numeric(data_categorical$hypertension)


data_categorical$obesity <- as.numeric(data_categorical$obesity)


data_categorical$asthma <- as.numeric(data_categorical$asthma)


data_categorical$temperature <- as.factor(data_categorical$temperature)

data_categorical$sputum <- as.factor(data_categorical$sputum)

data_categorical$sore_throat <- as.factor(data_categorical$sore_throat)

data_categorical$self_diagnosis <- as.factor(data_categorical$self_diagnosis)

data_categorical$nausea_vomiting <- as.factor(data_categorical$nausea_vomiting)

data_categorical$nasal_congestion <- as.factor(data_categorical$nasal_congestion)

data_categorical$muscle_ache <- as.factor(data_categorical$muscle_ache)

data_categorical$loss_smell_taste <- as.factor(data_categorical$loss_smell_taste)

data_categorical$headache <- as.factor(data_categorical$headache)

data_categorical$fatigue <- as.factor(data_categorical$fatigue)

data_categorical$diarrhoea <- as.factor(data_categorical$diarrhoea)

data_categorical$cough <- as.factor(data_categorical$cough)

data_categorical$chills <- as.factor(data_categorical$chills)

library(caret)

set.seed(22)

split1 <- createDataPartition(data_categorical$Covid_tested, p = .50)[[1]]
training <- data_categorical[split1,]
testing <- data_categorical[-split1,]

prop.table(table(training$Covid_tested))

library(DMwR)

smote_train <- SMOTE(Covid_tested ~., data = as.data.frame(training), perc.over = 100, perc.under = 200)

table(smote_train$Covid_tested)

smote_train$country <- NULL



preProcValues <- preProcess(smote_train[, -1], 
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

rf.Fit <-train(Covid_tested ~., data=transformed,
               method = "rf",
               trControl =ctrl,
               ntree = 1500,
               tuneLength= 5,
               metric="ROC")

