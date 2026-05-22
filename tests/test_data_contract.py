"""Verify the input CSV the R pipeline depends on has the expected schema.

This catches data-format regressions in CI even when R is not installed.
"""
import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INPUT_CSV = ROOT / 'data' / 'remediation_analysis_results.csv'

# Columns consumed by semantic_outcome_mapper.R / calculate_net_benefit.R.
REQUIRED_COLUMNS = {
    'dataset_name',
    'analysis_name',
    'method',
    'pooled_effect',
    'pooled_se',
    'q_p',
}


def test_input_csv_exists():
    assert INPUT_CSV.is_file(), f"missing {INPUT_CSV.relative_to(ROOT)}"


def test_input_csv_schema():
    with INPUT_CSV.open(newline='', encoding='utf-8') as fh:
        reader = csv.reader(fh)
        header = next(reader)
        first_row = next(reader, None)

    missing = REQUIRED_COLUMNS - set(header)
    assert not missing, f"input CSV is missing required columns: {sorted(missing)}"
    assert first_row, "input CSV must contain at least one data row"
    assert len(first_row) == len(header), "first row column count mismatch with header"
