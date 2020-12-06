# cleaned_data_22092020 <- readr::read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020.csv")
# 
# count_symptoms_positive <- cleaned_data_22092020 %>%
#   dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
#                 sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
#   dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   tidyr::pivot_longer(cols = 4:20,
#                       names_to = "Symptoms",
#                       values_to = "bolean_yn_sympt") %>%
#   dplyr::filter(bolean_yn_sympt == "Yes") %>%
#   dplyr::group_by(Country, age_band, Symptoms) %>%
#   dplyr::tally() %>%
#   dplyr::rename(Count = n) %>%
#   dplyr::mutate(Percent = Count/sum(Count) *100)
# 
# 
# symptom_levels <- c(
#   "muscle ache" = "muscle_ache",
#   "nasal congestion" = "nasal_congestion",
#   "nausea and vomiting" = "nausea_vomiting",
#   "sore throat" = "sore_throat",
#   "loss of appetite" = "loss_appetite",
#   "chest pain" = "chest_pain",
#   "itchy eyes" = "itchy_eyes",
#   "joint pain" = "joint_pain"
# )
# 
# 
# count_symptoms_positive <- count_symptoms_positive %>%
#   dplyr::mutate(Symptoms = forcats::fct_recode(Symptoms, !!!symptom_levels))
# 
# 
# count_comorbidities_positive <- cleaned_data_22092020 %>%
#   dplyr::select(id, Country, age_band,asthma, diabetes_type_one, diabetes_type_two,
#                 obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
#   dplyr::filter(covid_tested == "positive") %>%
#   dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "Comorbidities",
#                       values_to = "bolean_yn_comorb") %>%
#   dplyr::filter(bolean_yn_comorb == "Yes") %>%
#   dplyr::group_by(Country, age_band, Comorbidities) %>%
#   dplyr::tally() %>%
#   dplyr::rename(Count = n) %>%
#   dplyr::mutate(Percent = Count/sum(Count) *100)
# 
# comorbidities_levels <- c(
#   "heart disease" = "heart_disease",
#   "lung disease" = "lung_disease",
#   "liver disease" = "liver_disease",
#   "kidney disease" = "kidney_disease"
# )
# 
# count_comorbidities_positive <- count_comorbidities_positive %>%
#   dplyr::mutate(Comorbidities = forcats::fct_recode(Comorbidities, !!!comorbidities_levels))
# 
# sympt_count_plot <- ggplot2::ggplot(count_symptoms_positive, ggplot2::aes(x = age_band, y = Count, group = Symptoms, fill = Symptoms)) +
#   ggplot2::geom_area( color = "white") +
#   ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   ggplot2::scale_fill_viridis_d() +
#   ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", hjust = 0)) +
#   ggplot2::facet_wrap(~Country, ncol = 1)
# 
# sympt_count_plot
# 
# 
# sympt_percent_plot <- ggplot(count_symptoms_positive) +
#   geom_area(aes(x = age_band, y = Percent, group = Symptoms, fill = Symptoms),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_viridis_d() +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# sympt_percent_plot
# 
# 
# library(patchwork)
# plot_sympt <- sympt_count_plot + sympt_percent_plot
# 
# 
# comorb_count_plot <- ggplot(count_comorbidities_positive) +
#   geom_area(aes(age_band, Count, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Reds") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_count_plot
# 
# 
# comorb_percent_plot <- ggplot(count_comorbidities_positive) +
#   geom_area(aes(age_band, Percent, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Oranges") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_percent_plot
# 
# 
# plot_sympt <-  sympt_count_plot + theme(legend.position = "none") +
#   sympt_percent_plot + theme(legend.position = "none")
# 
# plot_comorb <- comorb_count_plot + theme(legend.position = "none") +
#   comorb_percent_plot + theme(legend.position = "none")
# 
# plot_legend <- wrap_plots(
#   cowplot::get_legend(sympt_percent_plot),
#   cowplot::get_legend(comorb_percent_plot),
#   ncol = 1)
# 
# 
# wrap_plots(plot_sympt, plot_comorb, plot_legend,
#            nrow = 1, widths = c(2, 2, 1)) +
#   plot_annotation(
#     title = "Figure 2: SARS-Covid-19 Symptoms and Comorbidities in responders with Covid tested positive, across top 5 countries with the highest prevalence of responders",
#     subtitle = "Symptoms of SARS-Covid-19, first two columns, on the left in counts and percentages and comorbidities on the right counts and percentages \nNote: i) excludes the responders who show symptoms of SARS-Covid-19; ii) period chosen - between 04/09/2020 - 22/09/2020",
#     caption = "Data source: Your.md")
# 
# 
# 
# 
# # Doing the same for showing symptoms responders
# 
# count_symptoms_shwsympt <- cleaned_data_22092020 %>%
#   dplyr::select(id, Country, age_band, chills, cough, diarrhoea, fatigue, headache, muscle_ache, nasal_congestion, nausea_vomiting, shortness_breath,
#                 sore_throat, sputum, temperature, loss_appetite, sneezing, chest_pain, itchy_eyes, joint_pain, covid_tested) %>%
#   dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>%
#   tidyr::pivot_longer(cols = 4:20,
#                       names_to = "Symptoms",
#                       values_to = "bolean_yn_sympt") %>%
#   dplyr::filter(bolean_yn_sympt == "Yes") %>%
#   dplyr::group_by(Country, age_band, Symptoms) %>%
#   dplyr::tally() %>%
#   dplyr::rename(Count = n) %>%
#   dplyr::mutate(Percent = Count/sum(Count) *100)
# 
# 
# symptom_levels <- c(
#   "muscle ache" = "muscle_ache",
#   "nasal congestion" = "nasal_congestion",
#   "nausea and vomiting" = "nausea_vomiting",
#   "sore throat" = "sore_throat",
#   "loss of appetite" = "loss_appetite",
#   "chest pain" = "chest_pain",
#   "itchy eyes" = "itchy_eyes",
#   "joint pain" = "joint_pain"
# )
# 
# 
# count_symptoms_shwsympt <- count_symptoms_shwsympt %>%
#   dplyr::mutate(Symptoms = forcats::fct_recode(Symptoms, !!!symptom_levels))
# 
# 
# count_comorbidities_shwsympt <- cleaned_data_22092020 %>%
#   dplyr::select(id, Country, age_band,asthma, diabetes_type_one, diabetes_type_two,
#                 obesity, hypertension, heart_disease, lung_condition, liver_disease, kidney_disease, covid_tested) %>%
#   dplyr::filter(covid_tested == "showing symptoms") %>%
#   dplyr::filter(Country == "Brazil" | Country == "India" | Country == "Pakistan" | Country == "Mexico" | Country == "United Kingdom") %>%
#   tidyr::pivot_longer(cols = 4:12,
#                       names_to = "Comorbidities",
#                       values_to = "bolean_yn_comorb") %>%
#   dplyr::filter(bolean_yn_comorb == "Yes") %>%
#   dplyr::group_by(Country, age_band, Comorbidities) %>%
#   dplyr::tally() %>%
#   dplyr::rename(Count = n) %>%
#   dplyr::mutate(Percent = Count/sum(Count) *100)
# 
# comorbidities_levels <- c(
#   "heart disease" = "heart_disease",
#   "lung disease" = "lung_disease",
#   "liver disease" = "liver_disease",
#   "kidney disease" = "kidney_disease"
# )
# 
# count_comorbidities_shwsympt <- count_comorbidities_shwsympt %>%
#   dplyr::mutate(Comorbidities = forcats::fct_recode(Comorbidities, !!!comorbidities_levels))
# 
# sympt_count_plot_shwsympt <- ggplot2::ggplot(count_symptoms_shwsympt, ggplot2::aes(x = age_band, y = Count, group = Symptoms, fill = Symptoms)) +
#   ggplot2::geom_area( color = "white") +
#   ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   ggplot2::scale_fill_viridis_d() +
#   ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", hjust = 0)) +
#   ggplot2::facet_wrap(~Country, ncol = 1)
# 
# sympt_count_plot_shwsympt
# 
# 
# sympt_percent_plot <- ggplot(count_symptoms_shwsympt) +
#   geom_area(aes(x = age_band, y = Percent, group = Symptoms, fill = Symptoms),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_viridis_d() +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# sympt_percent_plot
# 
# 
# library(patchwork)
# plot_sympt <- sympt_count_plot + sympt_percent_plot
# 
# 
# comorb_count_plot <- ggplot(count_comorbidities_shwsympt) +
#   geom_area(aes(age_band, Count, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Reds") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_count_plot
# 
# 
# comorb_percent_plot <- ggplot(count_comorbidities_shwsympt) +
#   geom_area(aes(age_band, Percent, group = Comorbidities, fill = Comorbidities),
#             color = "white") +
#   scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"),
#                    expand = c(0, 0)) +
#   scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
#   scale_fill_brewer(palette = "Oranges") +
#   theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
#         strip.background = element_blank(),
#         strip.text = element_text(size = 10, face = "bold", color = "white")) +
#   facet_wrap(~Country, ncol = 1)
# 
# comorb_percent_plot
# 
# 
# plot_sympt <-  sympt_count_plot_shwsympt + theme(legend.position = "none") +
#   sympt_percent_plot  + theme(legend.position = "none")
# 
# plot_comorb <- comorb_count_plot + theme(legend.position = "none") +
#   comorb_percent_plot + theme(legend.position = "none")
# 
# plot_legend <- wrap_plots(
#   cowplot::get_legend(sympt_percent_plot),
#   cowplot::get_legend(comorb_percent_plot),
#   ncol = 1)
# 
# 
# wrap_plots(plot_sympt, plot_comorb, plot_legend,
#            nrow = 1, widths = c(2, 2, 1)) +
#   plot_annotation(
#     title = "Figure 3: SARS-Covid-19 Symptoms and Comorbidities in responders with showing symptoms, across top 5 countries with the highest prevalence of responders",
#     subtitle = "Symptoms of SARS-Covid-19, first two columns, on the left in counts and percentages and comorbidities on the right counts and percentages \nNote: i) excludes the responders who are tested positive of SARS-Covid-19; ii) period chosen - between 04/09/2020 - 22/09/2020",
#     caption = "Data source: Your.md")

