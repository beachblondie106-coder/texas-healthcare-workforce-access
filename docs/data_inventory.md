# Data Inventory

## Project

Texas Healthcare Workforce Access & Community Need Analysis

## Geographic Grain

County-level analysis for all Texas counties.

Primary join key: `county_fips`

## Dataset Inventory

| Priority | Source | Dataset | Grain | Planned Use | Access Method | Status |
|---:|---|---|---|---|---|---|
| 1 | CDC PLACES | 2024 County Data | County, measure | Chronic disease, prevention, health outcomes, disability, and social needs | OData or CSV export | Planned |
| 2 | HRSA | Area Health Resources File | County | Workforce counts, provider ratios, facilities, population, economics, and utilization | Download file | Planned |
| 3 | HRSA | Health Professional Shortage Areas | HPSA designation area, county | Primary care, dental, and mental health shortage designations | Data download or GIS service | Planned |
| 4 | HRSA | Medically Underserved Areas / Populations | MUA/P designation area, county | Underserved area or population indicators | Data download or GIS service | Planned |
| 5 | CMS | Provider of Services / Provider Characteristics | Facility | Hospital and facility counts, facility type, certification, and location | CSV download | Planned |
| 6 | Texas Health Data | Health professions and hospitals | Region, county, or facility depending on source | Texas-specific workforce and hospital context | Public dashboards/downloads | Optional |

## Dataset Selection Rationale

### CDC PLACES

CDC PLACES is the best starting dataset because it is public, county-level, and contains many health burden measures. It can support the Community Health Burden dashboard page and become the first Power Query workflow.

### HRSA AHRF

The Area Health Resources File provides the workforce and county context needed to make this more than a public health dashboard. It supports provider supply, facility availability, population, and economic context.

### HRSA HPSA and MUA/P

Shortage and medically underserved designations add policy-relevant access measures. These indicators make the analysis useful for workforce planning, recruitment strategy, rural health, and community investment.

### CMS Provider Characteristics

CMS facility data provides a way to count hospitals and other Medicare-certified facilities by county, creating the Facility & Access Landscape dashboard page.

### Texas Health Data

Texas-specific data can be used as an optional enrichment layer after the core federal datasets are working.

## Initial Measure Categories

| Category | Example Measures | Likely Source |
|---|---|---|
| Workforce access | Provider count, providers per 10K, HPSA score, FTE shortage | HRSA |
| Health burden | Diabetes, obesity, heart disease, COPD, stroke, poor physical health | CDC PLACES |
| Prevention gaps | Mammography, colorectal screening, routine checkup, dental visit | CDC PLACES |
| Behavioral risk | Smoking, physical inactivity, sleep, binge drinking | CDC PLACES |
| Facility access | Hospital count, facility count, critical access flag | CMS |
| Population vulnerability | Age 65+, poverty, uninsured, rurality, disability | HRSA, CDC PLACES |

## Data Quality Checks

| Check | Purpose |
|---|---|
| County count equals expected Texas county count | Confirms geographic completeness |
| `county_fips` is five-character text | Prevents dropped leading zeroes |
| County names are standardized | Prevents failed joins |
| Measures have numeric values | Enables scoring and visualization |
| Duplicate county-measure rows are flagged | Prevents inflated measures |
| Missing values are profiled by source | Prevents misleading rankings |

## Initial Build Order

1. Create Texas county dimension table.
2. Load CDC PLACES county data and filter to Texas.
3. Select a focused measure list for health burden and prevention gaps.
4. Load HRSA workforce and shortage data.
5. Load CMS facility data.
6. Create county-level summary views.
7. Build priority score table.
8. Connect the final model to Power BI.

