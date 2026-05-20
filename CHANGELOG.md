# Changelog

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
