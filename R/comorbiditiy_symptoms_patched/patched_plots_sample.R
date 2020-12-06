count_symptoms = readr::read_csv("https://github.com/gabrielburcea/stackoverflow_fake_data/raw/master/fake_symptoms.csv")

count_comorbidities = readr::read_csv("https://github.com/gabrielburcea/stackoverflow_fake_data/raw/master/fake_comorbidities.csv")



sympt_count_plot <- ggplot2::ggplot(count_symptoms, ggplot2::aes(x = age_band, y = Count, group = symptoms, fill = symptoms)) +
  ggplot2::geom_area( color = "white") + 
  ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
  viridis::scale_fill_viridis(discrete = TRUE) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  ggplot2::facet_grid(Country ~.)

sympt_count_plot


sympt_percent_plot <- ggplot2::ggplot(count_symptoms, ggplot2::aes(x = age_band, y = Percent, group = symptoms, fill = symptoms)) +
  ggplot2::geom_area( color = "white") + 
  ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
  viridis::scale_fill_viridis(discrete = TRUE) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  ggplot2::facet_grid(Country ~.)

sympt_percent_plot


library(patchwork)
plot_sympt <- sympt_count_plot + sympt_percent_plot

plot_sympt



comorb_count_plot <- ggplot2::ggplot(count_comorbidities, ggplot2::aes(x = age_band, y = Count, group = comorbidities, fill = comorbidities)) +
  ggplot2::geom_area( color = "white") + 
  ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
  #viridis::scale_fill_viridis(discrete = TRUE) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  ggplot2::facet_grid(Country ~.)

comorb_count_plot




comorb_percent_plot <- ggplot2::ggplot(count_comorbidities, ggplot2::aes(x = age_band, y = Percent, group = comorbidities, fill = comorbidities)) +
  ggplot2::geom_area( color = "white") + 
  ggplot2::scale_x_discrete(limits = c( "0-19" ,"20-39", "40-59","60+"), expand = c(0, 0)) +
  ggplot2::scale_y_continuous(expand = expansion(mult = c(0, 0.1))) + 
  #viridis::scale_fill_viridis(discrete = TRUE) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) + 
  ggplot2::facet_grid(Country ~.)

comorb_percent_plot


plot_comorb <- comorb_count_plot + comorb_percent_plot

plot_comorb

plot_sympt + plot_comorb 



  
plot_sympt <-  sympt_count_plot + theme(legend.position = "none") + 
sympt_percent_plot + theme(legend.position = "none")

plot_comorb <- comorb_count_plot + theme(legend.position = "none") +
  comorb_percent_plot + theme(legend.position = "none")

plot_legend <- wrap_plots(
  cowplot::get_legend(sympt_percent_plot),
  cowplot::get_legend(comorb_percent_plot),
  ncol = 1)

wrap_plots(plot_sympt, plot_comorb, plot_legend,
           nrow = 1, widths = c(2, 2, 1)) +
  plot_annotation(
    title = "Figure: Tested SARS-Covid-19 positive group: Symptoms and Comorbidities across top 5 countries", 
    subtitle = "Symptoms of SARS-Covid-19, first two columns, on the left in counts and percentages and comorbidities on the right counts and percentages", 
    caption = "Data source: Your.md, Note: figures are in between 04/09/2020 - 22/09/2020"
    )

