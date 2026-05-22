.PHONY: help install test pipeline phase1 phase2 clean

OUTPUT_DIR ?= output
INPUT ?= data/remediation_analysis_results.csv

help:
	@echo "Targets:"
	@echo "  install   pip-install Python test dependencies"
	@echo "  test      run pytest smoke and data-contract tests"
	@echo "  phase1    run semantic_outcome_mapper.R   -> $(OUTPUT_DIR)/outcome_mapping.csv"
	@echo "  phase2    run calculate_net_benefit.R     -> $(OUTPUT_DIR)/net_clinical_benefit.csv"
	@echo "  pipeline  phase1 + phase2"
	@echo "  clean     remove $(OUTPUT_DIR)"

install:
	python -m pip install -r requirements.txt

test:
	python -m pytest tests/ -v

phase1:
	VBHTA_INPUT=$(INPUT) VBHTA_OUTPUT_DIR=$(OUTPUT_DIR) Rscript semantic_outcome_mapper.R

phase2: phase1
	VBHTA_OUTPUT_DIR=$(OUTPUT_DIR) Rscript calculate_net_benefit.R \
		$(OUTPUT_DIR)/outcome_mapping.csv \
		$(OUTPUT_DIR)/unified_hta_validation.csv \
		$(OUTPUT_DIR)

pipeline: phase2

clean:
	rm -rf $(OUTPUT_DIR)
