data <- read_csv("/Users/gabrielburcea/rprojects/data/your.md/cleaned_data_22092020_2nd_dataset.csv")

map_item <- ggplot2::map_data("world")

as.factor(data$country) %>% levels()

data$country <-
  recode(
    data$country,
    'United States' = 'United States of America',
    USA = 'United States of America',
    'Great Britain' = 'United Kingdom'
  )


as.factor(map_item$region) %>% levels()

count_respondents <- data %>%
  dplyr::select(id, country) %>%
  dplyr::group_by(country) %>%
  dplyr::summarise(count = n()) %>%
  dplyr::mutate(percentage = count / sum(count)) %>%
  dplyr::rename(Count = count) %>%
  dplyr::arrange(Count)


map.world_joined <-
  left_join(map_item, count_respondents, by = c('region' = 'country'))
# Set the title
#title_stub <- ": Count of respondent per country, SARS-COVID-19, "
# start_date_title <-
#   format(as.Date(start_date), format = "%d %B %Y")
# end_date_title <- format(as.Date(end_date), format = "%d %B %Y")
#chart_title <- paste0(title, start_date_title, " to ", end_date_title)


map <- ggplot2::ggplot(data = map.world_joined) +
  ggplot2::geom_polygon(ggplot2::aes(
    x = long,
    y = lat,
    group = group,
    fill = Count
  )) +
  ggplot2::geom_sf(aes(fill  = region, geometry = region)) +
  #ggthemes::scale_fill_gradient2_tableau(palette = "Blue-Orange Diverging")  +
  scale_fill_gradient(low = "green", high = "brown4") +
  ggplot2::coord_equal() +
  ggplot2::labs(y = "Latitude", x = "Longitude") +
  theme_minimal() +
  ggplot2::theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 14),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(
      t = 0,
      r = 10,
      b = 0,
      l = 0
    )),
    plot.title = ggplot2::element_text(size = 9, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 10),
    legend.box = "horizontal", 
    legend.title = element_text(size = 14), 
    legend.text = element_text(size = 10)
  )


map



world_map_numbers <- cvindia::count_map_world(data = data, item = "world", start_date = "2020-04-09", end_date = "2020-09-01", plot_chart = FALSE, title = "World Map")

world_map_n <- world_map_numbers %>%
  arrange(desc(percentage)) %>% top_n(30) %>%
  rename(Country = country, Count = count, Percentage = percentage) %>%
  dplyr::arrange(Percentage)


plot_countries <- ggplot2::ggplot(world_map_n, aes(x = reorder(Country, -Percentage), y = Percentage)) + 
  ggplot2::geom_bar(stat = "identity", fill = "brown4", width = 0.9) +
  coord_flip() + 
  theme_minimal() + 
  ggplot2::labs(#title = "% of responders across countries",
                y = "Percentage", x = "Countries") +
  ggplot2::theme(
    axis.text = element_text(size = 14),
    axis.title = element_text(size = 16),
    axis.title.y = ggplot2::element_text(margin = ggplot2::margin(t = 0, r = 10, b = 0, l = 0)),
    plot.title = ggplot2::element_text(size = 17, face = "bold"),
    plot.subtitle = ggplot2::element_text(size = 17),
    legend.box = "horizontal")

plot_countries






library(ggpubr)

bar_chart_plot <- ggpubr::ggarrange(map, plot_countries) 

annotate_figure(bar_chart_plot,
                top = text_grob("Figure 1: World map with responders across countries and the top 30 countries with highest number of responders in % ", face = "bold", size = 14))

