library(stargazer)
stargazer(data_categorical, type = "text", title = "Descriptive statistics", digits = 1)


data_categorical$ID <- NULL

class = sapply(data_categorical, class)
table(class)

library(caret)

set.seed(22)

split1 <- createDataPartition(data_categorical$Covid_tested, p = .50)[[1]]
training <- data_categorical[split1,]
testing <- data_categorical[-split1,]

prop.table(table(training$Covid_tested))

library(DMwR)

smote_train <- SMOTE(Covid_tested ~., data = training, perc.over = 100, perc.under = 200)

table(smote_train$Covid_tested)

smote_train$country <- NULL



preProcValues <- preProcess(smote_train[, -1], 
                            method = c("center", "scale", "YeoJohnson", "nzv"))

transformed <- predict(preProcValues, newdata = training)

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
                     number = 2, 
                     repeats = 1,
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


