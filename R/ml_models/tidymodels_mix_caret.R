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



library(caret)
library(rms)

newRF <- caretFuncs
fiveStats <- function(...) c(twoClassSummary(...),
                             defaultSummary(...)) 
newRF$summary <- fiveStats
ctrl <- rfeControl(method = "repeatedcv", repeats = 3,
                   verbose = TRUE, functions = newRF)


ctrlInside1 <- trainControl(method = "repeatedcv", number = 2,
                            repeats = 2,
                            classProbs = TRUE, 
                            allowParallel = TRUE, 
                            summaryFunction = fiveStats, 
                            verboseIter = TRUE, 
                            sampling = smotest)

#data frame for collect model's performance 
table_perf = data.frame(model=character(0),
                        auc=numeric(0), 
                        accuracy=numeric(0), 
                        sensitivity=numeric(0), 
                        specificity=numeric(0), 
                        kappa=numeric(0), 
                        stringsAsFactors = FALSE)



### Only numerical 
rcsFit <- lrm(Covid_tested ~ Age, data = data_final_numeric)
rcsFit


#### Dummy dataset '####

data_categorical_country <- data_categorical %>%
  dplyr::filter(country == "India" | country == "United Kingdom" | country == "Philipines" | country == "Pakistan" | country== "Nigeria")

as.data.frame(table(data_CA))