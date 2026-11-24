# HostelIQ Data Dictionary & Variable Specifications

**Project:** HostelIQ – Smart Hostel Allocation and Occupancy Analytics  
**Course:** B.Tech DSC3132 (Business Analytics)  
**Status:** Synthetic Specification for Academic Demonstration (8-Year Horizon: 2017–18 to 2024–25)

---

## 1. Governance & Synthetic Data Declaration

> [!IMPORTANT]
> **Academic Integrity Notice:**  
> The datasets described in this dictionary are synthetically generated for academic demonstration in course DSC3132. They do not contain confidential institutional records, nor do they expose student Personally Identifiable Information (PII) such as student names, registration numbers, phone numbers, or email addresses.

---

## 2. Table Specifications

### Table 1: Institutional Intake & Demographics (`intake_demographics.csv`)
- **Granularity:** One record per academic year.
- **Coverage:** 8 historical academic years (2017–18 through 2024–25), with target forecast year 2025–26.
- **Primary Key:** `academic_year`

| Column Name | Storage Type | Units / Format | Validation Rule | Description |
| :--- | :--- | :--- | :--- | :--- |
| `academic_year` | String | `YYYY-YY` (e.g., `2023-24`) | Must match pattern `^\d{4}-\d{2}$` | The academic reporting year. |
| `total_admissions` | Integer | Students | $> 0$; `= ug_intake + pg_intake` | Total freshmen student intake across all programs. |
| `ug_intake` | Integer | Students | $\ge 0$ | Undergraduate student intake. |
| `pg_intake` | Integer | Students | $\ge 0$ | Postgraduate student intake. |
| `outstation_students` | Integer | Students | $0 < \text{outstation} \le \text{total_admissions}$ | Number of admitted students whose domicile requires campus housing. |
| `outstation_ratio` | Numeric | Proportion ($0.00 - 1.00$) | `= outstation_students / total_admissions` | Proportion of intake driving hostel accommodation demand. |

---

### Table 2: Hostel Infrastructure & Capacity Inventory (`hostel_inventory.csv`)
- **Granularity:** One record per hostel, block, and room-tier combination.
- **Coverage:** Physical residential infrastructure across campus.
- **Composite Key:** `hostel_id`, `block_id`, `room_tier`

| Column Name | Storage Type | Units / Format | Validation Rule | Description |
| :--- | :--- | :--- | :--- | :--- |
| `hostel_id` | String | Code (`BH-1`, `GH-1`, etc.) | Unique per hostel entity | Short alphanumeric identifier for hostel. |
| `hostel_name` | String | Text | Non-empty | Formal hall of residence name (e.g., Ramanujan Hall). |
| `gender_policy` | String | `Boys` / `Girls` | Restrictive category | Policy restriction governing resident allocation. |
| `block_id` | String | Text (`Block A`, etc.) | Non-empty | Specific structural block within the hostel. |
| `room_tier` | String | `Single`, `Double`, `Triple` | Category | Room layout / bed configuration. |
| `ac_status` | Logical | `TRUE` / `FALSE` | Boolean | Whether rooms in this block are air-conditioned. |
| `room_count` | Integer | Rooms | $> 0$ | Total physical rooms in this block/tier. |
| `bed_capacity` | Integer | Beds | $= \text{room_count} \times \text{occupancy_factor}$ | Maximum available bed capacity in this block/tier. |

---

### Table 3: Annual Application, Occupancy & Financial Records (`annual_hostel_records.csv`)
- **Granularity:** One record per hostel per academic year.
- **Coverage:** 8 academic years $\times$ 6 hostels = 48 records.
- **Composite Key:** `academic_year`, `hostel_id`

| Column Name | Storage Type | Units / Format | Validation Rule | Description |
| :--- | :--- | :--- | :--- | :--- |
| `academic_year` | String | `YYYY-YY` | Valid chronological string | Academic year of the record. |
| `hostel_id` | String | Valid foreign key | Must exist in `hostel_inventory.csv` | Associated hostel building. |
| `applied_count` | Integer | Applications | $\ge \text{eligible_count}$ | Gross applications submitted by students. |
| `eligible_count` | Integer | Applications | $\le \text{applied_count}$ | Applications meeting distance and academic criteria. |
| `allocated_beds` | Integer | Students / Beds | $\le \text{total_beds}$ | Number of beds officially allotted to students. |
| `waitlisted_count`| Integer | Students | $= \text{eligible_count} - \text{allocated_beds}$ | Eligible students who could not be accommodated (unmet demand). |
| `rejected_count` | Integer | Applications | $= \text{applied_count} - \text{eligible_count}$ | Ineligible or disqualified applications. |
| `total_beds` | Integer | Beds | Positive integer | Total operational bed capacity for the given year. |
| `vacant_beds` | Integer | Beds | $= \text{total_beds} - \text{allocated_beds}$ | Unutilized beds (maintenance buffer or empty). |
| `annual_operating_cost` | Numeric | INR (₹) | Optional; $\ge 0$ | Approximate annual operational and maintenance costs. |

---

## 3. Derived Analytical Metrics

To avoid confusion, the following standardized formulas must be utilized across all analyses:

1. **Occupancy Rate (%):**
   $$\text{Occupancy Rate} = \left( \frac{\text{allocated_beds}}{\text{total_beds}} \right) \times 100\%$$
   *Measures the physical utilization of operational capacity.*

2. **Application Pressure / Demand-to-Capacity Ratio:**
   $$\text{Demand Pressure} = \frac{\text{eligible_count}}{\text{total_beds}}$$
   *A ratio $> 1.0$ indicates that qualified demand exceeds available capacity, requiring waitlisting or off-campus alternatives.*

3. **Allocation Rate (%):**
   $$\text{Allocation Rate} = \left( \frac{\text{allocated_beds}}{\text{eligible_count}} \right) \times 100\%$$
   *Represents the percentage of qualified applicants successfully accommodated.*

4. **Waitlist Burden (%):**
   $$\text{Waitlist Rate} = \left( \frac{\text{waitlisted_count}}{\text{eligible_count}} \right) \times 100\%$$
   *Represents the percentage of qualified applicants turned away due to capacity shortages.*

5. **Cost per Occupied Bed (Optional Metric):**
   $$\text{Cost per Occupied Bed} = \frac{\text{annual_operating_cost}}{\text{allocated_beds}}$$
   *Evaluates operational cost efficiency per resident.*

---

## 4. Integrity Constraints & Double-Counting Prevention

1. **Intake vs. Applications:**  
   Total university intake includes both local (day scholar) and outstation students. Only outstation students typically drive hostel demand. Total applications must never exceed total institutional admissions.
2. **Campus-Wide vs. Hostel-Specific Sums:**  
   When calculating university-level bed demand, aggregate `applied_count`, `allocated_beds`, and `total_beds` across all hostels for a given `academic_year`. Do not mix block-level and hostel-level sums.
3. **Capacity Ceiling:**  
   `allocated_beds` can never exceed `total_beds`. If demand exceeds capacity, the remainder must flow into `waitlisted_count`.
