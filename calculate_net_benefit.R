#!/usr/bin/env Rscript

################################################################################
# MCES PHASE 2: NET CLINICAL BENEFIT (NCB) SYNTHESIS
# Linking Benefit-Harm pairs to derive a unified Value Score
################################################################################

suppressPackageStartupMessages({
  library(data.table)
  library(dplyr)
})

cat("================================================================================
")
cat("HTA METHODOLOGY: NET CLINICAL BENEFIT SYNTHESIS
")
cat("================================================================================

")

# Paths
map_file <- "C:/Models/Value_Based_HTA_Engine/output/outcome_mapping.csv"
quality_file <- "C:/Models/HTA_Evidence_Integrity_Suite/analysis/output/unified_hta_validation.csv"
output_path <- "C:/Models/Value_Based_HTA_Engine/output/net_clinical_benefit.csv"

# Load Data
cat("Loading datasets...
")
mapped <- fread(map_file)
quality <- fread(quality_file)

# 1. SELECT BEST BENEFIT AND BEST HARM PER REVIEW
# We'll take the one with the smallest p-value (strongest signal) as 'Primary'
mapped[, p_val_num := as.numeric(q_p)]

primary_benefits <- mapped[sentiment == "BENEFIT", .SD[which.min(p_val_num)], by = dataset_name]
primary_harms <- mapped[sentiment == "HARM", .SD[which.min(p_val_num)], by = dataset_name]

# 2. JOIN BENEFIT AND HARM
cat("Synthesizing Net Benefit pairs...
")
ncb_dt <- merge(
  primary_benefits[, .(dataset_name, ben_name = analysis_name, ben_est = pooled_effect, ben_se = pooled_se, ben_p = p_val_num, method)],
  primary_harms[, .(dataset_name, harm_name = analysis_name, harm_est = pooled_effect, harm_se = pooled_se, harm_p = p_val_num)],
  by = "dataset_name"
)

# 3. STANDARDIZE AND CALCULATE NCB
# Simplified: NCB = Ben_Effect - Harm_Effect
# In real HTA, we'd weight them by clinical importance. 
# Here, we'll use a conservative 1:1 trade-off.
ncb_dt[, ncb_raw := ben_est - harm_est]

# 4. BRING IN INTEGRITY SUITE DATA
# Merge quality of benefit
ncb_dt <- merge(ncb_dt, quality[, .(dataset_name, ben_quality = evidence_class)], 
                by = "dataset_name", all.x = TRUE)

# 5. DEFINE VALUE CLASS
ncb_dt[, value_class := case_when(
  ben_quality == "Gold Standard" & ncb_raw > 0 ~ "HIGH VALUE (Robust & Favorable)",
  ben_quality == "Premature" & ncb_raw > 0 ~ "UNCERTAIN VALUE (Potentially Favorable)",
  ncb_raw <= 0 ~ "LOW VALUE (Harm outweighs Benefit)",
  TRUE ~ "INCONCLUSIVE"
)]

# Summary
cat("
--- VALUE CLASSIFICATION DISTRIBUTION ---
")
print(ncb_dt[, .N, by = value_class])

# Save
fwrite(ncb_dt, output_path)
cat(sprintf("
Net Benefit Atlas saved to: %s
", output_path))
