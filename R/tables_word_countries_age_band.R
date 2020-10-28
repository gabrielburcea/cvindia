# library(tidyverse)
# library(tables)
# 
# # Reading data - Philippines
# phillipines_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/phillipines_data.csv")
# 
# # Symptoms, age bands, covid status
# sympt_pos_age_band_n <- cvindia::sympt_positive_age_band_table(data = phillipines_data)
# sympt_pos_age_band_n
# 
# # put them in a nice table
# tables::tabular((Symptoms = factor(symptoms)+1)*(total = sum)*(count+perc)~(age_band=factor(age_band))*("SARS-Covid-19 status"=factor(covid_tested)), data=sympt_pos_age_band_n)
# 
# # Coorbidities, age bands and covid status
# comorb_age_band_numbers <- cvindia::comorbidities_age_band_table(data = phillipines_data)
# comorb_age_band_numbers
# 
# #put them in a nice table
# tables::tabular((Comorbidities = factor(comorbidities)+1)*(total = sum)*(count+perc)~('Age Band' =factor(age_band))*("SARS-Covid-19 status" =factor(covid_tested)), data=comorb_age_band_numbers)
# 
# 
# # Reading data - United Kingdoms
# uk_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/uk_data_22092020.csv")
# 
# # Symptoms, age bands, covid status
# sympt_pos_age_band_n <- cvindia::sympt_positive_age_band_table(data = uk_data)
# sympt_pos_age_band_n
# 
# # put them in a nice table
# tables::tabular((Symptoms = factor(symptoms)+1)*(total = sum)*(count+perc)~(age_band=factor(age_band))*("SARS-Covid-19 status"=factor(covid_tested)), data=sympt_pos_age_band_n)
# 
# # Coorbidities, age bands and covid status
# comorb_age_band_numbers <- cvindia::comorbidities_age_band_table(data = uk_data)
# comorb_age_band_numbers
# 
# #put them in a nice table
# tables::tabular((Comorbidities = factor(comorbidities)+1)*(total = sum)*(count+perc)~('Age Band' =factor(age_band))*("SARS-Covid-19 status" =factor(covid_tested)), data=comorb_age_band_numbers)
# 
# 
# # Reading data - Pakistan
# pakistan_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/pakistan_data_22092020.csv")
# 
# # Symptoms, age bands, covid status
# sympt_pos_age_band_n <- cvindia::sympt_positive_age_band_table(data = pakistan_data)
# sympt_pos_age_band_n
# 
# # put them in a nice table
# tables::tabular((Symptoms = factor(symptoms)+1)*(total = sum)*(count+perc)~(age_band=factor(age_band))*("SARS-Covid-19 status"=factor(covid_tested)), data=sympt_pos_age_band_n)
# 
# # Coorbidities, age bands and covid status
# comorb_age_band_numbers <- cvindia::comorbidities_age_band_table(data = pakistan_data)
# comorb_age_band_numbers
# 
# #put them in a nice table
# tables::tabular((Comorbidities = factor(comorbidities)+1)*(total = sum)*(count+perc)~('Age Band' =factor(age_band))*("SARS-Covid-19 status" =factor(covid_tested)), data=comorb_age_band_numbers)
# 
# # Reading data - Mexico
# mexico_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/mexico_data_22092020.csv")
# 
# # Symptoms, age bands, covid status
# sympt_pos_age_band_n <- cvindia::sympt_positive_age_band_table(data = mexico_data)
# sympt_pos_age_band_n
# 
# # put them in a nice table
# tables::tabular((Symptoms = factor(symptoms)+1)*(total = sum)*(count+perc)~(age_band=factor(age_band))*("SARS-Covid-19 status"=factor(covid_tested)), data=sympt_pos_age_band_n)
# 
# # Coorbidities, age bands and covid status
# comorb_age_band_numbers <- cvindia::comorbidities_age_band_table(data = mexico_data)
# comorb_age_band_numbers
# 
# #put them in a nice table
# tables::tabular((Comorbidities = factor(comorbidities)+1)*(total = sum)*(count+perc)~('Age Band' =factor(age_band))*("SARS-Covid-19 status" =factor(covid_tested)), data=comorb_age_band_numbers)
# 
# 
# # Reading data - Indian data
# indian_data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/indian_data_22092020.csv")
# 
# # Symptoms, age bands, covid status
# sympt_pos_age_band_n <- cvindia::sympt_positive_age_band_table(data = indian_data)
# sympt_pos_age_band_n
# 
# # put them in a nice table
# tables::tabular((Symptoms = factor(symptoms)+1)*(total = sum)*(count+perc)~(age_band=factor(age_band))*("SARS-Covid-19 status"=factor(covid_tested)), data=sympt_pos_age_band_n)
# 
# # Coorbidities, age bands and covid status
# comorb_age_band_numbers <- cvindia::comorbidities_age_band_table(data = indian_data)
# comorb_age_band_numbers
# 
# #put them in a nice table
# tables::tabular((Comorbidities = factor(comorbidities)+1)*(total = sum)*(count+perc)~('Age Band' =factor(age_band))*("SARS-Covid-19 status" =factor(covid_tested)), data=comorb_age_band_numbers)
# 
# 
