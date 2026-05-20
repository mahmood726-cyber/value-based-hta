# Value-Based HTA Engine

A software tool for reproducible benefit–harm evidence synthesis and
net-clinical-benefit (NCB) scoring for Health Technology Assessment.
The pipeline ingests pre-pooled meta-analytic estimates from Cochrane reviews,
classifies each outcome as a benefit or a harm, pairs the strongest signal of
each type per review, and produces a value-class verdict per technology.

- Live dashboard: <https://mahmood726-cyber.github.io/value-based-hta/>
- Manuscript: [`F1000_Software_Tool_Article.md`](F1000_Software_Tool_Article.md)
- Submission package: [`e156-submission/`](e156-submission/)

## Repository layout

| Path | Description |
| --- | --- |
| `semantic_outcome_mapper.R` | Phase 1: classify outcomes as `BENEFIT`, `HARM`, or `OTHER`. |
| `calculate_net_benefit.R`   | Phase 2: pair strongest benefit/harm per review and compute NCB. |
| `data/`                     | Input meta-analytic estimates (Pairwise70 Cochrane subset). |
| `HTA_Value_Dashboard.html`  | Standalone interactive dashboard. |
| `e156-submission/`          | E156 micro-paper bundle (paper, protocol, config, assets). |
| `tests/`                    | Smoke tests verifying the submission bundle is self-consistent. |

## Installation

A conda environment file is provided. To create it:

```bash
conda env create -f environment.yml
conda activate value-based-hta-reviewer
```

If you only need the Python smoke tests, `pip install -r requirements.txt` is
sufficient. R dependencies (`data.table`, `dplyr`, `stringr`, `jsonlite`,
`readr`) can be installed with:

```r
install.packages(c("data.table", "dplyr", "stringr", "jsonlite", "readr"))
```

## Running the pipeline

Both R scripts resolve paths relative to the repository root by default, so
they work without configuration:

```bash
Rscript semantic_outcome_mapper.R
Rscript calculate_net_benefit.R
```

Override input/output locations via positional arguments or environment
variables (useful in CI):

```bash
VBHTA_INPUT=/path/to/results.csv \
VBHTA_OUTPUT_DIR=/tmp/vbhta-out \
Rscript semantic_outcome_mapper.R

Rscript calculate_net_benefit.R /tmp/vbhta-out/outcome_mapping.csv \
                                /path/to/unified_hta_validation.csv \
                                /tmp/vbhta-out
```

The Phase 2 quality file is optional; without it, value classification still
runs but skips the Gold-Standard / Premature refinement.

Outputs land in `output/` by default:

- `output/outcome_mapping.csv` — every analysis row annotated with `sentiment`.
- `output/net_clinical_benefit.csv` — one row per review with paired
  benefit/harm estimates, `ncb_raw`, and a `value_class` verdict.

## Tests

```bash
python -m pytest tests/
```

The smoke test asserts that the E156 submission bundle exists, has the
required files, and that `config.json` has the contractually-fixed 156-word
body and seven sentence roles.

## Citation

See [`.zenodo.json`](.zenodo.json) for release metadata; cite the Zenodo DOI
once minted from the next public GitHub release.

## License

[MIT](LICENSE) © 2026 Mahmood Ahmad.
