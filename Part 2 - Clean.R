rm(list=ls())
cat("\014")

easypackages::packages("tibble", "magrittr", "dplyr", "stringr", "pbapply")

sapply(list.files("R", full.names = TRUE), source)

scientific_and_common_names <- readRDS("saved_objects/scientific_and_common_names.rds")

unique_ids <- unique(scientific_and_common_names$id)

species <- pblapply(unique_ids, function(unique_id) {
  id_rows <- filter(scientific_and_common_names, id == unique_id)

  common_names <- filter(id_rows, id_rows$synonym == "\tcommon name\t") %>%
    .$all %>%
    trimws(.)

  scientific_name <- filter(id_rows, id_rows$synonym == "\tscientific name\t") %>%
    .$all %>%
    trimws(.)

  tibble(
    common.name = common_names,
    scientific.name = scientific_name,
    image.lookup.text = scientific_name
  )
}) %>%
  bind_rows(.)

saveRDS(species, "saved_objects/cleaned_ncbi.rds")