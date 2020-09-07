data_clustered <- read_csv("/Users/gabrielburcea/rprojects/data/data_clustered.csv")

data_clustered <- data_clustered %>%
  select(-X1) %>%
  dplyr::rename(cluster_number = 'cutree(hc_agnes, k = 3)' )

data_clustered$cluster_number <- as.factor(data_clustered$cluster_number)

cnt_resp_cluster <- data_clustered %>%
  group_by(cluster_number) %>%
  tally()


data_piv_longer <- data_clustered %>%
  tidyr::pivot_longer(cols = 5:21, 
                      names_to = "symptoms", 
                      values_to = "Bolean")  %>%
  dplyr::filter(Bolean == "Yes") 


count_cluster_symptom_comorbidity <- data_piv_loger %>%
  dplyr::group_by(cluster_number, comorbidities) %>%
 


