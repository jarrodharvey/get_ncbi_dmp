rm(list=ls())
cat("\014")

easypackages::packages("tibble", "magrittr", "dplyr", "stringr", "pbapply")

sapply(list.files("R", full.names = TRUE), source)

common_name_ids <- read.csv("data/names.dmp", sep = "|") %>%
  filter(synonym == "\tcommon name\t") %>%
  .$X1 %>%
  unique(.)

scientific_and_common_names <- read.csv("/media/jarrod/b981c093-4ff8-4a89-a26c-ae568a260e73/Large\ objects/names.dmp", sep = "|") %>%
  filter(synonym == "\tcommon name\t" | synonym == "\tscientific name\t") %>%
  filter(X1 %in% common_name_ids) %>%
  select(c("id" = "X1", "all", "synonym"))

saveRDS(scientific_and_common_names, "saved_objects/scientific_and_common_names.rds")
