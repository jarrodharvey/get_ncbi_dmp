rm(list=ls())
cat("\014")

easypackages::packages("pluralize", "pbapply")

clean_ncbi <- readRDS("saved_objects/cleaned_ncbi.rds")

singularized_ncbi <- clean_ncbi

singularized_ncbi$common.name <- pblapply(singularized_ncbi$common.name, singularize)

saveRDS(singularized_ncbi, "saved_objects/singularized_ncbi.rds")