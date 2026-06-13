#!/usr/bin/env Rscript

################################################################################
# MCES PHASE 1: SEMANTIC OUTCOME MAPPING
# Classifying 17,000+ clinical endpoints into Benefit vs Harm
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(stringr)
  library(dplyr)
})

cat("================================================================================
")
cat("HTA METHODOLOGY: MULTI-CRITERIA SEMANTIC MAPPING
")
cat("================================================================================

")

# Paths (override with environment variables for portability)
input_file  <- Sys.getenv("VBHTA_INPUT",  "data/remediation_analysis_results.csv")
output_dir  <- Sys.getenv("VBHTA_OUTPUT_DIR", "output")
output_path <- file.path(output_dir, "outcome_mapping.csv")
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

data <- fread(input_file)

# 1. KEYWORD LIBRARIES
# Endpoints that are generally positive
benefit_keywords <- "remission|survival|response|success|improvement|cure|healing|quality of life|well-being|recovery|reduction in symptoms"

# Endpoints that are generally negative
harm_keywords <- "adverse event|side effect|withdrawal|toxicity|death|mortality|harm|failure|recurrence|complication|safety|serious|drop-out|relapse"

# 2. CLASSIFY
cat("Mapping outcome directions...
")
data[, outcome_text := tolower(analysis_name)]

data[, sentiment := case_when(
  grepl(harm_keywords, outcome_text) ~ "HARM",
  grepl(benefit_keywords, outcome_text) ~ "BENEFIT",
  TRUE ~ "OTHER"
)]

# Summary
cat("
--- MAPPING DISTRIBUTION ---
")
print(data[, .N, by = sentiment])

# 3. IDENTIFY REVIEWS WITH BOTH
cat("
Identifying reviews with multi-criteria eligibility...
")
review_summary <- data[, .(
  has_benefit = any(sentiment == "BENEFIT"),
  has_harm = any(sentiment == "HARM")
), by = dataset_name]

eligible_reviews <- review_summary[has_benefit == TRUE & has_harm == TRUE]
cat(sprintf("Found %d systematic reviews with both Benefit and Harm data.
", nrow(eligible_reviews)))

# Save
fwrite(data, output_path)
cat(sprintf("
Mapping saved to: %s
", output_path))
