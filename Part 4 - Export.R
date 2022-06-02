rm(list=ls())
cat("\014")

species <- readRDS("saved_objects/singularized_ncbi.rds")

species <- apply(species,2,as.character)

write.csv(species, "ncbi_species_list.csv")