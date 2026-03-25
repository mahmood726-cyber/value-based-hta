# Value Based HTA Engine: reviewer rerun manifest

This manifest is the shortest reviewer-facing rerun path for the local software package. It lists the files that should be sufficient to recreate one worked example, inspect saved outputs, and verify that the manuscript claims remain bounded to what the repository actually demonstrates.

## Reviewer Entry Points
- Project directory: `C:\Models\Value_Based_HTA_Engine`.
- Preferred documentation start points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected public repository root: `https://github.com/mahmood726-cyber/value-based-hta`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/value-based-hta/tree/0752dc772dc1f297d4d3ce03e1b7c91e3f6e6b77`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture files: `environment.yml`.
- Validation/test artifacts: `f1000_artifacts/validation_summary.md`.

## Worked Example Inputs
- Manuscript-named example paths: `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources; `HTA_Value_Dashboard.html` for the browser-facing result layer; `f1000_artifacts/example_dataset.csv` and tutorial materials for reviewer walkthroughs; f1000_artifacts/example_dataset.csv.
- Auto-detected sample/example files: `f1000_artifacts/example_dataset.csv`.

## Expected Outputs To Inspect
- Linked benefit-harm summaries and net clinical benefit views.
- A dashboard highlighting high-value, low-value, and uncertain technologies.
- Manuscript-ready examples for value-based HTA reporting.

## Minimal Reviewer Rerun Sequence
- Start with the README/tutorial files listed below and keep the manuscript paths synchronized with the public archive.
- Create the local runtime from the detected environment capture files if available: `environment.yml`.
- Run at least one named example path from the manuscript and confirm that the generated outputs match the saved validation materials.
- Quote one concrete numeric result from the local validation snippets below when preparing the final software paper.
- Open the browser deliverable and confirm that the embedded WebR validation panel completes successfully after the page finishes initializing.

## Local Numeric Evidence Available
- `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.
- `paper/mces_manuscript_plos_one.md` reports Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance.

## Browser Deliverables
- HTML entry points: `HTA_Value_Dashboard.html`.
- The shipped HTML applications include embedded WebR self-validation and should be checked after any UI or calculation change.
