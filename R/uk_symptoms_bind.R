# uk_chills <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "chills", table = TRUE)
# 
# uk_cough <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "cough", table = TRUE)
# 
# uk_diarrhoea <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "diarrhoea", table = TRUE)
# 
# #uk_fatigue <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "fatigue", table = TRUE)
# 
# uk_headache <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt ="headache" , table = TRUE)
# 
# uk_loss_smell_taste <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt ="loss_smell_taste", table = TRUE)
# 
# uk_muscle_ache <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "muscle_ache", table = TRUE)
# 
# uk_nasal_congestion <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "nasal_congestion", table = TRUE)
# 
# uk_nausea_vomiting <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "nausea_vomiting", table = TRUE)
# 
# uk_shortness_breath <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "shortness_breath", table = TRUE)
# 
# uk_sputum <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "sputum", table = TRUE)
# 
# uk_temperature <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "temperature", table = TRUE)
# 
# uk_loss_appetite <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "loss_appetite", table = TRUE)
# 
# uk_sore_throat <-  age_adjusted_sympt_dst(data = cleaned_data_22092020, country_select = "United Kingdom", sympt = "sore_throat", table = TRUE)
# 
# uk_data <- bind_rows(uk_chills, uk_cough, uk_diarrhoea, uk_headache, uk_loss_appetite, uk_loss_smell_taste, uk_muscle_ache, 
#                            uk_nasal_congestion, uk_nausea_vomiting, uk_shortness_breath, uk_sore_throat, uk_sputum, uk_temperature)
# 
# 
# adjusted_symptoms_covpos_rates <- bind_rows(brazil_data, India_data, Mexico_data, Pakistan_data, uk_data)
# 
# write.csv(adjusted_symptoms_covpos_rates, file = "/Users/gabrielburcea/rprojects/data/your.md/adjusted_symptoms_covpos_rates.csv", row.names = FALSE)
