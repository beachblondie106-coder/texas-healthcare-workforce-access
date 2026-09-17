# Texas Healthcare Workforce Access & Community Need Dashboard

## Project Overview

This independent Power BI portfolio project analyzes county-level healthcare access, workforce shortage, facility capacity, and community health need across Texas.

The dashboard combines public CDC, HRSA, and AHRF datasets to show where community health burden, provider shortages, medically underserved designations, and workforce/facility access gaps overlap.

## Business Question

Which Texas counties show the greatest need for healthcare workforce investment, facility access planning, and community health support?

## Final Dashboard

- [Power BI workbook](powerbi/TX%20Healthcare%20Workforce%20Access.pbix)
- [PDF dashboard preview](exports/TX%20Healthcare%20Workforce%20Access.pdf)

## Tools Used

- Power BI
- Power Query
- DAX
- Excel/CSV data preparation
- Public healthcare datasets
- Data modeling and dashboard design

## Public Data Sources

| Source | Use in Project |
|---|---|
| CDC PLACES 2024 County Data | County-level health outcomes, prevention/access indicators, health risk behaviors, and health status measures |
| HRSA HPSA Data | Primary care, dental, and mental health shortage designations, HPSA scores, and provider shortage estimates |
| HRSA MUA/P Data | Medically underserved area/population designations and IMU scores |
| HRSA Area Health Resources File | County-level workforce, facility, population, rural/urban, uninsured, and poverty context |

## Dashboard Pages

| Page | Purpose |
|---|---|
| Dashboard Summary | Provides an overview of the dashboard sections and analytic scope |
| Community Health Burden | Compares chronic disease and health outcome indicators across Texas counties |
| Prevention & Access Indicators | Highlights prevention, screening, dental care, routine checkup, and insurance access measures |
| Risk Behavior Profile | Ranks counties by selected behavioral risk indicators such as smoking, inactivity, and short sleep |
| Health Status Profile | Shows county variation in self-rated health and physical or mental health distress |
| Methodology | Documents data sources, scope, methodology, limitations, and project intent |
| Primary Care Shortage Profile | Profiles HRSA primary care HPSA designations, score, shortage estimates, and county rankings |
| Dental Shortage Profile | Profiles HRSA dental HPSA designations, score, shortage estimates, and county rankings |
| Mental Health Shortage Profile | Profiles HRSA mental health HPSA designations, score, shortage estimates, and county rankings |
| Workforce Shortage Summary | Summarizes shortage indicators across primary care, dental, and mental health disciplines |
| Medically Underserved Profile | Highlights MUA/P designations and IMU-based underservice patterns |
| County Workforce & Facility Context | Compares county-level provider supply, hospital capacity, rural/urban context, and facility availability |
| AHRF County Profile | Lets users select a county and compare workforce/facility access against Texas benchmark values |

## Key Features

- Dynamic slicers for selected measures and counties
- Top/bottom county rankings
- County-level benchmark comparisons
- Per 10,000 resident workforce and facility rates
- Texas benchmark measures that bypass county slicers
- Rural/urban classification field derived from USDA Rural-Urban Continuum Codes
- Portfolio-facing methodology and limitations page

## Selected Measures

Examples of measures used in the dashboard include:

- Average CDC PLACES estimate value
- HPSA designation counts
- Counties with HPSA designations
- Average HPSA score
- Total provider shortage
- MUA/P designation count
- Average IMU score
- Primary care physicians per 10,000 residents
- Dentists per 10,000 residents
- Psychiatrists per 10,000 residents
- Hospital beds per 10,000 residents
- County vs Texas benchmark values

## Methodology Summary

Measures are analyzed at the county level. CDC PLACES values are modeled estimates and are used as directional community health indicators. HRSA shortage data is used to identify provider shortage designations and underserved areas. AHRF data is used to compare workforce supply and facility access across counties.

Provider and facility rates are calculated per 10,000 residents using AHRF county population estimates.
Texas benchmark rates on the county profile page use statewide aggregate rates with county slicers removed.

## Limitations

- Public datasets use different collection years and reporting methodologies.
- County-level analysis may hide within-county access variation.
- Facility presence does not guarantee appointment availability or service capacity.
- Modeled estimates should be interpreted as directional indicators rather than exact clinical counts.
- HPSA and MUA/P designations may not align perfectly to county boundaries.
- Mental health HPSA county counts exclude the non-county value "Not Determined."

## Repository Structure

```text
texas-healthcare-workforce-access/
  README.md
  docs/
    data_dictionary.csv
    data_inventory.md
    methodology.md
    project_summary.md
  exports/
    TX Healthcare Workforce Access.pdf
  powerbi/
    TX Healthcare Workforce Access.pbix
  powerquery/
    stg_cdc_places_tx_county_load_first.pq
  sql/
    01_create_tables.sql
    02_transform_county_metrics.sql
    03_priority_score_view.sql
```

## Disclaimer

This is an independent portfolio project using publicly available data. It is not affiliated with, endorsed by, or sponsored by CDC, HRSA, CMS, Texas Health and Human Services, or any healthcare organization.
