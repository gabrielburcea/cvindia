###############################################
###########Indian Dataset and ML ##############


data_india <- data_rec %>%
  dplyr::filter(country == "India")

data_india$country <- NULL

data_india$covid_tested <- as.factor(data_india$covid_tested)
########## Dividing Data into training and testing #########################################
###Set seed #####
set.seed(22)
##################
split1 <- createDataPartition(data_india$covid_tested, p = .70)[[1]]
training_data_india <- data_india[split1,]
testing_data_india <- data_india[-split1,]

prop.table(table(training_data_india$covid_tested))

library(DMwR)
smote_train_india <- SMOTE(covid_tested ~., data = training_data_india, perc.over = 100, perc.under = 200)
table(smote_train_india$covid_tested)
smote_train_india$country <- NULL


preProcValues <- preProcess(smote_train_india[, -30],
                            method = c("center", "scale", "YeoJohnson", "nzv"))

transformed_india <- predict(preProcValues, newdata = training_data_india)


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


#data_india$covid_tested <- as.factor(data_india$covid_tested)
########## Dividing Data into training and testing #########################################
###Set seed #####

##################
split1 <- createDataPartition(data_four_countries$covid_tested, p = 0.8, list = FALSE)
training_data_four_countries <- data_four_countries[split1,]
testing_data_four_countries <- data_four_countries[-split1,]

library(MASS)
set.seed(22)
model <- glm(covid_tested ~., data = training_data_four_countries, family = binomial) %>%
  stepAIC(trace = FALSE)

full_model <- glm(covid_tested ~., data = training_data_four_countries, family = binomial)
coef(full_model)

step_model <- full_model %>% stepAIC(trace = FALSE)
coef(step_model)


### Compare the full and the stepwise models 

# Make predictions ###

probalities <- full_model %>% predict(testing_data_four_countries, type = "response", se.fit = FALSE)
predicted.classes <- ifelse(probabilities  > 0.5, "pos", "neg")

observed_classes <- testing_data_four_countries$covid_tested
mean(predicted.classes == observed_classes)

table_perf = data.frame(model=character(0),
                        auc=numeric(0),
                        accuracy=numeric(0),
                        sensitivity=numeric(0),
                        specificity=numeric(0),
                        kappa=numeric(0),
                        stringsAsFactors = FALSE)




ctrl <- trainControl(method = "repeatedcv",
                     number = 10,
                     repeats = 5,
                     classProbs = TRUE, 
                     summaryFunction = fiveStats, 
                     verboseIter = TRUE, 
                     allowParallel = TRUE)




mtryValues = c(1,3,5,7,9)

tunegrid <- expand.grid(.mtry = c(1:10))




rf_india_tuned <- caret::train(covid_tested ~., 
                               data = transformed_india, 
                               method = "rf",
                               trControl = ctrl,
                               ntree = 1500, 
                               tuneGrid = data.frame(.mtry = mtryValues),
                               tuneLength = 5, 
                               metric = "ROC", 
                               na.action = na.exclude)

rf_india_tuned



eval_results_india <- predict(rf_india_tuned, testing_data_india, type = "prob")[,1]

predict_rf_india <- ifelse(eval_results_india<0.5, "positive", "negative")

cm_rf_india <- confusionMatrix(predict_rf_india, testing_data_india$covid_tested)


############### GLM and Step wise selection

data_four_countries <- data_categ_fin %>%
  dplyr::filter(country == "India" | country == "United Kingdom" | country == "Phillipines" | country == "Pakistan") %>%
  dplyr::filter(chills != "Chills" | temperature != "38.2-39")

