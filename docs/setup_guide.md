# HostelIQ Environment Setup Guide

This guide walks you step-by-step through installing the software required to run and develop the **HostelIQ** project on your Windows machine.

---

## 1. Required Software Overview

To execute R scripts and compile R Markdown (`.Rmd`) notebooks, you need two core applications:

1. **R (The Engine):** The statistical computing programming language and runtime.
2. **RStudio Desktop (The Dashboard/IDE):** The integrated development environment that provides an editor, console, plot viewer, and notebook renderer.

---

## 2. Step-by-Step Installation Instructions

### Step 1: Install R (Version 4.3 or higher)
1. Visit the official Comprehensive R Archive Network (CRAN) page for Windows:  
   👉 [https://cran.r-project.org/bin/windows/base/](https://cran.r-project.org/bin/windows/base/)
2. Click **"Download R-4.x.x for Windows"** (download the latest executable, e.g., `R-4.4.2-win.exe`).
3. Run the installer:
   - Accept the default license and installation path (`C:\Program Files\R\R-4.x.x`).
   - In the "Select Components" step, keep the defaults (64-bit files).
   - In the "Startup options" step, choose **No (accept defaults)**.
   - Complete the installation wizard.

### Step 2: Install RStudio Desktop
1. Visit the official Posit website:  
   👉 [https://posit.co/download/rstudio-desktop/](https://posit.co/download/rstudio-desktop/)
2. Scroll to **"2: Install RStudio"** and click **"DOWNLOAD RSTUDIO DESKTOP FOR WINDOWS"**.
3. Run the downloaded installer (`RStudio-xxxx.xx.x-xxx.exe`):
   - Accept the default destination folder (`C:\Program Files\RStudio`).
   - Complete the installation.

### Step 3: Verify the Installation
Open **PowerShell** or **Command Prompt** and test if R is recognized:
```powershell
# Check R version
& "C:\Program Files\R\R-4.4.2\bin\R.exe" --version
```
*(If you added R to your PATH environment variable, simply typing `R --version` will work).*

---

## 3. Installing Required R Packages

Once R and RStudio are installed, launch **RStudio Desktop**, navigate to the **Console** tab (usually the bottom-left window), and run the following command to install the required project packages:

```r
# Copy and paste this into your RStudio Console:
install.packages(c(
  "tidyverse",    # Suite containing dplyr, ggplot2, readr, tidyr, purrr, stringr
  "janitor",      # For cleaning variable names and crosstabs
  "here",         # Robust relative path management
  "lubridate",    # Date and calendar manipulation
  "forecast",     # Time-series forecasting algorithms (ETS, ARIMA, Naive)
  "broom",        # Converting model statistics into tidy tibbles
  "rmarkdown",    # Notebook compilation engine
  "knitr",        # Dynamic report generation
  "kableExtra",   # High-quality academic table styling
  "testthat"      # Unit testing and data assertions
))
```

---

## 4. Opening the HostelIQ Project in RStudio

1. In Windows File Explorer, navigate to:
   ```
   D:\.java\hostel-allocation-occupancy-analytics\
   ```
2. Double-click the file named **`hostel_analytics.Rproj`**.
3. RStudio will launch with the working directory automatically anchored to the repository root.
4. You can then open **`hostel_analytics.Rmd`** and click the **"Knit"** button at the top of the editor to generate the document.
