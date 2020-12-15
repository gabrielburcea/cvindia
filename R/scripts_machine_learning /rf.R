library(tidyverse)
library(conflicted)
library(tidymodels)
library(ggrepel)
library(corrplot)
library(dplyr)
library(corrr) 
library(themis)
library(rsample)
library(caret)
library(forcats)
library(rcompanion)
library(MASS)
library(pROC)
library(ROCR)
library(data.table)

data_categ_nosev <- read.csv("/Users/gabrielburcea/Rprojects/data/data_lev_categorical_no_sev.csv", header = TRUE, sep = ",")

conflict_prefer("step", "stats")
conflict_prefer("sensitivity", "caret")
### ML for Mixed - categorical and numerica data ####

###########################################################################################
### Transforming variables in factor format ###############################################
#data_categ_nosev$country <- as.factor(data_categ_nosev$country)
data_categ_nosev$chills <- as.factor(data_categ_nosev$chills)
data_categ_nosev$cough  <- as.factor(data_categ_nosev$cough)
data_categ_nosev$Gender <- as.factor(data_categ_nosev$Gender)
data_categ_nosev$Covid_tested <- as.factor(data_categ_nosev$Covid_tested)
data_categ_nosev$diarrhoea  <- as.factor(data_categ_nosev$diarrhoea)
data_categ_nosev$fatigue  <- as.factor(data_categ_nosev$fatigue)
data_categ_nosev$headache   <- as.factor(data_categ_nosev$headache)
data_categ_nosev$loss_smell_taste   <- as.factor(data_categ_nosev$loss_smell_taste)
data_categ_nosev$muscle_ache  <- as.factor(data_categ_nosev$muscle_ache)
data_categ_nosev$nasal_congestion <- as.factor(data_categ_nosev$nasal_congestion)
data_categ_nosev$nausea_vomiting  <- as.factor(data_categ_nosev$nausea_vomiting)
data_categ_nosev$self_diagnosis <- as.factor(data_categ_nosev$self_diagnosis)
data_categ_nosev$shortness_breath <- as.factor(data_categ_nosev$shortness_breath)
data_categ_nosev$sore_throat <- as.factor(data_categ_nosev$sore_throat)
data_categ_nosev$sputum <- as.factor(data_categ_nosev$sputum)
data_categ_nosev$temperature  <- as.factor(data_categ_nosev$temperature)
data_categ_nosev$health_care_worker <- as.factor(data_categ_nosev$health_care_worker)
data_categ_nosev$care_home_worker <- as.factor(data_categ_nosev$care_home_worker)
### Transforming variables in numerical format  #########################################################
data_categ_nosev$asthma   <- as.factor(data_categ_nosev$asthma)
data_categ_nosev$diabetes_type_two <- as.factor(data_categ_nosev$diabetes_type_two)
data_categ_nosev$obesity <- as.factor(data_categ_nosev$obesity)
data_categ_nosev$hypertension  <- as.factor(data_categ_nosev$hypertension)
data_categ_nosev$heart_disease  <- as.factor(data_categ_nosev$heart_disease)
data_categ_nosev$kidney_disease <- as.factor(data_categ_nosev$kidney_disease)
data_categ_nosev$lung_condition <- as.factor(data_categ_nosev$lung_condition)
data_categ_nosev$liver_disease <- as.factor(data_categ_nosev$liver_disease)
data_categ_nosev$diabetes_type_one <- as.factor(data_categ_nosev$diabetes_type_one)
data_categ_nosev$how_unwell <- as.numeric(data_categ_nosev$how_unwell)
data_categ_nosev$number_days_symptoms <- as.numeric(data_categ_nosev$number_days_symptoms)
data_categ_nosev$Age <- as.numeric(data_categ_nosev$Age)

data_categ_nosev$ID <- NULL
data_categ_nosev$Country <- NULL

########## Dividing Data into training and testing #########################################
###Set seed #####
set.seed(22)
##################



split1 <- createDataPartition(data_categ_nosev$Covid_tested, p = .80)[[1]]
training_data <- data_categ_nosev[split1,]
testing_data <- data_categ_nosev[-split1,]

prop.table(table(training_data$Covid_tested))

library(DMwR)
smote_train <- SMOTE(Covid_tested ~., data = training_data, perc.over = 100, perc.under = 200)
table(smote_train$Covid_tested)
smote_train$country <- NULL


preProcValues <- preProcess(smote_train[, -1],
                            method = c("center", "scale", "YeoJohnson", "nzv"))

transformed <- predict(preProcValues, newdata = training_data)


################################################################################

# Obtain different perfomances measures, two wrapper functions
# For Accuracy, Kappa, the area under the ROC curve, 
# sensitivity and specificity
library(caret)
library(pROC)

fiveStats <- function (...)c(twoClassSummary(...),
                             defaultSummary(...))

# Everything but the area under the ROC curv
fourStats <- function(data, lev=levels(data$obs), model =NULL){
  
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


ctrl <- trainControl(method = "repeatedcv",
                     number = 10,
                     repeats = 5,
                     classProbs = TRUE, 
                     summaryFunction = fiveStats, 
                     verboseIter = TRUE, 
                     allowParallel = TRUE)





rf <- caret::train(Covid_tested ~., 
                               data = training_data, 
                               method = "rf",
                               trControl = ctrlInside,
                              # ntree = 1500, 
                               #tuneGrid = data.frame(.mtry = mtryValues),
                               #tuneLength = 5, 
                               metric = "ROC", 
                               na.action = na.exclude)

rf

# testing_data <- as.data.frame(testing_data)
# testing_data$Covid_tested <- as.factor(testing_data$Covid_tested)
#evalResult <- data.frame(Covid_tested = testing_data$Covid_tested)

testing_data <- testing_data[complete.cases(testing_data),]

evalResult.rf <- predict(rf_tuned, testing_data, type = "prob")
predict_rf <- factor(colnames(evalResult.rf)[max.col(evalResult.rf)])
#predict_rf <- as.factor(ifelse(evalResult.rf >= 0.5, "positive", "negative")) 

cm_rf_forest <- confusionMatrix(predict_rf, testing_data$Covid_tested, "positive") 

cm_rf_forest


#### 

mtryValues = c(1,3,5,7,9)
tunegrid <- expand.grid(.mtry = c(1:10))



rf_tuned <- caret::train(Covid_tested ~., 
                         data = training_data, 
                         method = "rf",
                         trControl = ctrlInside,
                         ntree = 1500, 
                         tuneGrid = data.frame(.mtry = mtryValues),
                         tuneLength = 5, 
                         metric = "ROC", 
                         na.action = na.exclude)

rf_tuned








