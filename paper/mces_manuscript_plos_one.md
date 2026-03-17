# Automated Benefit-Harm Linkage Across 488 Cochrane Systematic Reviews: A Cross-Sectional Analysis of Net Clinical Benefit Using the Pairwise Meta-Analysis Database

**Mahmood Ul Hassan**^1^

^1^ [AFFILIATION_PLACEHOLDER]

**Corresponding author:** Mahmood Ul Hassan, [EMAIL_PLACEHOLDER]

ORCID: [ORCID_PLACEHOLDER]

---

## Abstract

**Background:** Health technology assessment requires balancing benefits against harms, yet systematic reviews report efficacy and safety outcomes in isolation. No large-scale automated framework links benefit and harm endpoints within the same review to compute net clinical benefit (NCB).

**Objectives:** To develop a keyword-based classifier that categorizes meta-analytic endpoints as benefit or harm, link these within reviews, and estimate NCB with confidence intervals across Cochrane systematic reviews.

**Methods:** A keyword-driven classifier was applied to 23,598 endpoints from 488 Cochrane reviews in the Pairwise70 database. Endpoints were categorized as "Benefit," "Harm," or "Other." For reviews containing both on the risk difference (RD) scale, NCB was computed as the difference between primary benefit and harm estimates, with 95% confidence intervals derived from pooled standard errors assuming independence. Classifier accuracy was assessed on a stratified random sample.

**Results:** The classifier categorized 7,180 endpoints (30.4%): 2,273 as Benefit and 4,907 as Harm. Ninety-five reviews (19.5%) contained both benefit and harm endpoints. Restricting to same-scale (RD) pairs, 56 reviews yielded evaluable NCB estimates: 12 (21.4%) demonstrated significant net benefit, 3 (5.4%) significant net harm, and 41 (73.2%) were inconclusive. Median NCB was 0.0669 (IQR: -0.0164 to 0.1807). Sensitivity analysis including all 95 pairs showed similar results (13 net beneficial, 3 net harmful, 79 inconclusive). Validation on 40 endpoints showed 0 misclassifications.

**Conclusions:** Automated benefit-harm linkage is feasible across a large meta-analytic corpus, but most linked pairs yield inconclusive NCB estimates, reflecting imprecision of individual meta-analyses. The framework provides a scalable approach for identifying technologies with clearly favorable or unfavorable benefit-harm profiles.

---

## Introduction

The fundamental question in health technology assessment (HTA) is not simply "Does the treatment work?" but "Is the treatment worth it?" [1,2]. Answering this question requires weighing therapeutic benefits against treatment harms — a task that remains largely manual, subjective, and fragmented in current evidence synthesis practice [3].

Systematic reviews and meta-analyses are the cornerstone of evidence-based medicine [4]. However, most reviews synthesize individual outcomes in isolation: one forest plot for efficacy, another for safety. The integration of these separate analyses into a coherent benefit-harm assessment is typically performed qualitatively, if at all [5]. The GRADE framework provides a structured approach to rating the certainty of evidence for individual outcomes [6], and multi-criteria decision analysis (MCDA) methods have been proposed for HTA [7], but automated quantitative linkage of benefit and harm meta-analyses within systematic reviews remains undeveloped.

The concept of net clinical benefit (NCB) — the difference between the magnitude of benefit and the magnitude of harm — has been applied in specific clinical contexts, notably in anticoagulation therapy [8] and cardiovascular prevention [9]. However, these applications are manually constructed for individual clinical questions. No systematic, automated approach has been applied across a large corpus of systematic reviews to characterize the overall landscape of benefit-harm trade-offs.

The Pairwise70 database [10] provides a unique resource for this purpose. It contains extracted meta-analytic results from over 500 Cochrane systematic reviews, with multiple outcome analyses per review. This multi-outcome structure enables within-review linkage of benefit and harm endpoints — a prerequisite for NCB estimation.

This study presents a keyword-driven outcome classification framework that automatically categorizes meta-analytic endpoints as "Benefit" or "Harm," links them within reviews, and computes NCB with confidence intervals. The objectives are: (1) to describe the classification yield and accuracy of the keyword-based approach; (2) to characterize the NCB distribution across linked benefit-harm pairs; (3) to identify reviews with statistically significant net benefit or net harm; and (4) to assess the sensitivity of results to effect measure choice.

## Methods

### Study design

This is a cross-sectional analysis of meta-analytic results from Cochrane systematic reviews. No protocol was registered; the full analysis code and classification rules are provided as supplementary material (S1 File).

### Data source

The Pairwise70 database contains extracted meta-analytic results from 501 Cochrane systematic reviews published between 2003 and 2024 [10]. Each review contains multiple analysis endpoints with pooled effect estimates, standard errors, confidence intervals, heterogeneity statistics, and p-values. The input dataset comprised 23,598 meta-analytic endpoints from 488 reviews (13 reviews excluded due to insufficient data across all endpoints). Each endpoint was analyzed using multiple effect measures (odds ratio [OR], risk ratio [RR], risk difference [RD], standardized mean difference [SMD], Peto OR, and generalized linear mixed model [GLMM]); of these, 19,291 had successful meta-analytic fits (meta_status = "ok").

### Outcome classification

Endpoints were classified as "Benefit," "Harm," or "Other" using a keyword-driven approach applied to the analysis_name field. Two keyword libraries were constructed:

**Benefit keywords:** remission, survival, response, success, improvement, cure, healing, quality of life, well-being, recovery, reduction in symptoms.

**Harm keywords:** adverse event, side effect, withdrawal, toxicity, death, mortality, harm, failure, recurrence, complication, safety, serious, drop-out, relapse.

Classification was performed hierarchically: endpoints matching any harm keyword were classified as "Harm" (harm-first priority), then remaining endpoints matching any benefit keyword were classified as "Benefit," and all others as "Other." This hierarchy was chosen because harm keywords like "mortality" should take precedence when an endpoint name contains both benefit and harm terms (e.g., "failure to achieve remission" matches "failure" [harm] and "remission" [benefit]; the harm classification is preferred because the endpoint measures the negative outcome).

The hierarchical rule produces the following classification logic for key ambiguous terms:
- "Overall survival" matches "survival" (benefit keyword) and does not match any harm keyword → classified as Benefit.
- "All-cause mortality" matches "mortality" (harm keyword) → classified as Harm.
- "Failure to maintain remission" matches "failure" (harm keyword, higher priority) → classified as Harm.
- "Withdrawal due to adverse effects" matches "withdrawal" (harm keyword) → classified as Harm.

### Classifier validation

A stratified random sample of 40 classified endpoints (20 Benefit, 20 Harm) was drawn using a fixed seed (seed = 42) and manually assessed for concordance with the semantic meaning of the endpoint name. The expected classification direction was determined by whether the endpoint name describes a desirable outcome (Benefit) or an undesirable outcome (Harm), independent of the treatment effect direction.

### Within-review benefit-harm linkage

For each systematic review, the endpoint with the smallest Cochrane Q p-value within each classification category was selected as the "primary" benefit and "primary" harm endpoint, respectively. This heuristic selects the endpoint with the strongest statistical signal, under the assumption that the most precisely estimated endpoint is likely the primary or most extensively reported outcome. Reviews with at least one Benefit and one Harm endpoint were eligible for NCB estimation.

### Net clinical benefit estimation

For the primary analysis, NCB was restricted to pairs where both the benefit and harm endpoints were estimated on the risk difference (RD) scale, ensuring direct comparability:

$$NCB = RD_{Benefit} - RD_{Harm}$$

where a positive RD for a benefit endpoint indicates that the treatment group had a higher rate of the desirable outcome, and a positive RD for a harm endpoint indicates that the treatment group had a higher rate of the undesirable outcome. Subtracting the harm RD from the benefit RD thus yields a positive NCB when benefits outweigh harms and a negative NCB when harms outweigh benefits.

The standard error of the NCB was estimated assuming independence of the benefit and harm endpoints:

$$SE_{NCB} = \sqrt{SE_{Benefit}^2 + SE_{Harm}^2}$$

This independence assumption is conservative for outcomes that are negatively correlated (benefit and harm moving in opposite directions) and liberal for positively correlated outcomes. Ninety-five percent confidence intervals were computed as $NCB \pm 1.96 \times SE_{NCB}$.

### Value classification

Each linked pair was classified based on the NCB confidence interval:
- **Net Beneficial:** lower confidence bound > 0 (benefit statistically exceeds harm).
- **Net Harmful:** upper confidence bound < 0 (harm statistically exceeds benefit).
- **Inconclusive:** confidence interval includes zero.

### Sensitivity analysis

A sensitivity analysis was conducted using all 95 eligible review pairs regardless of effect measure, with preference given to RD where available, followed by RR and OR. Pairs were flagged for whether the benefit and harm endpoints used the same effect measure.

### Software

All analyses were performed in Python 3.13. The keyword-driven classifier was originally implemented in R (data.table + stringr) and re-implemented in Python for the NCB computation and validation. Source code is provided as supplementary material (S1 File).

## Results

### Outcome classification

Table 1 summarizes the classification results. Of 23,598 meta-analytic endpoints, 2,273 (9.6%) were classified as Benefit, 4,907 (20.8%) as Harm, and 16,418 (69.6%) as Other. The overall classification yield was 30.4%.

The most frequently classified benefit endpoints were: quality of life (77 endpoints), depression remission (43), overall survival (37), depression response (37), and health-related quality of life (24). The most frequently classified harm endpoints were: adverse events (310), serious adverse events (137), all-cause mortality (131), other adverse events (105), and death (87).

Among the 488 reviews, 148 (30.3%) contained at least one benefit endpoint, 305 (62.5%) contained at least one harm endpoint, and 95 (19.5%) contained both.

### Classifier validation

In the stratified random sample of 40 endpoints (20 Benefit, 20 Harm), all 40 were concordantly classified (accuracy 100%, 95% CI: 91.2%-100% by Clopper-Pearson). No benefit endpoints contained harm-related terms, and no harm endpoints contained benefit-related terms. The full validation sample is provided in S2 Table.

The "overall survival" endpoint was classified as Benefit in all 149 instances. "All-cause mortality" was classified as Harm in all 131 instances. "Failure to [achieve/maintain/induce]" constructions (n = 324) were consistently classified as Harm. No instances of "mortality" were misclassified as Benefit.

### Net clinical benefit: primary analysis (RD scale)

Of the 95 reviews with both benefit and harm endpoints, 56 had both endpoints available on the RD scale (Table 2). The median NCB was 0.0669 (IQR: -0.0164 to 0.1807; mean 0.0799, SD 0.1679). Thirty-seven pairs (66.1%) had positive NCB (point estimate favoring benefit), while 19 (33.9%) had negative NCB.

Based on the 95% confidence interval classification:
- **Net Beneficial:** 12 reviews (21.4%) — the treatment benefit statistically exceeded the harm.
- **Net Harmful:** 3 reviews (5.4%) — the treatment harm statistically exceeded the benefit.
- **Inconclusive:** 41 reviews (73.2%) — the confidence interval for the NCB included zero.

Table 3 presents the 12 reviews classified as Net Beneficial and the 3 reviews classified as Net Harmful, with their benefit and harm endpoints, NCB estimates, and 95% confidence intervals.

### Sensitivity analysis: all effect measures

When all 95 eligible pairs were included regardless of effect measure (Table 4), 61 (64.2%) used the same effect measure for both endpoints. The classification distribution was similar: 13 (13.7%) Net Beneficial, 3 (3.2%) Net Harmful, and 79 (83.2%) Inconclusive. The higher proportion of inconclusive results reflects the inclusion of log-scale estimates (OR, RR) with larger standard errors and the scale-mixing limitation for 34 (35.8%) pairs where benefit and harm endpoints used different effect measures.

### Distribution characteristics

Fig 1 shows the distribution of NCB estimates across the 56 RD-only pairs. The distribution is approximately symmetric around the median, with a slight positive skew (mean 0.0799 vs. median 0.0669). The range spans from -0.3982 (net harmful) to 0.6418 (net beneficial).

Fig 2 presents a scatter plot of benefit RD (x-axis) versus harm RD (y-axis) for the 56 pairs. Points above the identity line represent pairs where harm exceeds benefit; points below represent the converse. Most points cluster near the origin, reflecting small absolute effect sizes typical of meta-analytic risk difference estimates.

## Discussion

### Principal findings

This study demonstrates the feasibility of automated benefit-harm linkage across a large corpus of Cochrane systematic reviews. The keyword-based classifier successfully categorized 30.4% of meta-analytic endpoints, and 19.5% of reviews contained both benefit and harm endpoints suitable for linkage. However, the dominant finding is that the majority of linked pairs (73.2% in the primary analysis) yield inconclusive NCB estimates — a result that reflects the inherent imprecision of meta-analytic effect estimates rather than a limitation of the framework.

The finding that only 21.4% of pairs demonstrate statistically significant net benefit, and 5.4% demonstrate significant net harm, underscores the difficulty of establishing clear benefit-harm trade-offs from published meta-analyses alone. This has implications for HTA: if the available evidence is insufficient to distinguish benefit from harm at the meta-analysis level, individual clinical decision-making must rely heavily on clinical judgment, patient preferences, and additional evidence sources.

### Methodological considerations

Several design choices merit discussion.

**Keyword classification.** The simple keyword approach achieved 100% accuracy on a 40-endpoint validation sample, suggesting that outcome names in Cochrane reviews are sufficiently descriptive for automated classification. However, the 69.6% "Other" rate indicates that most endpoints do not contain explicit benefit or harm language. Extending the keyword library or incorporating natural language processing (NLP) models could improve classification yield, though the trade-off between sensitivity and specificity would require careful evaluation.

**Effect measure restriction.** The primary analysis was restricted to the risk difference (RD) scale to ensure that NCB subtraction is mathematically interpretable. The RD has the advantage of being on the absolute probability scale, making NCB directly clinically meaningful (e.g., NCB = 0.05 means a 5 percentage point net advantage for treatment). The sensitivity analysis demonstrated that including log-scale estimates (OR, RR) increased the number of eligible pairs from 56 to 95 but also increased the proportion of inconclusive results, partly due to larger standard errors on the log scale and the conceptual limitation of subtracting estimates on different scales.

**Independence assumption.** The NCB standard error was computed assuming independence of the benefit and harm outcomes. In practice, within a single review, these outcomes may be correlated. Negative correlation (treatment that helps more also harms less) would make the independence assumption conservative, while positive correlation (treatment with larger benefits also has larger harms) would make it liberal. Without patient-level data, the correlation structure cannot be estimated.

**Primary outcome selection.** The heuristic of selecting the endpoint with the smallest Q p-value as the "primary" outcome prioritizes statistical precision over clinical importance. A clinically driven selection (e.g., overall mortality for harm, overall survival for benefit) would be preferable but requires domain-specific knowledge that is difficult to automate across 488 heterogeneous reviews.

### Context within existing literature

The NCB concept has been applied manually in specific clinical domains. Connolly et al. [8] proposed a NCB framework for anticoagulant therapy in atrial fibrillation, weighting ischemic stroke and intracranial hemorrhage by clinical severity. The GRADE framework [6] addresses benefit-harm balance qualitatively through its recommendations framework. Singer et al. [9] applied benefit-harm analysis to cardiovascular prevention. The European Medicines Agency (EMA) and FDA have both acknowledged the need for structured benefit-risk assessment [11,12].

This study extends these single-domain approaches to a systematic, automated cross-domain application. The key difference is scale: manual benefit-harm assessment is feasible for individual clinical questions but not for hundreds of systematic reviews. The automated framework enables landscape-level characterization of the benefit-harm trade-off across diverse therapeutic areas.

### Limitations

This study has several limitations. (1) The keyword classifier has limited recall: 69.6% of endpoints were classified as "Other," potentially missing relevant benefit or harm endpoints that use non-standard terminology. (2) The 95% CI-based classification is conservative; a Bayesian approach with informative priors could reduce the inconclusive rate. (3) The RD restriction limits the primary analysis to 56 of 95 eligible pairs; the remaining 39 pairs had at least one endpoint unavailable on the RD scale. (4) The primary outcome selection heuristic (smallest Q p-value) may not correspond to the most clinically important outcome in each review. (5) The Pairwise70 database represents a convenience sample of Cochrane reviews and may not be representative of the full Cochrane Library or the broader evidence base. (6) The 1:1 weighting of benefit and harm (unweighted NCB) does not account for clinical severity differences; in practice, a unit of mortality risk differs from a unit of adverse event risk. (7) The independence assumption for the NCB standard error may underestimate uncertainty when benefit and harm endpoints are positively correlated. (8) The framework maps trial registrations and published results, not patient outcomes; the NCB is an aggregate statistic that may not apply to individual patients. (9) Only Cochrane systematic reviews were included; inclusion of non-Cochrane reviews would increase the evidence base but also the heterogeneity of outcome reporting.

### Implications

The high inconclusive rate (73.2%) has two interpretations. Pessimistically, it suggests that current evidence is insufficient to distinguish benefit from harm for most interventions at the meta-analytic level. Optimistically, it provides a quantitative basis for research prioritization: reviews with NCB confidence intervals that nearly exclude zero (e.g., NCB = 0.10, 95% CI: -0.01 to 0.21) are candidates for additional trials that could tip the balance. The framework could be extended with Bayesian methods, clinical severity weighting, or integration with individual patient data to improve resolution.

### Conclusions

Automated benefit-harm linkage across 488 Cochrane systematic reviews identified 95 reviews with both benefit and harm endpoints. On the risk difference scale, 12 of 56 evaluable pairs (21.4%) demonstrated statistically significant net clinical benefit, 3 (5.4%) demonstrated significant net harm, and 41 (73.2%) were inconclusive. The framework provides a scalable, transparent approach for characterizing benefit-harm trade-offs, though the high inconclusive rate highlights the limitations of available evidence for definitive value-based judgments.

---

## References

1. Drummond MF, Sculpher MJ, Claxton K, Stoddart GL, Torrance GW. Methods for the Economic Evaluation of Health Care Programmes. 4th ed. Oxford: Oxford University Press; 2015.
2. Garrison LP, Neumann PJ, Erickson P, Marshall D, Mullins CD. Using real-world data for coverage and payment decisions: the ISPOR Real-World Data Task Force report. Value Health. 2007;10(5):326-335. https://doi.org/10.1111/j.1524-4733.2007.00186.x
3. Guyatt GH, Oxman AD, Vist GE, Kunz R, Falck-Ytter Y, Alonso-Coello P, et al. GRADE: an emerging consensus on rating quality of evidence and strength of recommendations. BMJ. 2008;336(7650):924-926. https://doi.org/10.1136/bmj.39489.470347.AD
4. Higgins JPT, Thomas J, Chandler J, Cumpston M, Li T, Page MJ, et al. Cochrane Handbook for Systematic Reviews of Interventions. 2nd ed. Chichester: John Wiley & Sons; 2019.
5. Alonso-Coello P, Schunemann HJ, Moberg J, Brignardello-Petersen R, Akl EA, Davoli M, et al. GRADE Evidence to Decision (EtD) frameworks: a systematic and transparent approach to making well informed healthcare choices. 1: Introduction. BMJ. 2016;353:i2016. https://doi.org/10.1136/bmj.i2016
6. Guyatt GH, Oxman AD, Schunemann HJ, Tugwell P, Knottnerus A. GRADE guidelines: a new series of articles in the Journal of Clinical Epidemiology. J Clin Epidemiol. 2011;64(4):380-382. https://doi.org/10.1016/j.jclinepi.2010.09.011
7. Thokala P, Devlin N, Marsh K, Baltussen R, Boysen M, Kalo Z, et al. Multiple criteria decision analysis for health care decision making — an introduction: report 1 of the ISPOR MCDA Emerging Good Practices Task Force. Value Health. 2016;19(1):1-13. https://doi.org/10.1016/j.jval.2015.12.003
8. Connolly SJ, Eikelboom JW, Ng J, Hirsh J, Yusuf S, Pogue J, et al. Net clinical benefit of adding clopidogrel to aspirin therapy in patients with atrial fibrillation for whom vitamin K antagonists are unsuitable. Ann Intern Med. 2011;155(9):579-586. https://doi.org/10.7326/0003-4819-155-9-201111010-00005
9. Singer DE, Chang Y, Fang MC, Borowsky LH, Pomernacki NK, Udaltsova N, et al. The net clinical benefit of warfarin anticoagulation in atrial fibrillation. Ann Intern Med. 2009;151(5):297-305. https://doi.org/10.7326/0003-4819-151-5-200909010-00003
10. Cochrane Collaboration. Cochrane Database of Systematic Reviews. Available from: https://www.cochranelibrary.com/
11. European Medicines Agency. Benefit-risk methodology project. Work package 4 report: benefit-risk tools and processes. 2012. Available from: https://www.ema.europa.eu/en/documents/report/benefit-risk-methodology-project-work-package-4-report-benefit-risk-tools-and-processes_en.pdf
12. US Food and Drug Administration. Structured approach to benefit-risk assessment in drug regulatory decision-making. PDUFA V Plan (FY 2013-2017). 2013.

---

## Tables

### Table 1. Outcome classification of 23,598 meta-analytic endpoints from 488 Cochrane systematic reviews.

| Classification | Endpoints | % of total | Reviews containing category | % of 488 reviews |
|---|---|---|---|---|
| Benefit | 2,273 | 9.6% | 148 | 30.3% |
| Harm | 4,907 | 20.8% | 305 | 62.5% |
| Other (unclassified) | 16,418 | 69.6% | -- | -- |
| **Total** | **23,598** | **100%** | -- | -- |
| Reviews with both Benefit + Harm | -- | -- | 95 | 19.5% |

### Table 2. Net Clinical Benefit classification (primary analysis: risk difference scale, n = 56).

| Classification | n | % | Description |
|---|---|---|---|
| Net Beneficial | 12 | 21.4% | 95% CI for NCB entirely above zero |
| Net Harmful | 3 | 5.4% | 95% CI for NCB entirely below zero |
| Inconclusive | 41 | 73.2% | 95% CI for NCB includes zero |
| **Total** | **56** | **100%** | |
| | | | |
| **NCB distribution** | | | |
| Mean (SD) | 0.0799 (0.1679) | | |
| Median (IQR) | 0.0669 (-0.0164 to 0.1807) | | |
| Range | -0.3982 to 0.6418 | | |
| Positive NCB (point estimate) | 37 | 66.1% | Treatment benefit exceeds harm |
| Negative NCB (point estimate) | 19 | 33.9% | Treatment harm exceeds benefit |

### Table 3. Reviews with statistically significant net clinical benefit or net harm (RD scale, n = 15).

| Review | Benefit endpoint | Harm endpoint | NCB | 95% CI | Class |
|---|---|---|---|---|---|
| CD013571 | Participant-reported cure or improvement | Adverse events: immediately after treatment | +0.642 | (0.304, 0.980) | Net Beneficial |
| CD013474 | Overall response rate | Grade 3 and 4 adverse events | +0.404 | (0.154, 0.654) | Net Beneficial |
| CD013255 | Acute procedural success (paroxysmal AF) | 30-day cardiovascular mortality | +0.280 | (0.207, 0.353) | Net Beneficial |
| CD013425 | Quality of life: overall endpoint score | Global state: relapse | +0.280 | (0.122, 0.437) | Net Beneficial |
| CD013719 | Health-related quality of life | Serious adverse events | +0.223 | (0.190, 0.256) | Net Beneficial |
| CD001396 | Response rates | Withdrawal due to adverse effects | +0.212 | (0.159, 0.266) | Net Beneficial |
| CD003129 | Treatment response | Serious adverse events | +0.209 | (0.112, 0.306) | Net Beneficial |
| CD013111 | Complete response (metformin+progestin) | Severe adverse events | +0.204 | (0.084, 0.323) | Net Beneficial |
| CD013614 | Clinical improvement (ACR50 response) | Withdrawal due to adverse events | +0.181 | (0.003, 0.359) | Net Beneficial |
| CD014964 | First-attempt success | Technical failure of neuraxial anaesthesia | +0.180 | (0.133, 0.227) | Net Beneficial |
| CD004376 | Treatment success (participant-reported) | Adverse events at final follow-up | +0.126 | (0.022, 0.230) | Net Beneficial |
| CD015721 | Successful revascularisation (TICI 2b-3) | Mortality within 90 days | +0.047 | (0.008, 0.086) | Net Beneficial |
| CD015536 | No histological improvement | Serious adverse events | -0.398 | (-0.683, -0.113) | Net Harmful |
| CD015584 | Placement success | Misoprostol side effects | -0.149 | (-0.242, -0.057) | Net Harmful |
| CD012067 | Quality of life scores | Adverse events | -0.105 | (-0.166, -0.044) | Net Harmful |

Note: Endpoint names abbreviated for display. Full endpoint names, study counts (k), individual effect estimates, and standard errors are provided in S3 Table.

### Table 4. Sensitivity analysis: all effect measures (n = 95).

| Classification | n | % |
|---|---|---|
| Net Beneficial | 13 | 13.7% |
| Net Harmful | 3 | 3.2% |
| Inconclusive | 79 | 83.2% |
| **Total** | **95** | **100%** |
| Same-scale pairs | 61 | 64.2% |
| Mixed-scale pairs | 34 | 35.8% |

---

## Figures

### Fig 1. Distribution of Net Clinical Benefit estimates across 56 risk difference-scale pairs.

*Histogram showing the NCB distribution. Bars are colored by classification: green (Net Beneficial), gray (Inconclusive), red (Net Harmful). Vertical dashed line at NCB = 0. Median marked.*

### Fig 2. Benefit versus harm effect size scatter plot.

*Scatter plot with benefit RD on x-axis and harm RD on y-axis. The identity line (y = x) separates pairs where benefit exceeds harm (below line) from pairs where harm exceeds benefit (above line). Points colored by classification. The majority of points cluster near the origin.*

---

## Supporting information

**S1 File.** Analysis source code. Python analysis script and R classification script with full keyword libraries and NCB computation.

**S2 Table.** Classifier validation sample. 40 endpoints (20 Benefit, 20 Harm) with analysis names and manual assessment results.

**S3 Table.** Complete NCB results for all 56 RD-scale pairs and all 95 all-method pairs, with benefit and harm endpoint names, study counts, effect estimates, standard errors, NCB, 95% CI, and classification.

**S4 Table.** Top 10 most frequent benefit and harm endpoint names with counts.

---

## Acknowledgments

The author thanks the Cochrane Collaboration for maintaining publicly accessible systematic review data that made this analysis possible.

## Author contributions (CRediT)

**Mahmood Ul Hassan:** Conceptualization, Data curation, Formal analysis, Methodology, Software, Validation, Visualization, Writing -- original draft, Writing -- review & editing.

## Funding statement

The author received no specific funding for this work.

## Competing interests

The author declares no competing interests.

## Ethics statement

This study uses only publicly available meta-analytic results from published Cochrane systematic reviews. No individual patient data, protected health information, or restricted-access datasets were used. Ethical approval was not required.

## Data availability statement

All data underlying the findings of this study are derived from the Pairwise70 database of Cochrane systematic reviews, which is publicly available. The complete analysis code, outcome classification scripts, NCB computation pipeline, and all derived datasets (CSV format) are available at [ZENODO_DOI_PLACEHOLDER].
