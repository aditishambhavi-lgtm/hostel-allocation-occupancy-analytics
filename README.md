# hostel-allocation-occupancy-analytics
## HostelIQ: Smart Hostel Allocation and Occupancy Analytics

[![Course: B.Tech DSC3132](https://img.shields.io/badge/Course-B.Tech_DSC3132-blue.svg)](https://github.com/aditishambhavi-lgtm/hostel-allocation-occupancy-analytics)
[![Theme: CAM-07](https://img.shields.io/badge/Theme-CAM--07_Hostel_Allocation-orange.svg)](https://github.com/aditishambhavi-lgtm/hostel-allocation-occupancy-analytics)
[![Analytics: Predictive](https://img.shields.io/badge/Analytics-Predictive_Forecasting-success.svg)](https://github.com/aditishambhavi-lgtm/hostel-allocation-occupancy-analytics)
[![Environment: R >= 4.3](https://img.shields.io/badge/Environment-R_%3E%3D_4.3-blue.svg)](https://www.r-project.org/)
[![Project Status: Scaffolded](https://img.shields.io/badge/Status-Scaffolded_%2F_Phase_2_Ready-yellow.svg)](https://github.com/aditishambhavi-lgtm/hostel-allocation-occupancy-analytics)

---

## 1. Project Overview

**HostelIQ** is an academic Business Analytics project developed for the **B.Tech DSC3132** course under **Theme CAM-07 (Hostel Allocation and Occupancy Planning)**. 

The primary objective is to transition university residential management from reactive allocation to proactive, data-driven planning. By leveraging statistical modeling and time-series techniques in R, HostelIQ investigates whether student residential bed demand can be accurately anticipated ahead of each academic session.

### Core Research Question
> **"Can we predict hostel bed demand for the next academic year using historical hostel applications, student intake, occupancy, and room capacity data?"**

---

## 2. Analytics Methodology

The project adheres strictly to an evidence-based analytics hierarchy:

1. **Descriptive & Diagnostic Analytics:**
   - Analysis of historical occupancy rates across 8 academic years (2017–18 through 2024–25).
   - Hostel-wise and block-wise utilization comparisons across residential halls.
   - Application funnel analysis: Gross applications $\rightarrow$ eligibility screening $\rightarrow$ allocations $\rightarrow$ waitlists.
2. **Predictive Analytics (Core Focus):**
   - Econometric forecasting using **Multiple Linear Regression (OLS)** to assess the impact of total student intake and outstation student ratios on residential demand.
   - Univariate time-series modeling using **Holt’s Linear Exponential Smoothing**.
   - Out-of-time holdout validation (Academic Years 2023–24 & 2024–25) evaluated via MAE, RMSE, and MAPE against a Naïve persistence baseline.
3. **Prescriptive & Scenario Planning:**
   - Capacity gap analysis: Comparing projected 2025–26 bed demand against physical operational capacity.
   - Sensitivity testing under varying university intake growth scenarios ($\pm 10\%$, $+20\%$).
   - Data-backed managerial recommendations for buffer margins and off-campus lease management.

---

## 3. Repository Structure

```
hostel-allocation-occupancy-analytics/
├── .gitignore                      # Excludes R session files, cache, and OS artifacts
├── README.md                       # Comprehensive project overview and documentation
├── hostel_analytics.Rproj          # RStudio project configuration file
├── hostel_analytics.Rmd            # Master R Markdown academic submission notebook
├── data/
│   ├── README.md                   # Data tiering and privacy governance overview
│   ├── raw/                        # Untouched raw reference datasets
│   ├── synthetic/                  # Statistically calibrated synthetic datasets
│   └── processed/                  # Cleaned, validated master analytical tables
├── R/
│   ├── 01_generate_data.R          # Synthetic dataset generation pipeline
│   ├── 02_data_prep.R              # Data cleaning, joins, and validation logic
│   ├── 03_eda_visualizations.R     # Exploratory ggplot2 visualization functions
│   └── 04_forecast_models.R        # Econometric and time-series forecasting routines
├── outputs/
│   ├── README.md                   # Artifacts and outputs overview
│   ├── figures/                    # Exported high-resolution ggplot2 charts
│   ├── tables/                     # Summary CSV tables and model performance metrics
│   └── reports/                    # Knitted HTML and GitHub Markdown report outputs
├── docs/
│   ├── data_dictionary.md          # Full dataset schemas, variables, units, and constraints
│   └── setup_guide.md              # Installation instructions for R, RStudio, and packages
└── tests/
    └── test_data_integrity.R       # Automated data consistency and capacity assertion tests
```

---

## 4. Academic Data Integrity & Privacy Policy

- **Zero PII Policy:** In accordance with ethical research standards and student privacy, this repository does not collect or expose any Personally Identifiable Information (no student names, IDs, email addresses, or phone numbers).
- **Synthetic Data Notice:** All development and demonstration datasets are synthetically generated with fixed random seeds (`set.seed(42)`). They represent stylized empirical patterns for an academic institution and do not depict actual confidential university records.
- For complete field definitions and validation constraints, refer to [`docs/data_dictionary.md`](docs/data_dictionary.md).

---

## 5. Getting Started & Environment Setup

To run this project locally, you will need **R** and **RStudio Desktop**.

Please consult the comprehensive step-by-step guide:
👉 **[docs/setup_guide.md](docs/setup_guide.md)**

### Quick R Package Requirements
```r
install.packages(c(
  "tidyverse", "janitor", "here", "lubridate", 
  "forecast", "broom", "rmarkdown", "knitr", 
  "kableExtra", "testthat"
))
```

---

## 6. Primary Deliverable

The core academic notebook is located at the root of the repository:
📄 **[`hostel_analytics.Rmd`](hostel_analytics.Rmd)**

Once R and RStudio are installed, open `hostel_analytics.Rproj`, open `hostel_analytics.Rmd`, and click **Knit** to compile the complete analysis into an interactive HTML report.