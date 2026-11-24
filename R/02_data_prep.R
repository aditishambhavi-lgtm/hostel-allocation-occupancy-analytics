# ==============================================================================
# Script: 02_data_prep.R
# Project: HostelIQ - Higher Education Hostel Capacity Planning and Occupancy Analytics in India
# Course: B.Tech DSC3132 (Business Analytics)
# Status: REPRODUCIBLE R SCRIPT (Authored for Step 2: State-wise Descriptive Analytics)
# Input: data/processed/aishe_table31_state_2023_24.csv
# Output: data/processed/hostel_occupancy_analysis.csv
#
# IMPORTANT EXECUTION NOTE:
# This script is authored for standard execution in R / RStudio once R is installed.
# The underlying calculations and CSV output were verified and compiled via 
# deterministic script in Step 2 to ensure zero disruption while R is configured.
# ==============================================================================

# 1. Load Required Libraries (Base R fallback used if packages are not yet installed)
suppressPackageStartupMessages({
  if (!requireNamespace("readr", quietly = TRUE)) {
    message("readr package not detected; utilizing base R read.csv/write.csv")
  }
})

# 2. Define File Paths (Relative to repository root)
input_file  <- file.path("data", "processed", "aishe_table31_state_2023_24.csv")
output_file <- file.path("data", "processed", "hostel_occupancy_analysis.csv")

# 3. Ingest Verified Extracted Table 31 Data
if (!file.exists(input_file)) {
  stop("Input file not found: ", input_file, ". Please complete Step 1 extraction first.")
}

data <- read.csv(input_file, stringsAsFactors = FALSE, na.strings = c("", "NA", "NIL", "-"))

# 4. Perform Analytical Metric Derivation
# Task 1: State-wise Total Hostel Occupancy Rate (%)
data$total_occupancy_rate <- ifelse(
  !is.na(data$total_intake) & data$total_intake > 0,
  round((data$total_residing / data$total_intake) * 100, 2),
  NA
)

# Task 2: Available Bed Capacity (Operational Buffer Margin)
data$available_beds <- ifelse(
  !is.na(data$total_intake) & !is.na(data$total_residing),
  data$total_intake - data$total_residing,
  NA
)

# Task 3: Separate Boys and Girls Occupancy Rates (%)
data$boys_occupancy_rate <- ifelse(
  !is.na(data$boys_intake) & data$boys_intake > 0,
  round((data$boys_residing / data$boys_intake) * 100, 2),
  NA
)

data$girls_occupancy_rate <- ifelse(
  !is.na(data$girls_intake) & data$girls_intake > 0,
  round((data$girls_residing / data$girls_intake) * 100, 2),
  NA
)

# 5. Export Derived Dataset to data/processed/
write.csv(data, output_file, row.names = FALSE, na = "NA")
message("Successfully saved derived occupancy metrics to: ", output_file)

# 6. Summary Diagnostics
cat("\n--- SUMMARY OF HIGHEST OCCUPANCY STATES (TOP 5) ---\n")
top_5 <- head(data[order(-data$total_occupancy_rate), c("state_ut", "total_intake", "total_residing", "total_occupancy_rate", "available_beds")], 5)
print(top_5, row.names = FALSE)

cat("\n--- SUMMARY OF LOWEST OCCUPANCY STATES (BOTTOM 5) ---\n")
bottom_5 <- head(data[order(data$total_occupancy_rate), c("state_ut", "total_intake", "total_residing", "total_occupancy_rate", "available_beds")], 5)
print(bottom_5, row.names = FALSE)
