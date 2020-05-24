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


conflict_prefer("filter", "dplyr")

ggplot2::theme_set(theme_light())



###################################
#######Corelations ################

correlation_num_dt <- data_final_numeric %>%
  dplyr::select_if(is.numeric) %>%
  corrr::correlate(x = .,
                   method = "spearman", 
                   quiet = TRUE) %>%
  corrr::rearrange(x =., 
                   method = "MDS", 
                   absolute = FALSE)

correlation_num_dt

rplot_labs_v1 <- ggplot2::labs(
  title = "Correlations - symptoms and comorbidities", 
  subtitle = "Symptoms and Commorbidities", 
  caption = "Data accessed from Your.md")


#As we can see, the hue of the color and the size of the point indicate the level of the correlation

correlated_vars_plot <- correlation_num_dt %>%
  corrr::rplot(rdf = ., shape = 19, 
               colors = c("yellow", 
                          "purple")) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  rplot_labs_v1

correlated_vars_plot

# Removing the redundant correlations from the table - not 

removed_correlated_vars <- correlation_num_dt %>% corrr::shave(x =.)

removed_correlated_vars %>%
  corrr::rplot(rdf = ., shape = 19, 
               colors = c("yellow", 
                          "purple")) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  rplot_labs_v1

removed_correlated_vars

data_final_numeric %>% distinct(Country)

data_country_selected <- data_final_numeric %>%
  dplyr::filter(Country == "India" | Country == "United Kingdom" | Country == "Phillipines" | Country == "Pakistan" | Country == "Bangladesh")

data_country_selected %>% distinct(Country)

################
set.seed(22)
#### Get only five countries##### 


rec_1 <- recipe(Covid_tested ~., data = data_country_selected)

dummies <- rec_1 %>% 
  step_dummy(Country)



dummies <- prep(dummies, training = data_country_selected)

dummy_data_train <- bake(dummies, new_data = data_country_selected)

sort(table(dummy_data_train$Covid_tested, useNA = "always"))

dt_num_split <- initial_split(data = dummy_data_train, prop = .1, strata = Covid_tested)

dt_train <- training(dt_num_split)
dt_test <- testing(dt_num_split)


####Smote - balancing classes only in dia_train ####

# Get the counts of posivite and negative in the class as we can see we have only 54 posivite and 3945 negatives 

dt_train$ID <- NULL


imbal_rec <- recipe(Covid_tested ~., data = dt_train) %>%
  step_smote(Covid_tested)


#### Basic cross-validation is used to resample the models

cv_folds <- vfold_cv(dummy_data_train, strata = "Covid_tested", repeats = 5)

logistic_glm <- logistic_reg(mode = "classification") %>%
  set_engine("glm") %>%
  fit(Covid_tested ~., data = dummy_data_train)

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

  mod_fit <- rms::lrm(Covid_tested ~ ., data =  mod_data)
  
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



##### I am using smote function ###
# library(DMwR)
# dia_train <- as.data.frame(dia_train)
# 
# dia_train$ID <- NULL
# dia_train$Country <- as.factor(dia_train$Country)
# dia_train$Covid_tested <- as.factor(dia_train$Covid_tested)
# 
# table(dia_train$Covid_tested)
# 
# smote_train <- SMOTE(Covid_tested ~., data = dia_train, perc.over = 100, perc.under = 200)

