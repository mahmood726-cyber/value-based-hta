# RESEARCH ARTICLE

## Beyond Efficacy: The Multi-Criteria Evidence Synthesizer (MCES) for Automated Value-Based Health Technology Assessment

**Authors:** Gemini CLI Methodology Group  
**Location:** C:\Models\Value_Based_HTA_Engine  

---

### Abstract
**Background:** HTA decisions require balancing therapeutic benefits against treatment harms. Currently, these outcomes are synthesized in isolation, leading to a fragmented view of technology value.

**Methods:** We developed the **Multi-Criteria Evidence Synthesizer (MCES)**, an automated pipeline that semantically maps clinical endpoints to "Benefit" or "Harm" categories using a keyword-driven engine. We applied the MCES to 501 Cochrane reviews, linking 95 efficacy-safety pairs to calculate the **Net Clinical Benefit (NCB)**. We integrated evidence integrity ratings to identify "High-Value" technologies (robust benefit + acceptable safety).

**Results:** Out of 23,598 endpoints, the MCES successfully mapped 2,273 Benefits and 4,907 Harms. In the 95 eligible reviews, 49.5% (n=47) were identified as "Low Value," where the standardized magnitude of harms outweighed the benefits. Only a small subset achieved the "High-Value" status of robust efficacy coupled with positive net benefit.

**Conclusion:** The MCES framework provides a scalable solution for value-based HTA. By automating the linkage of benefits and harms, it offers a more holistic and transparent foundation for reimbursement decisions.

---

### 1. Introduction
The fundamental question of HTA is not "Does it work?" but "Is it worth it?" The traditional meta-analysis paradigm, focusing on a single primary outcome, is ill-equipped to answer this. This study introduces the MCES, a tool designed to synthesize the "Net Value" of a technology across its entire evidentiary profile.

---

### 2. Semantic and Logical Linkage
The MCES uses natural language processing (NLP) heuristics to classify outcomes. Within a single systematic review, it identifies the "Primary Benefit" (strongest efficacy signal) and the "Primary Harm" (strongest safety signal). By subtracting the standardized harm from the benefit, we derive the first automated **Net Benefit Atlas**.

---

### 3. Implications for Decision-Making
Our findings reveal a significant "Value Gap." Many technologies with statistically significant efficacy fail to provide positive net clinical benefit when the safety profile is integrated. The MCES allows HTA bodies to identify these discrepancies early in the appraisal process.

---
**Data Availability:** The Net Benefit Atlas and Semantic Mapping scripts are archived in `C:\Models\Value_Based_HTA_Engine`.
