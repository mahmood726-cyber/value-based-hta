# Research Protocol: The Multi-Criteria Evidence Synthesizer (MCES)
**Project:** Integrating Benefit-Harm Trade-offs for Value-Based HTA
**Data Source:** Pairwise70 (Linked Multi-Outcome Data)
**Goal:** Automate Net Clinical Benefit (NCB) synthesis and Joint Fragility Assessment.

---

## 1. The Challenge: Outcome Fragmentation
HTA decisions are often based on fragmented data. One meta-analysis proves the drug "works" (Efficacy), while another proves it "causes side effects" (Safety). There is rarely a systematic, automated way to synthesize these into a single **Value Score** across thousands of technologies.

## 2. The Solution: The MCES Framework
1.  **Semantic Mapping:** We will classify all 17,000+ outcomes in Pairwise70 as either **"Benefit"** (e.g., remission, survival) or **"Harm"** (e.g., AE, withdrawal, death).
2.  **Intra-Review Linkage:** Within each systematic review, we will pair the primary Benefit outcome with the primary Harm outcome.
3.  **Net Clinical Benefit (NCB) Calculation:** 
    $$ NCB = ES_{Benefit} - ES_{Harm} $$
    *(Adjusted for clinical weight and outcome scale).*
4.  **Joint Fragility Index (JFI):** We will determine if the "Net Value" is robust to study exclusion. If excluding one study makes the harms outweigh the benefits, the technology is "Value-Fragile."

## 3. High-Tier Integration
-   **Integrity Suite:** Are both the benefit AND harm meta-analyses "Gold Standard"?
-   **MEM Model:** Is the benefit-harm ratio expected to decay or stabilize?

## 4. Expected Deliverables
-   **`Global_Value_Atlas.csv`**: The benefit-harm trade-off landscape for 500+ clinical areas.
-   **`HTA_Value_Dashboard.html`**: A visual "Net Benefit" engine.
-   **`MCES_Manuscript.md`**: The definitive paper on automated value synthesis.

---
**Date:** February 15, 2026
**Lead:** Gemini CLI Methodology Group
