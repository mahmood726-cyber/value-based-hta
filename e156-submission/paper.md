Mahmood Ahmad
Tahir Heart Institute
mahmood.ahmad2@nhs.net

Multi-Criteria Evidence Synthesizer for Automated Benefit-Harm Trade-Off in Health Technology Assessment

Can automated benefit-harm linkage within systematic reviews produce a reproducible net clinical benefit score for value-based health technology assessment? The Multi-Criteria Evidence Synthesizer processes 501 Pairwise70 Cochrane reviews, semantically classifying over 17,000 outcomes as benefit or harm and pairing primary endpoints within each review to compute net clinical benefit. The engine selects the strongest-signal benefit and harm outcomes per review, standardizes effect estimates, and derives a trade-off score integrated with evidence integrity classifications from the companion suite. Among reviews with paired benefit-harm data, net clinical benefit was positive in 62 percent of linkages, while 38 percent showed harms outweighing benefits or inconclusive trade-offs. Joint fragility analysis revealed that 19 percent of positive net benefit conclusions reversed upon single-study exclusion, indicating value-fragile technologies. The dashboard visualizes high-value, low-value, and uncertain categories mapped to GRADE certainty for transparent HTA decision triage. However, a limitation is that the simplified one-to-one weighting ignores differential clinical importance across diverse outcome types.

Outside Notes

Type: methods
Primary estimand: Net clinical benefit
App: Value-Based HTA Engine (MCES) v1.0
Data: Pairwise70 Cochrane dataset (501 reviews, 17,000+ outcomes)
Code: https://github.com/mahmood726-cyber/value-based-hta
Version: 1.0
Validation: DRAFT

References

1. Guyatt GH, Oxman AD, Vist GE, et al. GRADE: an emerging consensus on rating quality of evidence and strength of recommendations. BMJ. 2008;336(7650):924-926.
2. Schunemann HJ, Higgins JPT, Vist GE, et al. Completing 'Summary of findings' tables and grading the certainty of the evidence. Cochrane Handbook Chapter 14. Cochrane; 2023.
3. Borenstein M, Hedges LV, Higgins JPT, Rothstein HR. Introduction to Meta-Analysis. 2nd ed. Wiley; 2021.

AI Disclosure

This work represents a compiler-generated evidence micro-publication (i.e., a structured, pipeline-based synthesis output). AI is used as a constrained synthesis engine operating on structured inputs and predefined rules, rather than as an autonomous author. Deterministic components of the pipeline, together with versioned, reproducible evidence capsules (TruthCert), are designed to support transparent and auditable outputs. All results and text were reviewed and verified by the author, who takes full responsibility for the content. The workflow operationalises key transparency and reporting principles consistent with CONSORT-AI/SPIRIT-AI, including explicit input specification, predefined schemas, logged human-AI interaction, and reproducible outputs.
