# Changelog

## 2026-05-20 (round 2)
- Removed remaining `C:\Models\Value_Based_HTA_Engine` Windows-path leaks from
  `F1000_Software_Tool_Article.md`, `F1000_Reviewer_Rerun_Manifest.md`,
  `F1000_Submission_Checklist_RealReview.md`, and `MCES_Manuscript_Value.md`.
- Fixed the remaining wrong GitHub link in `e156-submission/assets/index.html`
  and the dashboard URL in `E156-PROTOCOL.md`.
- Added `CITATION.cff` (referenced by `push.sh` but previously absent).
- Added `.editorconfig` for consistent indentation.
- Hardened smoke tests: split into focused cases, removed unreachable
  fallback branch, and added a regression test that fails if Windows paths
  ever reappear in the R scripts.
- Added `tests/test_data_contract.py` verifying the input CSV the R pipeline
  consumes has the expected schema (runs in CI without needing R).
- CI now also runs `Rscript -e 'parse(...)'` against both R scripts to catch
  syntax errors on every push.

## 2026-05-20
- Portability fix: `semantic_outcome_mapper.R` and `calculate_net_benefit.R`
  now resolve paths relative to the repository root and accept CLI args or
  `VBHTA_*` environment variables instead of hard-coded Windows paths.
- `calculate_net_benefit.R` no longer hard-fails when the optional quality
  file is missing.
- `push.sh` pushes to the current branch (not hard-coded `master`/`main`)
  and no longer prefers `git.exe`.
- Fixed broken GitHub link in `index.html` (`value-based-hta-engine` →
  `value-based-hta`).
- Removed local Windows path from `.zenodo.json` description.
- Added `requirements.txt` and a GitHub Actions workflow that runs the
  pytest smoke suite on every push and PR.
- Rewrote `README.md` with repository layout, install steps, runnable
  pipeline commands, and test instructions.

## 2026-03-06
- Added F1000 software tool manuscript package.
- Added real-review-aligned submission checklist.
- Added metadata files for reproducibility readiness.
