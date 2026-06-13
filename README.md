# Value Based HTA Engine

An R toolkit for two-step value-based health technology assessment over
meta-analytic review data: (1) semantic mapping of clinical endpoints into
Benefit vs Harm, and (2) Net Clinical Benefit (NCB) synthesis that pairs the
strongest benefit and harm signal per review and assigns a value class.

## Installation
Create the environment from `environment.yml` (conda; provides R 4.3 with
`data.table`/`dplyr`/`stringr` plus Python 3.11 for the tests).
Document any package-version mismatch encountered during first run.

## Quick Start
1. `Rscript semantic_outcome_mapper.R` — classifies endpoints in
   `data/remediation_analysis_results.csv` and writes `output/outcome_mapping.csv`.
2. `Rscript calculate_net_benefit.R` — synthesises benefit/harm pairs into
   `output/net_clinical_benefit.csv`.
3. Open `HTA_Value_Dashboard.html` to inspect the value-class landscape.

Input and output paths default to repo-relative locations and can be overridden
with the `VBHTA_INPUT`, `VBHTA_OUTPUT_DIR`, `VBHTA_MAP_FILE`,
`VBHTA_QUALITY_FILE`, and `VBHTA_NCB_FILE` environment variables.

## F1000 Package
- Manuscript: `F1000_Software_Tool_Article.md`
- Submission checklist: `F1000_Submission_Checklist_RealReview.md`
