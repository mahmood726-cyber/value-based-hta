#!/usr/bin/env Rscript

################################################################################
# MCES PHASE 1: SEMANTIC OUTCOME MAPPING
# Classifying 17,000+ clinical endpoints into Benefit vs Harm
#
# Paths are resolved relative to the repository root by default. Override with
# the VBHTA_INPUT and VBHTA_OUTPUT_DIR environment variables, or pass two
# positional arguments: `Rscript semantic_outcome_mapper.R <input> <output_dir>`.
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(stringr)
  library(dplyr)
})

# Locate the directory of this script so paths work regardless of CWD.
script_dir <- tryCatch({
  args_file <- sub("--file=", "", grep("--file=", commandArgs(trailingOnly = FALSE), value = TRUE)[1])
  if (length(args_file) && nzchar(args_file) && !is.na(args_file)) normalizePath(dirname(args_file)) else getwd()
}, error = function(e) getwd())

cli_args <- commandArgs(trailingOnly = TRUE)
input_file <- if (length(cli_args) >= 1) cli_args[[1]] else Sys.getenv(
  "VBHTA_INPUT",
  unset = file.path(script_dir, "data", "remediation_analysis_results.csv")
)
output_dir <- if (length(cli_args) >= 2) cli_args[[2]] else Sys.getenv(
  "VBHTA_OUTPUT_DIR",
  unset = file.path(script_dir, "output")
)
output_path <- file.path(output_dir, "outcome_mapping.csv")

cat(strrep("=", 80), "\n", sep = "")
cat("HTA METHODOLOGY: MULTI-CRITERIA SEMANTIC MAPPING\n")
cat(strrep("=", 80), "\n\n", sep = "")

if (!file.exists(input_file)) {
  stop(sprintf("Input file not found: %s", input_file))
}
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

data <- fread(input_file)

# 1. KEYWORD LIBRARIES
benefit_keywords <- "remission|survival|response|success|improvement|cure|healing|quality of life|well-being|recovery|reduction in symptoms"
harm_keywords <- "adverse event|side effect|withdrawal|toxicity|death|mortality|harm|failure|recurrence|complication|safety|serious|drop-out|relapse"

# 2. CLASSIFY
cat("Mapping outcome directions...\n")
data[, outcome_text := tolower(analysis_name)]

data[, sentiment := dplyr::case_when(
  grepl(harm_keywords, outcome_text) ~ "HARM",
  grepl(benefit_keywords, outcome_text) ~ "BENEFIT",
  TRUE ~ "OTHER"
)]

# Summary
cat("\n--- MAPPING DISTRIBUTION ---\n")
print(data[, .N, by = sentiment])

# 3. IDENTIFY REVIEWS WITH BOTH
cat("\nIdentifying reviews with multi-criteria eligibility...\n")
review_summary <- data[, .(
  has_benefit = any(sentiment == "BENEFIT"),
  has_harm    = any(sentiment == "HARM")
), by = dataset_name]

eligible_reviews <- review_summary[has_benefit == TRUE & has_harm == TRUE]
cat(sprintf("Found %d systematic reviews with both Benefit and Harm data.\n",
            nrow(eligible_reviews)))

# Save
fwrite(data, output_path)
cat(sprintf("\nMapping saved to: %s\n", output_path))
