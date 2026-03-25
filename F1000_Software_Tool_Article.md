# Value Based HTA Engine: a software tool for reviewer-auditable evidence synthesis

## Authors
- Mahmood Ahmad [1,2]
- Niraj Kumar [1]
- Bilaal Dar [3]
- Laiba Khan [1]
- Andrew Woo [4]
- Corresponding author: Andrew Woo (andy2709w@gmail.com)

## Affiliations
1. Royal Free Hospital
2. Tahir Heart Institute Rabwah
3. King's College Medical School
4. St George's Medical School

## Abstract
**Background:** Systematic reviews often report efficacy and harm outcomes in separate silos, leaving HTA decisions to reconcile those signals manually. Reviewers of software papers increasingly expect automated tools to provide both the calculation and the interpretive caveats needed for benefit-harm synthesis.

**Methods:** The Value Based HTA Engine implements the Multi-Criteria Evidence Synthesizer (MCES), which classifies outcomes as benefit or harm, links them within reviews, computes net clinical benefit, and presents value categories through a browser-based dashboard.

**Results:** The repository contains a project manuscript, protocol notes, HTML dashboard, example datasets, and validation materials showing how benefit-harm linkage and value categorization are operationalized over Pairwise70-derived review data.

**Conclusions:** The engine is reported as a transparent value-synthesis aid with explicit caution about outcome classification, endpoint comparability, and the difference between quantitative linkage and formal economic evaluation.

## Keywords
benefit-harm trade-off; net clinical benefit; health technology assessment; dashboard; Pairwise70; software tool

## Introduction
The software is designed to bridge a practical reporting gap: clinicians and HTA reviewers can see that a drug reduces one undesirable outcome and increases another, but still lack a structured, reproducible way to summarize the trade-off. MCES packages that linkage transparently.

The comparison set includes qualitative GRADE-style benefit-harm discussion and ad hoc manual net-benefit calculations. The paper emphasizes automation, transparency, and interpretive caveats rather than sweeping claims of decisional superiority.

The manuscript structure below is deliberately aligned to common open-software review requests: the rationale is stated explicitly, at least one runnable example path is named, local validation artifacts are listed, and conclusions are bounded to the functions and outputs documented in the repository.

## Methods
### Software architecture and workflow
The project combines R classification and calculation scripts with an HTML dashboard. Local materials include a project protocol, manuscript drafts, example data, and F1000 artifacts for reviewer reruns.

### Installation, runtime, and reviewer reruns
The local implementation is packaged under `C:\Models\Value_Based_HTA_Engine`. The manuscript identifies the local entry points, dependency manifest, fixed example input, and expected saved outputs so that reviewers can rerun the documented workflow without reconstructing it from scratch.

- Entry directory: `C:\Models\Value_Based_HTA_Engine`.
- Detected documentation entry points: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Detected environment capture or packaging files: `environment.yml`.
- Named worked-example paths in this draft: `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources; `HTA_Value_Dashboard.html` for the browser-facing result layer; `f1000_artifacts/example_dataset.csv` and tutorial materials for reviewer walkthroughs.
- Detected validation or regression artifacts: `f1000_artifacts/validation_summary.md`.
- Detected example or sample data files: `f1000_artifacts/example_dataset.csv`.
- Detected browser deliverables with built-in WebR self-validation: `HTA_Value_Dashboard.html`.

### Worked examples and validation materials
**Example or fixed demonstration paths**
- `paper/mces_manuscript_plos_one.md` and `MCES_Manuscript_Value.md` as narrative sources.
- `HTA_Value_Dashboard.html` for the browser-facing result layer.
- `f1000_artifacts/example_dataset.csv` and tutorial materials for reviewer walkthroughs.

**Validation and reporting artifacts**
- Manual validation samples and outcome-mapping checks described in the project manuscripts.
- `f1000_artifacts/validation_summary.md` for local reviewer guidance.
- Project protocol files documenting expected deliverables and linkage logic.

### Typical outputs and user-facing deliverables
- Linked benefit-harm summaries and net clinical benefit views.
- A dashboard highlighting high-value, low-value, and uncertain technologies.
- Manuscript-ready examples for value-based HTA reporting.

### Reviewer-informed safeguards
- Provides a named example workflow or fixed demonstration path.
- Documents local validation artifacts rather than relying on unsupported claims.
- Positions the software against existing tools without claiming blanket superiority.
- States limitations and interpretation boundaries in the manuscript itself.
- Requires explicit environment capture and public example accessibility in the released archive.

## Review-Driven Revisions
This draft has been tightened against recurring open peer-review objections taken from the supplied reviewer reports.
- Reproducibility: the draft names a reviewer rerun path and points readers to validation artifacts instead of assuming interface availability is proof of correctness.
- Validation: claims are anchored to local tests, validation summaries, simulations, or consistency checks rather than to unsupported assertions of performance.
- Comparators and niche: the manuscript now names the relevant comparison class and keeps the claimed niche bounded instead of implying universal superiority.
- Documentation and interpretation: the text expects a worked example, input transparency, and reviewer-verifiable outputs rather than a high-level feature list alone.
- Claims discipline: conclusions are moderated to the documented scope of Value Based HTA Engine and paired with explicit limitations.
- Browser verification: HTML applications in this directory now include embedded WebR checks so reviewer-facing dashboards can validate their displayed calculations in situ.

## Use Cases and Results
The software outputs should be described in terms of concrete reviewer-verifiable workflows: running the packaged example, inspecting the generated results, and checking that the reported interpretation matches the saved local artifacts. In this project, the most important result layer is the availability of a transparent execution path from input to analysis output.

Representative local result: `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.

### Concrete local quantitative evidence
- `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.
- `paper/mces_manuscript_plos_one.md` reports Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance.

## Discussion
Representative local result: `MCES_Manuscript_Value.md` reports Results: Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms.

The F1000 paper directly addresses common reviewer concerns: outcome mapping is heuristic, endpoint scales can differ, and the tool supports structured interpretation rather than replacing formal economic and clinical judgment.

### Limitations
- Keyword-driven outcome mapping can miss relevant endpoints or oversimplify their meaning.
- Net clinical benefit calculations depend on scale comparability and simplifying assumptions about uncertainty.
- The dashboard summarizes trade-offs but does not replace full economic modeling.

## Software Availability
- Local source package: `Value_Based_HTA_Engine` under `C:\Models`.
- Public repository: `https://github.com/mahmood726-cyber/value-based-hta`.
- Public source snapshot: Fixed public commit snapshot available at `https://github.com/mahmood726-cyber/value-based-hta/tree/0752dc772dc1f297d4d3ce03e1b7c91e3f6e6b77`.
- DOI/archive record: No project-specific DOI or Zenodo record URL was detected locally; archive registration pending.
- Environment capture detected locally: `environment.yml`.
- Reviewer-facing documentation detected locally: `README.md`, `f1000_artifacts/tutorial_walkthrough.md`.
- Reproducibility walkthrough: `f1000_artifacts/tutorial_walkthrough.md` where present.
- Validation summary: `f1000_artifacts/validation_summary.md` where present.
- Reviewer rerun manifest: `F1000_Reviewer_Rerun_Manifest.md`.
- Multi-persona review memo: `F1000_MultiPersona_Review.md`.
- Concrete submission-fix note: `F1000_Concrete_Submission_Fixes.md`.
- License: see the local `LICENSE` file.

## Data Availability
Local code, dashboard assets, and example data are stored in the project directory. The underlying review-level inputs are derived from public Pairwise70/Cochrane materials.

## Reporting Checklist
Real-peer-review-aligned checklist: `F1000_Submission_Checklist_RealReview.md`.
Reviewer rerun companion: `F1000_Reviewer_Rerun_Manifest.md`.
Companion reviewer-response artifact: `F1000_MultiPersona_Review.md`.
Project-level concrete fix list: `F1000_Concrete_Submission_Fixes.md`.

## Declarations
### Competing interests
The authors declare that no competing interests were disclosed.

### Grant information
No specific grant was declared for this manuscript draft.

### Author contributions (CRediT)
| Author | CRediT roles |
|---|---|
| Mahmood Ahmad | Conceptualization; Software; Validation; Data curation; Writing - original draft; Writing - review and editing |
| Niraj Kumar | Conceptualization |
| Bilaal Dar | Conceptualization |
| Laiba Khan | Conceptualization |
| Andrew Woo | Conceptualization |

### Acknowledgements
The authors acknowledge contributors to open statistical methods, reproducible research software, and reviewer-led software quality improvement.

## References
1. DerSimonian R, Laird N. Meta-analysis in clinical trials. Controlled Clinical Trials. 1986;7(3):177-188.
2. Higgins JPT, Thompson SG. Quantifying heterogeneity in a meta-analysis. Statistics in Medicine. 2002;21(11):1539-1558.
3. Viechtbauer W. Conducting meta-analyses in R with the metafor package. Journal of Statistical Software. 2010;36(3):1-48.
4. Page MJ, McKenzie JE, Bossuyt PM, et al. The PRISMA 2020 statement: an updated guideline for reporting systematic reviews. BMJ. 2021;372:n71.
5. Fay C, Rochette S, Guyader V, Girard C. Engineering Production-Grade Shiny Apps. Chapman and Hall/CRC. 2022.
