# library
# library(tidyverse)
# library(viridis)
# 
# comorb_divided <- data %>%
#   tidyr::separate('Long Standing Health Issues', c('Comorbidity_one', 'Comorbidity_two', 'Comorbidity_three', 'Comorbidity_four', 'Comorbidity_five', 
#                                                    'Comorbidity_six', 'Comorbidity_seven', 'Comorbidity_eight', 'Comorbidity_nine'), sep = ",") %>%
#   dplyr::select(ID,'Cough', 'Chills', 'Diarrhoea', 'Fatigue', 'Headcahe','Loss of smell and taste', 'Muscle Ache', 'Nasal Congestion', 'Nausea and Vomiting',
#                 'Shortness of Breath', 'Sore Throat', 'Sputum', 'Temperature', Comorbidity_one, Comorbidity_two, Comorbidity_three, Comorbidity_four, Comorbidity_five, 
#                 Comorbidity_six, Comorbidity_seven, Comorbidity_eight, Comorbidity_nine) 
# 
# gather_divided <- comorb_divided %>%
#   tidyr::pivot_longer(cols=2:14, names_to="Symptom", values_to="Severity") %>%
#   dplyr::filter(Severity!="No") %>%
#   tidyr::pivot_longer(cols=starts_with("Comorbidity"), 
#                       names_to=c("name","time"), names_sep="_",
#                       values_to="Morbidity") %>%
#   dplyr::filter(Morbidity != "None" ) %>%
#   dplyr::group_by(Morbidity, Symptom, Severity) %>%
#   dplyr::summarise(Count=n()) %>%
#   dplyr::group_by(Morbidity) %>%
#   dplyr::mutate(Percentage=Count/sum(Count) *100) %>%
#   dplyr::filter(Symptom != 'Temperature')
# 
# gather_divided <- data.frame(gather_divided)
# 
# gather_divided <- gather_divided %>%
#   dplyr::select(Symptom, Morbidity, Severity, Count)
# 
# # Set a number of 'empty bar' to add at the end of each group
# empty_bar <- 2
# nObsType <- nlevels(as.factor(gather_divided$Severity))
# 
# nObsType
# 
# to_add <- data.frame(matrix(NA, empty_bar*nlevels(gather_divided$Morbidity)*nObsType, ncol(gather_divided)) )
# 
# colnames(to_add) <- colnames(gather_divided)
# 
# to_add$Morbidity <- rep(levels(gather_divided$Morbidity), each=empty_bar*nObsType )
# 
# gather_divided <- rbind(gather_divided, to_add)
# gather_divided <- gather_divided %>% arrange(Morbidity, Symptom)
# 
# gather_divided$id <- rep( seq(1, nrow(gather_divided)/nObsType) , each=nObsType)
# 
# # Get the name and the y position of each label
# label_data <- gather_divided %>% group_by(id, Symptom) %>% summarize(tot=sum(Count))
# number_of_bar <- nrow(label_data)
# angle <- 90 - 360 * (label_data$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
# label_data$hjust <- ifelse( angle < -90, 1, 0)
# label_data$angle <- ifelse(angle < -90, angle+180, angle)
# 
# # prepare a data frame for base lines
# base_data <- gather_divided %>% 
#   group_by(Morbidity) %>% 
#   summarize(start=min(id), end=max(id) - empty_bar) %>% 
#   rowwise() %>% 
#   mutate(title=mean(c(start, end)))
# 
# # prepare a data frame for grid (scales)
# grid_data <- base_data
# grid_data$end <- grid_data$end[ c( nrow(grid_data), 1:nrow(grid_data)-1)] + 1
# grid_data$start <- grid_data$start - 1
# grid_data <- grid_data[-1,]
# 
# # Make the plot
# p <- ggplot(gather_divided) +      
#   
#   # Add the stacked bar
#   geom_bar(aes(x=as.factor(id), y=Count, fill=Morbidity), stat="identity", alpha=0.5) +
#   scale_fill_viridis(discrete=TRUE) +
#   
#   # Add a val=100/75/50/25 lines. I do it at the beginning to make sur barplots are OVER it.
#   geom_segment(data=grid_data, aes(x = end, y = 0, xend = start, yend = 0), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
#   geom_segment(data=grid_data, aes(x = end, y = 500, xend = start, yend = 500), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
#   geom_segment(data=grid_data, aes(x = end, y = 1000, xend = start, yend = 1000), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
#   geom_segment(data=grid_data, aes(x = end, y = 1500, xend = start, yend = 1500), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
#   geom_segment(data=grid_data, aes(x = end, y = 2000, xend = start, yend = 2000), colour = "grey", alpha=1, size=0.3 , inherit.aes = FALSE ) +
#   
#   
#   # Add text showing the value of each 100/75/50/25 lines
#   ggplot2::annotate("text", x = rep(max(gather_divided$id),5), y = c(0,  500, 1000,  1500,  2000), 
#                     label = c("0",  "500", "1000", "1500",  "2000") , color="grey", size=6 , angle=0, fontface="bold", hjust=1) +
#   
#   ylim(-150,max(label_data$tot, na.rm=T)) +
#   theme_minimal() +
#   theme(
#     legend.position = "none",
#     axis.text = element_blank(),
#     axis.title = element_blank(),
#     panel.grid = element_blank(),
#     plot.margin = unit(rep(-1,4), "cm") 
#   ) +
#   coord_polar() +
#   
#   # Add labels on top of each bar
#   geom_text(data=label_data, aes(x=id, y=tot+10, label= Symptom, hjust=hjust), color="black", fontface="bold",alpha=0.6, size=5, angle= label_data$angle, inherit.aes = FALSE ) +
#   
#   # Add base line information
#   geom_segment(data=base_data, aes(x = start, y = -5, xend = end, yend = -5), colour = "black", alpha=0.8, size=0.6 , inherit.aes = FALSE )  +
#   geom_text(data=base_data, aes(x = title, y = -18, label=Morbidity), hjust=c(1,1,0,0), colour = "black", alpha=0.8, size=4, fontface="bold", inherit.aes = FALSE)
# 
# p
