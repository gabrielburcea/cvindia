# library(tidymodels)
# library(dplyr)
# library(corrr)
# 
# #Corelations 
# 
# correlation_num_dt <- data_final_numeric %>%
#   dplyr::select_if(is.numeric) %>%
#   corrr::correlate(x = .,
#                    method = "spearman", 
#                    quiet = TRUE) %>%
#   corrr::rearrange(x =., 
#                    method = "MDS", 
#                    absolute = FALSE)
# 
# correlation_num_dt
# 
# rplot_labs_v1 <- ggplot2::labs(
#   title = "Correlations - symptoms and comorbidities", 
#   subtitle = "Symptoms and Commorbidities", 
#   caption = "Data accessed from Your.md")
# 
# 
# #As we can see, the hue of the color and the size of the point indicate the level of the correlation
# 
# correlated_vars_plot <- correlation_num_dt %>%
#   corrr::rplot(rdf = ., shape = 19, 
#               colors = c("yellow", 
#                          "purple")) +
#   theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
#   rplot_labs_v1
# 
# correlated_vars_plot
# 
# # Removing the redundant correlations from the table - not 
# 
# removed_correlated_vars <- correlation_num_dt %>% corrr::shave(x =.)
# 
# removed_correlated_vars %>%
#   corrr::rplot(rdf = ., shape = 19, 
#              colors = c("yellow", 
#                         "purple")) +
#   theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
#   rplot_labs_v1
# 
# removed_correlated_vars
# 
# 
# 
# 
# 
# #Network plot 
# # correlation_num_dt <- data_final_numeric %>%
# #  network_plot_v1 <- data_final_numeric %>%
# #    dplyr::select_if(is.numeric) %>%
# #    corrr::correlate(x = .,
# #                     method = "spearman", 
# #                     quiet = TRUE) %>%
# #    corrr::network_plot(rdf =., 
# #                        colors = c("firebrick", "white", "dodgerblue"),
# #                        min_cor = .5) + 
# #    rplot_labs_v1
# # 
# # network_plot_v1
