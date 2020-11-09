
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


# mtryValues = c(1,3,5,7,9)
# 
# tunegrid <- expand.grid(.mtry = c(1:10))
table(complete.cases(testing_data))

testing_data <- testing_data %>% na.omit()


rf_tuned <- caret::train(Covid_tested ~., 
                         data = training_data, 
                         method = "rf",
                         trControl = ctrlInside,
                         # ntree = 1500, 
                         #tuneGrid = data.frame(.mtry = mtryValues),
                         #tuneLength = 5, 
                         metric = "ROC", 
                         na.action = na.exclude)

rf_tuned

evalResult.rf <- predict(rf_tuned, testing_data, type = "prob")
predict_rf <- as.factor(ifelse(evalResult.rf >= 0.5, "positive", "negative")) 

cm_rf_forest <- confusionMatrix(predict_rf, testing_data$Covid_tested, "positive") 
