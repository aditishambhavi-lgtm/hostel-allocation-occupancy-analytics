# ==============================================================================
# Script: test_data_integrity.R
# Project: HostelIQ - Smart Hostel Allocation and Occupancy Analytics
# Course: B.Tech DSC3132 (Business Analytics)
# Status: SKELETON (Implementation pending user approval)
# Description: Automated data validation checks using testthat/stopifnot to verify
#              logical consistency before analytical modeling.
# ==============================================================================

# Planned Test Cases:
#   1. Capacity constraint: allocated_beds <= total_beds for all records.
#   2. Non-negativity: All counts (intake, applications, beds) >= 0.
#   3. Funnel consistency: eligible_applications <= total_applications.
#   4. Key integrity: All hostel_id in annual records match hostel_inventory.
#   5. Temporal consistency: Chronological sequence across 8 academic years.
