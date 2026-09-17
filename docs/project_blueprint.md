# Texas Healthcare Workforce Access & Community Need Analysis

## Project Objective

This project analyzes all Texas counties to identify where healthcare workforce shortages, community health burden, rural access barriers, and facility availability overlap. The goal is to create a portfolio-ready healthcare analytics project that demonstrates Power Query, SQL, Power BI, DAX, data modeling, and strategic business interpretation.

## Business Question

Which Texas counties show the highest combined need for healthcare workforce investment, access expansion, and community health planning?

## Portfolio Value

This project expands beyond the existing CMS and Erlanger Tableau projects by adding:

- Power BI dashboard development
- DAX measures and ranking logic
- Power Query data preparation
- SQL-based data modeling
- Workforce and access analytics
- County-level public health analysis
- Geographic prioritization for healthcare strategy

## Geographic Scope

Primary scope: all Texas counties.

Optional focus views:

- Gulf Coast counties
- Border counties
- Rural counties
- Metro vs non-metro counties
- Health Professional Shortage Area counties

## Core Data Sources

| Source | Dataset | Primary Use |
|---|---|---|
| CDC PLACES | 2024 County Data | Chronic disease, prevention, health outcomes, health behaviors, disability, and social needs |
| HRSA | Area Health Resources File | Healthcare workforce, facilities, population, economics, hospital utilization, and county characteristics |
| HRSA | Health Professional Shortage Areas | Primary care, dental, and mental health shortage designations |
| HRSA | Medically Underserved Areas / Populations | Underservice indicators and access barriers |
| CMS | Provider of Services / Provider Characteristics | Hospital and facility location, certification, ownership, and facility type |
| Texas Health Data | Health professions and hospital dashboards | State-specific workforce and hospital context |

## Planned Tools

| Tool | Use |
|---|---|
| Power Query | Import, clean, filter Texas records, standardize county names and FIPS codes |
| SQL | Join datasets, create county-level tables, calculate indicators, validate counts |
| Power BI | Build the interactive dashboard |
| DAX | Build measures, ratios, ranks, priority scores, and dynamic filters |
| Excel | Data dictionary, metric inventory, and QA checks |
| Python, optional | Clustering, scoring validation, or automated data profiling |

## Draft Data Model

### Dimension Tables

- `dim_county`
  - county_fips
  - county_name
  - state
  - region
  - rural_urban_status
  - gulf_coast_flag
  - border_county_flag

- `dim_measure`
  - measure_id
  - measure_name
  - measure_category
  - source
  - numerator_definition
  - denominator_definition

### Fact Tables

- `fact_places_health`
  - county_fips
  - measure_id
  - estimate_value
  - confidence_interval_low
  - confidence_interval_high
  - data_year

- `fact_workforce`
  - county_fips
  - profession
  - provider_count
  - population
  - providers_per_10k
  - data_year

- `fact_shortage_area`
  - county_fips
  - shortage_type
  - designation_type
  - hpsa_score
  - fte_short
  - rural_status
  - status

- `fact_facility`
  - county_fips
  - facility_type
  - facility_count
  - hospital_count
  - critical_access_flag

## Core Metrics

### Workforce Access

- Primary care providers per 10,000 population
- Mental health providers per 10,000 population
- Dental providers per 10,000 population
- HPSA designation count
- HPSA score
- HPSA FTE shortage
- MUA/P designation indicator

### Community Health Burden

- Diabetes prevalence
- Obesity prevalence
- Coronary heart disease prevalence
- COPD prevalence
- Stroke prevalence
- Poor physical health days
- Poor mental health days
- Disability prevalence
- Preventive screening gaps

### Facility Access

- Hospital count by county
- Critical access hospital indicator
- Rural health facility count
- Facility count per population
- Counties with no hospital or limited facility presence

### Population and Geography

- Total population
- Age 65+ population share
- Rural or metro classification
- Border county flag
- Gulf Coast county flag
- County population density

## Priority Scoring Concept

Each county will receive a composite priority score from 0 to 100.

Draft components:

| Component | Weight |
|---|---:|
| Workforce shortage | 35% |
| Community health burden | 30% |
| Facility access limitations | 20% |
| Population vulnerability | 15% |

Higher scores indicate counties with greater combined need.

## Dashboard Pages

### 1. Texas Priority Map

Purpose: Show which counties have the highest combined access and need score.

Visuals:

- County choropleth map
- Top 10 priority counties
- Priority score KPI
- Filters for region, rurality, shortage type, and population group

### 2. Healthcare Workforce Supply

Purpose: Evaluate workforce availability across Texas counties.

Visuals:

- Provider-to-population ratios
- HPSA score ranking
- Workforce shortage by discipline
- Rural vs metro comparison

### 3. Community Health Burden

Purpose: Identify counties with high chronic disease and prevention needs.

Visuals:

- Chronic disease heat map
- Prevention gap comparison
- Health burden index
- County detail panel

### 4. Facility & Access Landscape

Purpose: Show facility availability and potential access gaps.

Visuals:

- Hospital and facility counts
- Facility type distribution
- Counties with limited facility access
- Rural access indicators

### 5. Strategic Recommendations

Purpose: Convert analysis into business-facing action.

Visuals:

- Top county opportunity table
- Recommended strategy by county
- Workforce recruitment targets
- Telehealth, mobile clinic, behavioral health, and partnership recommendations

## Initial SQL Build Plan

1. Create a county dimension table for all Texas counties.
2. Import and filter CDC PLACES to Texas county records.
3. Pivot or normalize CDC PLACES measures into a fact table.
4. Import HRSA workforce and shortage data.
5. Standardize county names and FIPS codes across sources.
6. Create calculated access and burden indicators.
7. Build county-level summary table for Power BI.
8. Validate row counts, county coverage, and missing values.

## Initial Power Query Build Plan

1. Connect to CDC PLACES OData or CSV export.
2. Filter to Texas.
3. Keep only county-level records and selected measures.
4. Clean field names.
5. Convert estimate fields to numeric types.
6. Standardize county FIPS as five-character text.
7. Load cleaned query as staging table.
8. Repeat for HRSA, CMS, and Texas Health Data sources.

## Initial DAX Measures

```DAX
Priority Score =
    [Workforce Shortage Score] * 0.35
    + [Health Burden Score] * 0.30
    + [Facility Access Score] * 0.20
    + [Population Vulnerability Score] * 0.15
```

```DAX
County Rank =
    RANKX(
        ALL('County'[County Name]),
        [Priority Score],
        ,
        DESC
    )
```

```DAX
Providers per 10K =
    DIVIDE(
        SUM('Workforce'[Provider Count]),
        SUM('County'[Population])
    ) * 10000
```

## GitHub Folder Structure

```text
texas-healthcare-workforce-access/
  README.md
  data/
    raw/
    processed/
  docs/
    project_blueprint.md
    data_dictionary.xlsx
    methodology.md
  sql/
    01_create_tables.sql
    02_transform_county_metrics.sql
    03_priority_score_view.sql
  powerbi/
    texas_healthcare_workforce_access.pbix
    dashboard_screenshots/
  assets/
    images/
```

## Recommended First Build Step

Start with CDC PLACES 2024 County Data because it is accessible, county-level, and works well with Power Query. Build the first cleaned Texas county health burden table, then connect it to a Texas county dimension table.

## Project Disclaimer

This is an independent portfolio project using publicly available data. It is not affiliated with, endorsed by, or sponsored by CDC, HRSA, CMS, Texas Health and Human Services, or any healthcare organization.

