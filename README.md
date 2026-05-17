# Clinical Data Interoperability Explorer
### R-Based Healthcare Data Standards Portfolio Project
**Author:** Kristina Ankrah | Healthcare IT Professional | Clinical Informatics  
**GitHub:** [IT-Professional-Kristina](https://github.com/IT-Professional-Kristina)

---

## Project Overview

This project demonstrates working knowledge of the three core healthcare data interoperability standards used in modern clinical environments:

| Standard | Purpose | Status |
|----------|---------|--------|
| **FHIR R4** (Fast Healthcare Interoperability Resources) | Modern REST-based clinical data exchange | ✅ Complete |
| **HL7 v2** | Legacy pipe-delimited hospital messaging (ADT, ORU) | 🔄 In Progress |
| **DICOM** | Medical imaging data and metadata | 🔄 In Progress |

Built entirely in **R**, this project connects clinical domain expertise — including 6+ years of hands-on Epic EHR experience across Ambulatory, Willow Inpatient, and Beacon Oncology modules — with practical healthcare data engineering skills.

---

## Why This Matters in Healthcare IT

When a patient is admitted to a hospital, discharged, transferred, or prescribed a medication, that information doesn't stay in one system. It travels — between the EHR, the pharmacy system, the lab, the radiology department, and downstream reporting tools — using standardized message formats.

As a clinical informatics analyst, understanding how these standards work is essential to:
- Diagnosing why data didn't flow correctly between systems
- Supporting interface build, testing, and validation
- Ensuring compliance with CMS and ONC interoperability requirements
- Communicating with IT integration teams about data exchange issues

This project is a hands-on demonstration of that knowledge.

---

## Part 1: FHIR R4 — Patient & Medication Data Pipeline

### What is FHIR?
FHIR (Fast Healthcare Interoperability Resources) is the modern standard for clinical data exchange, developed by HL7 International. It uses REST APIs and JSON — the same technologies that power modern web applications — making it significantly more developer-friendly than older healthcare standards.

Epic, Cerner, and virtually every major EHR now expose FHIR APIs, and CMS regulations require health systems to make patient data available via FHIR endpoints.

### What This Script Does
`01_fhir_query.R` connects to the public **HAPI FHIR R4 test server** and:

1. Queries **Patient resources** — pulling demographic data (name, gender, birth date)
2. Queries **MedicationRequest resources** — pulling active, completed, and stopped medication orders
3. Flattens the nested FHIR JSON bundles into clean R data frames using `fhircrackr`
4. Produces a **clinical visualization** of medication request status distribution using `ggplot2`
5. Exports structured data as CSVs for downstream reporting use

### Libraries Used
```r
library(fhircrackr)   # FHIR server querying and bundle parsing
library(dplyr)        # Data manipulation and summarization
library(ggplot2)      # Clinical data visualization
```

### FHIR Resources Queried
| Resource | Description | Clinical Relevance |
|----------|-------------|-------------------|
| `Patient` | Demographic data | Patient identification and matching |
| `MedicationRequest` | Medication orders | Pharmacy workflow and reconciliation |

### Output
| File | Description |
|------|-------------|
| `output/patients.csv` | Structured patient demographic data from FHIR |
| `output/medications.csv` | Medication request records with status and timestamps |
| `output/medication_status_chart.png` | ggplot2 visualization of medication status distribution |

### Sample Visualization
The chart below shows the distribution of medication request statuses pulled live from the HAPI FHIR R4 public server:

![Medication Requests by Status](output/medication_status_chart.png)

---

## Part 2: HL7 v2 — Message Parser *(In Progress)*

### What is HL7 v2?
HL7 version 2 is the older, widely-used pipe-delimited messaging standard still running in the majority of hospital systems today. When a patient is admitted, an **ADT (Admit/Discharge/Transfer)** message is generated and sent to downstream systems. When a lab result is ready, an **ORU (Observation Result)** message is transmitted.

Understanding HL7 v2 message structure — segments like `MSH`, `PID`, `PV1`, `OBX` — is essential for clinical informatics analysts who support interface monitoring, troubleshooting, and validation.

### What This Script Will Do
`02_hl7_parser.R` will:
1. Ingest sample HL7 ADT and ORU messages (plain text)
2. Parse pipe-delimited segments into structured R data frames
3. Display parsed fields in a human-readable format
4. Demonstrate understanding of how clinical events generate interface messages

---

## Part 3: DICOM — Medical Imaging Metadata *(In Progress)*

### What is DICOM?
DICOM (Digital Imaging and Communications in Medicine) is the standard for medical imaging data. Every CT scan, MRI, X-ray, and ultrasound image is stored and transmitted as a DICOM file — which contains both the image itself and a structured metadata header carrying patient information, study details, and imaging parameters.

Clinical informatics analysts working in radiology IT, imaging informatics, or any role touching PACS systems need to understand how DICOM carries and protects patient data.

### What This Script Will Do
`03_dicom_explorer.R` will:
1. Load sample DICOM files using the `oro.dicom` package
2. Extract and display the metadata header (patient ID, modality, study date)
3. Render the image in R
4. Demonstrate understanding of DICOM as a compliance and interoperability standard

---

## Clinical Background & Context

This project was built by a healthcare IT professional with:
- **6+ years of direct clinical experience** across major academic medical centers including Johns Hopkins Medicine (Sibley Memorial Hospital), UVA Health (Novant Health Prince William Medical Center), Inova Health System (Inova Schar Cancer Center), and VHC Health
- **Hands-on Epic EHR end-user expertise** across EpicCare Ambulatory, Epic Willow Inpatient, Epic Beacon Oncology, and Epic ED modules
- **B.S. in Information Technology**, GPA 3.93, Summa Cum Laude, Colorado Technical University (2023)
- Active portfolio development in Azure cloud infrastructure, clinical decision support, and genomics informatics

### Related Portfolio Projects
- [Azure Genomics Research Platform](https://github.com/IT-Professional-Kristina/azure-genomics-research-platform) — Live Cosmos DB with pathogenic oncology variants, CI/CD pipeline, clinical dashboard
- [Genomic Cosmos AWS DynamoDB](https://github.com/IT-Professional-Kristina/genomic-cosmos-aws-db) — Node.js genomic variant database on AWS

---

## How to Run This Project

### Prerequisites
- R 4.0 or higher
- RStudio (recommended)

### Installation
```r
install.packages("fhircrackr")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("oro.dicom")    # For Part 3
install.packages("stringr")      # For Part 2
```

### Run Part 1
Open `01_fhir_query.R` in RStudio and run the full script. An internet connection is required to reach the HAPI FHIR public test server.

---

## Data Source & Privacy Note

All data in this project is sourced from the **HAPI FHIR R4 Public Test Server** (`https://hapi.fhir.org/baseR4`), which contains synthetic test data only. No real patient data is used or stored in this repository. All outputs comply with responsible use of public healthcare test infrastructure.

---

*This project is part of an active healthcare IT portfolio demonstrating clinical informatics, data interoperability, and healthcare systems knowledge.*
