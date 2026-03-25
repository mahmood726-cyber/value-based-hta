# Value Based HTA Engine: concrete submission fixes

This file converts the multi-persona review into repository-side actions that should be checked before external submission of the F1000 software paper for `Value_Based_HTA_Engine`.

## Detectable Local State
- Documentation files detected: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Environment lock or container files detected: `environment.yml`.
- Package manifests detected: none detected.
- Example data files detected: `f1000_artifacts/example_dataset.csv`.
- Validation artifacts detected: `f1000_artifacts/validation_summary.md`.
- Detected public repository root: `https://github.com/mahmood726-cyber/value-based-hta`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/value-based-hta/tree/0752dc772dc1f297d4d3ce03e1b7c91e3f6e6b77`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.

## High-Priority Fixes
- Check that the manuscript's named example paths exist in the public archive and can be run without repository archaeology.
- Confirm that the cited repository root (`https://github.com/mahmood726-cyber/value-based-hta`) resolves to the same fixed public source snapshot used for submission.
- Archive the tagged release and insert the Zenodo DOI or record URL once it has been minted; no project-specific archive DOI was detected locally.
- Reconfirm the quoted benchmark or validation sentence after the final rerun so the narrative text matches the shipped artifacts.
- Keep the embedded WebR validation panel enabled in shipped HTML files and rerun it after any UI or calculation changes.

## Numeric Evidence Available To Quote
- `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.
- `paper/mces_manuscript_plos_one.md` reports Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance.

## Manuscript Files To Keep In Sync
- `F1000_Software_Tool_Article.md`
- `F1000_Reviewer_Rerun_Manifest.md`
- `F1000_MultiPersona_Review.md`
- `F1000_Submission_Checklist_RealReview.md` where present
- README/tutorial files and the public repository release metadata
