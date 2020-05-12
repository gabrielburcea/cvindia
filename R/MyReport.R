#### Reporting
# 
# map_world <- cvindia::count_mapp_world(data = data, item = "world", start_date = "2020-04-09", end_date = "2020-05-09", plot_chart = TRUE, title= "World Map")
# 
# map_world
# 
# 
# 
# map_world_numbers <- knitr::kable(cvindia::count_mapp_world(data = data, item = "world", start_date = "2020-04-09", end_date = "2020-05-09", plot_chart = FALSE, title= "World Map"))
# 
# 
# map_world_numbers
# 
# 
# 
# symtoms_covid_in_resp <- symptom_profile_covid_tested(data = data_select, start_date = as.Date("2020-04-01", format = "%Y-%m-%d"), 
#                                                       end_date = as.Date("2020-09-01", format = "%Y-%m-%d"),
#                                                       plot_chart = TRUE)
# 
# symtoms_covid_in_resp
# 
# symtoms_covid_in_resp_numbers<- symptom_profile_covid_tested(data = data_select, start_date = as.Date("2020-04-01", format = "%Y-%m-%d"), 
#                                                       end_date = as.Date("2020-09-01", format = "%Y-%m-%d"),
#                                                       plot_chart = FALSE)
# 
# symtoms_covid_in_resp_numbers
# 
# 
# 
# all_syptpms_frequency <- symptom_profile_frequency_plot(data = data_select, start_date = as.Date("2020-04-09", format = "%Y-%m-%d"), 
#                                                         end_date = as.Date("2020-05-09", format = "%Y-%m-%d"),
#                                                         plot_chart = TRUE, title = "Test")
# 
# all_syptpms_frequency
# 
# 
# all_syptpms_numbers <- symptom_profile_frequency_plot(data = data_select, start_date = as.Date("2020-04-09", format = "%Y-%m-%d"), 
#                                                       end_date = as.Date("2020-05-09", format = "%Y-%m-%d"),
#                                                       plot_chart = FALSE, title = "Test")
# 
# knitr::kable(all_syptpms_numbers)
# 
# 
# 
# 
# 
# symptoms_covid_in_resp_numbers <- symptom_profile_covid_tested(data = data_select, start_date = as.Date("2020-04-01", format = "%Y-%m-%d"), 
#                                                                end_date = as.Date("2020-09-01", format = "%Y-%m-%d"),
#                                                                plot_chart = FALSE)
# 
# symptoms_covid_in_resp_numbers <- knitr::kable(symptoms_covid_in_resp_numbers)
# symptoms_covid_in_resp_numbers
# 
# 
# self_diagnose_mild_mod_severe <- cvindia::self_diagnosis_mild_mod_severe(data = data_select, start_date = as.Date("2020-04-09"), end_date = as.Date("2020-05-09"), 
#                                         plot_chart = TRUE, title = "Self Report")
# 
# self_diagnose_mild_mod_severe 
# 
# self_diagnose_mild_mod_severe_numbers <- cvindia::self_diagnosis_mild_mod_severe(data = data_select, start_date = as.Date("2020-04-09"), end_date = as.Date("2020-05-09"), 
#                                                                          plot_chart = FALSE, title = "Self Report")
# 
# knitr::kable(self_diagnose_mild_mod_severe_numbers)
