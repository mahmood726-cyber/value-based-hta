# Value Based HTA Engine: multi-persona peer review

This memo applies the recurring concerns in the supplied peer-review document to the current F1000 draft for this project (`Value_Based_HTA_Engine`). It distinguishes changes already made in the draft from repository-side items that still need to hold in the released repository and manuscript bundle.

## Detected Local Evidence
- Detected documentation files: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Detected validation/test artifacts: `f1000_artifacts/validation_summary.md`.
- Detected browser deliverables: `HTA_Value_Dashboard.html`.
- Detected public repository root: `https://github.com/mahmood726-cyber/value-based-hta`.
- Detected public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/value-based-hta/tree/0752dc772dc1f297d4d3ce03e1b7c91e3f6e6b77`.
- Detected public archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.

## Reviewer Rerun Companion
- `F1000_Reviewer_Rerun_Manifest.md` consolidates the shortest reviewer-facing rerun path, named example files, environment capture, and validation checkpoints.

## Detected Quantitative Evidence
- `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.
- `paper/mces_manuscript_plos_one.md` reports Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance.

## Current Draft Strengths
- States the project rationale and niche explicitly: Systematic reviews often report efficacy and harm outcomes in separate silos, leaving HTA decisions to reconcile those signals manually. Reviewers of software papers increasingly expect automated tools to provide both the calculation and the interpretive caveats needed for benefit-harm synthesis.
- Names concrete worked-example paths: `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources; `HTA_Value_Dashboard.html` for the browser-facing result layer; `f1000_artifacts/example_dataset.csv` and tutorial materials for reviewer walkthroughs.
- Points reviewers to local validation materials: Manual validation samples and outcome-mapping checks described in the project manuscripts; `f1000_artifacts/validation_summary.md` for local reviewer guidance; Project protocol files documenting expected deliverables and linkage logic.
- Moderates conclusions and lists explicit limitations for Value Based HTA Engine.

## Remaining High-Priority Fixes
- Keep one minimal worked example public and ensure the manuscript paths match the released files.
- Ensure README/tutorial text, software availability metadata, and public runtime instructions stay synchronized with the manuscript.
- Confirm that the cited repository root resolves to the same fixed public source snapshot used for the submission package.
- Mint and cite a Zenodo DOI or record URL for the tagged release; none was detected locally.
- Reconfirm the quoted benchmark or validation sentence after the final rerun so the narrative text stays synchronized with the shipped artifacts.
- Keep the embedded WebR validation panel enabled in public HTML releases and rerun it after any UI or calculation changes.

## Persona Reviews

### Reproducibility Auditor
- Review question: Looks for a frozen computational environment, a fixed example input, and an end-to-end rerun path with saved outputs.
- What the revised draft now provides: The revised draft names concrete rerun assets such as `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources; `HTA_Value_Dashboard.html` for the browser-facing result layer and ties them to validation files such as Manual validation samples and outcome-mapping checks described in the project manuscripts; `f1000_artifacts/validation_summary.md` for local reviewer guidance.
- What still needs confirmation before submission: Before submission, freeze the public runtime with `environment.yml` and keep at least one minimal example input accessible in the external archive.

### Validation and Benchmarking Statistician
- Review question: Checks whether the paper shows evidence that outputs are accurate, reproducible, and compared against known references or stress tests.
- What the revised draft now provides: The manuscript now cites concrete validation evidence including Manual validation samples and outcome-mapping checks described in the project manuscripts; `f1000_artifacts/validation_summary.md` for local reviewer guidance; Project protocol files documenting expected deliverables and linkage logic and frames conclusions as being supported by those materials rather than by interface availability alone.
- What still needs confirmation before submission: Concrete numeric evidence detected locally is now available for quotation: `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms; `paper/mces_manuscript_plos_one.md` reports Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance.

### Methods-Rigor Reviewer
- Review question: Examines modeling assumptions, scope conditions, and whether method-specific caveats are stated instead of implied.
- What the revised draft now provides: The architecture and discussion sections now state the method scope explicitly and keep caveats visible through limitations such as Keyword-driven outcome mapping can miss relevant endpoints or oversimplify their meaning; Net clinical benefit calculations depend on scale comparability and simplifying assumptions about uncertainty.
- What still needs confirmation before submission: Retain method-specific caveats in the final Results and Discussion and avoid collapsing exploratory thresholds or heuristics into universal recommendations.

### Comparator and Positioning Reviewer
- Review question: Asks what gap the tool fills relative to existing software and whether the manuscript avoids unsupported superiority claims.
- What the revised draft now provides: The introduction now positions the software against an explicit comparator class: The comparison set includes qualitative GRADE-style benefit-harm discussion and ad hoc manual net-benefit calculations. The paper emphasizes automation, transparency, and interpretive caveats rather than sweeping claims of decisional superiority.
- What still needs confirmation before submission: Keep the comparator discussion citation-backed in the final submission and avoid phrasing that implies blanket superiority over better-established tools.

### Documentation and Usability Reviewer
- Review question: Looks for a README, tutorial, worked example, input-schema clarity, and short interpretation guidance for outputs.
- What the revised draft now provides: The revised draft points readers to concrete walkthrough materials such as `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources; `HTA_Value_Dashboard.html` for the browser-facing result layer; `f1000_artifacts/example_dataset.csv` and tutorial materials for reviewer walkthroughs and spells out expected outputs in the Methods section.
- What still needs confirmation before submission: Make sure the public archive exposes a readable README/tutorial bundle: currently detected files include `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.

### Software Engineering Hygiene Reviewer
- Review question: Checks for evidence of testing, deployment hygiene, browser/runtime verification, secret handling, and removal of obvious development leftovers.
- What the revised draft now provides: The draft now foregrounds regression and validation evidence via `f1000_artifacts/validation_summary.md`, and browser-facing projects are described as self-validating where applicable.
- What still needs confirmation before submission: Before submission, remove any dead links, exposed secrets, or development-stage text from the public repo and ensure the runtime path described in the manuscript matches the shipped code.

### Claims-and-Limitations Editor
- Review question: Verifies that conclusions are bounded to what the repository actually demonstrates and that limitations are explicit.
- What the revised draft now provides: The abstract and discussion now moderate claims and pair them with explicit limitations, including Keyword-driven outcome mapping can miss relevant endpoints or oversimplify their meaning; Net clinical benefit calculations depend on scale comparability and simplifying assumptions about uncertainty; The dashboard summarizes trade-offs but does not replace full economic modeling.
- What still needs confirmation before submission: Keep the conclusion tied to documented functions and artifacts only; avoid adding impact claims that are not directly backed by validation, benchmarking, or user-study evidence.

### F1000 and Editorial Compliance Reviewer
- Review question: Checks for manuscript completeness, software/data availability clarity, references, and reviewer-facing support files.
- What the revised draft now provides: The revised draft is more complete structurally and now points reviewers to software availability, data availability, and reviewer-facing support files.
- What still needs confirmation before submission: Confirm repository/archive metadata, figure/export requirements, and supporting-file synchronization before release.
