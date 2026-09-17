# Power Query Starter Steps

## First Dataset

CDC PLACES 2024 County Data

## Goal

Create the first cleaned Texas county health table for Power BI.

## Recommended Workflow

1. Open Power BI Desktop.
2. Select **Get Data**.
3. Choose either:
   - **OData feed**, if using the CDC endpoint, or
   - **Text/CSV**, if using a downloaded CSV file.
4. Load the CDC PLACES County Data.
5. Open **Transform Data**.
6. Filter state records to Texas.
7. Keep county-level records only.
8. Keep the fields needed for the first model:
   - state abbreviation
   - state name
   - county FIPS
   - county name
   - measure ID
   - measure name
   - category
   - data value
   - confidence interval low
   - confidence interval high
   - data year
9. Rename fields using portfolio-friendly names:
   - `county_fips`
   - `county_name`
   - `measure_id`
   - `measure_name`
   - `measure_category`
   - `estimate_value`
   - `confidence_interval_low`
   - `confidence_interval_high`
   - `data_year`
10. Convert `county_fips` to text.
11. Pad `county_fips` to five characters if needed.
12. Convert estimate and confidence interval fields to decimal numbers.
13. Remove duplicate county-measure-year rows.
14. Name the query `stg_cdc_places_tx_county`.
15. Load the query to the Power BI model.

## Suggested First Measure List

Use a focused set first instead of importing every possible measure into the initial dashboard.

| Domain | Measures |
|---|---|
| Chronic disease burden | Diabetes, obesity, coronary heart disease, COPD, stroke |
| Health status | Poor physical health, poor mental health, frequent mental distress |
| Prevention | Routine checkup, dental visit, colorectal cancer screening, mammography |
| Risk behaviors | Current smoking, physical inactivity, short sleep |
| Vulnerability | Disability, lack of health insurance, food insecurity if available |

## Data Quality Checks in Power Query

| Check | Expected Result |
|---|---|
| Texas county count | 254 counties after county dimension is complete |
| County FIPS format | Five-character text |
| Estimate values | Numeric |
| Duplicate rows | No duplicate county-measure-year rows |
| Missing county names | None |

## Output Table

`stg_cdc_places_tx_county`

This table will later feed:

- `fact_places_health`
- Community Health Burden dashboard page
- Priority score model

