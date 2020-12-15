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


data_india <- data_final_numeric %>%
  dplyr::filter(Country == "India")

data_india$Covid_tested <- factor(data_india$Covid_tested)
conflict_prefer("filter", "dplyr", "base")

dt_num_split <- initial_split(data = data_india, prop = .1, strata = Covid_tested)

dt_train <- training(dt_num_split)
dt_test <- testing(dt_num_split)

####Smote - balancing classes only in dia_train ####
sort(table(dt_train$Covid_tested, useNA = "always"))
# Get the counts of posivite and negative in the class as we can see we have only 54 posivite and 3945 negatives 

dt_train$ID <- NULL
dt_train$Country <- NULL

imbal_rec <- recipe(Covid_tested ~., data = dt_train) %>%
  step_smote(Covid_tested)

#### Basic cross-validation is used to resample the models

cv_folds <- vfold_cv(dt_train, strata = "Covid_tested", repeats = 5)


#An additional column is added to the data that contains the trained recipes for each resample:

cv_folds <- cv_folds %>%
  mutate(recipes = map(splits, prepper, recipe = imbal_rec))

cv_folds$recipes[[1]]

library(rms)

assess_res <- function(split, rec = NULL, ...){
  
  if(!is.null(rec))
    mod_data <- juice(rec)
  
  else
    mod_data <- analysis(split)
  
  mod_fit <- logistic_reg(mode = "classification") %>%
    set_engine("glm") %>%
    fit(Covid_tested ~., data =  mod_data)
  
  if(!is.null(rec))
    eval_data <- bake(rec, assessment(split))
  
  else
    eval_data <- assessment(split)
  
  eval_data <- eval_data 
  
  predictions <- predict(mod_fit, eval_data)
  
  eval_data %>%
    mutate(
      pred = predict$class,
      prob = predictions$posterior[,1]
    ) %>%
    dplyr::select(Class, pred, prob)
  
}

###No subsampling
assess_res(cv_folds$splits[[1]]) 


