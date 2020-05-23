### Dividing data into train and test
#data_final_numeric<- read_csv("/Users/gabrielburcea/Rprojects/data/data_final_numeric.csv")

str(data_final_numeric)
data_final_numeric<- as.data.frame(data_final_numeric)
data_final_numeric$Covid_tested <- as.factor(data_final_numeric$Covid_tested)



train <- createDataPartition(data_final_numeric$Covid_tested, p = 0.5, list = FALSE)
dataTrain <- data_model[train,]
dataTest <- data_model[-train,]

#dataTrain$ID <- NULL
# classes_count <- dataTrain %>% 
#   dplyr::group_by(tested_covid) %>%
#   tally()


prop.table(table(dataTrain$Covid_tested))

set.seed(22)

smote_train <- SMOTE(Covid_tested ~., data = as.data.frame(dataTrain), perc.over = 100, perc.under = 200)

prop.table(table(smote_train$Covid_tested))

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

