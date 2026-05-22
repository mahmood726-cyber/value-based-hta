#!/usr/bin/env Rscript

################################################################################
# MCES PHASE 2: NET CLINICAL BENEFIT (NCB) SYNTHESIS
# Linking Benefit-Harm pairs to derive a unified Value Score
#
# Paths are resolved relative to the repository root by default. Override with
# the VBHTA_MAP, VBHTA_QUALITY, and VBHTA_OUTPUT_DIR environment variables,
# or pass positional arguments:
#   Rscript calculate_net_benefit.R <mapping_csv> <quality_csv> <output_dir>
# The quality file is optional; if missing, value classification proceeds
# without the Gold-Standard / Premature evidence-class refinement.
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(dplyr)
})

script_dir <- tryCatch({
  args_file <- sub("--file=", "", grep("--file=", commandArgs(trailingOnly = FALSE), value = TRUE)[1])
  if (length(args_file) && nzchar(args_file) && !is.na(args_file)) normalizePath(dirname(args_file)) else getwd()
}, error = function(e) getwd())

cli_args <- commandArgs(trailingOnly = TRUE)
map_file <- if (length(cli_args) >= 1) cli_args[[1]] else Sys.getenv(
  "VBHTA_MAP",
  unset = file.path(script_dir, "output", "outcome_mapping.csv")
)
quality_file <- if (length(cli_args) >= 2) cli_args[[2]] else Sys.getenv(
  "VBHTA_QUALITY",
  unset = file.path(script_dir, "output", "unified_hta_validation.csv")
)
output_dir <- if (length(cli_args) >= 3) cli_args[[3]] else Sys.getenv(
  "VBHTA_OUTPUT_DIR",
  unset = file.path(script_dir, "output")
)
output_path <- file.path(output_dir, "net_clinical_benefit.csv")

cat(strrep("=", 80), "\n", sep = "")
cat("HTA METHODOLOGY: NET CLINICAL BENEFIT SYNTHESIS\n")
cat(strrep("=", 80), "\n\n", sep = "")

if (!file.exists(map_file)) {
  stop(sprintf("Outcome-mapping file not found: %s. Run semantic_outcome_mapper.R first.", map_file))
}
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# Load Data
cat("Loading datasets...\n")
mapped <- fread(map_file)

quality_available <- file.exists(quality_file)
if (quality_available) {
  quality <- fread(quality_file)
} else {
  cat(sprintf("Quality file not found (%s); proceeding without evidence-class merge.\n", quality_file))
}

# 1. SELECT BEST BENEFIT AND BEST HARM PER REVIEW
mapped[, p_val_num := as.numeric(q_p)]

primary_benefits <- mapped[sentiment == "BENEFIT" & !is.na(p_val_num),
                           .SD[which.min(p_val_num)], by = dataset_name]
primary_harms    <- mapped[sentiment == "HARM"    & !is.na(p_val_num),
                           .SD[which.min(p_val_num)], by = dataset_name]

# 2. JOIN BENEFIT AND HARM
cat("Synthesizing Net Benefit pairs...\n")
ncb_dt <- merge(
  primary_benefits[, .(dataset_name, ben_name = analysis_name, ben_est = pooled_effect,
                       ben_se = pooled_se, ben_p = p_val_num, method)],
  primary_harms[, .(dataset_name, harm_name = analysis_name, harm_est = pooled_effect,
                    harm_se = pooled_se, harm_p = p_val_num)],
  by = "dataset_name"
)

# 3. NET CLINICAL BENEFIT (simplified 1:1 trade-off; downstream models may reweight)
ncb_dt[, ncb_raw := ben_est - harm_est]

# 4. BRING IN INTEGRITY SUITE DATA (optional)
if (quality_available && "evidence_class" %in% names(quality)) {
  ncb_dt <- merge(ncb_dt, quality[, .(dataset_name, ben_quality = evidence_class)],
                  by = "dataset_name", all.x = TRUE)
} else {
  ncb_dt[, ben_quality := NA_character_]
}

# 5. DEFINE VALUE CLASS
ncb_dt[, value_class := dplyr::case_when(
  !is.na(ben_quality) & ben_quality == "Gold Standard" & ncb_raw > 0 ~ "HIGH VALUE (Robust & Favorable)",
  !is.na(ben_quality) & ben_quality == "Premature"     & ncb_raw > 0 ~ "UNCERTAIN VALUE (Potentially Favorable)",
  ncb_raw <= 0 ~ "LOW VALUE (Harm outweighs Benefit)",
  TRUE ~ "INCONCLUSIVE"
)]

# Summary
cat("\n--- VALUE CLASSIFICATION DISTRIBUTION ---\n")
print(ncb_dt[, .N, by = value_class])

# Save
fwrite(ncb_dt, output_path)
cat(sprintf("\nNet Benefit Atlas saved to: %s\n", output_path))
