# CDC PLACES First Load QA Checklist

## Query Name

`stg_cdc_places_tx_county`

## Source

CDC PLACES 2024 County Data

## First Load Checks

| Check | How to Validate | Expected Result |
|---|---|---|
| Texas-only records | Distinct `state_abbr` | `TX` only |
| County FIPS format | Inspect `county_fips` | Five-character text |
| County count | Distinct count of `county_fips` | Up to 254 Texas counties |
| Selected measures | Distinct count of `measure_id` | Should match selected measure list |
| Numeric estimates | Data type of `estimate_value` | Decimal number |
| Confidence intervals | Data types of interval fields | Decimal number |
| Reporting year | Distinct `data_year` values | 2021 and/or 2022 depending on measure |
| Duplicate rows | Count duplicate county-measure-year-type combinations | Zero duplicates |

## Suggested Power BI Cards for QA Page

- Distinct county count
- Distinct measure count
- Row count
- Earliest data year
- Latest data year
- Blank estimate count

## Suggested DAX QA Measures

```DAX
County Count =
DISTINCTCOUNT('stg_cdc_places_tx_county'[county_fips])
```

```DAX
Measure Count =
DISTINCTCOUNT('stg_cdc_places_tx_county'[measure_id])
```

```DAX
CDC Row Count =
COUNTROWS('stg_cdc_places_tx_county')
```

```DAX
Blank Estimate Count =
COUNTBLANK('stg_cdc_places_tx_county'[estimate_value])
```

## Expected First Result

If the selected measure list includes 17 measures and all 254 Texas counties are present, the first focused extract should contain roughly:

```text
254 counties x 17 measures = 4,318 county-measure rows
```

The actual row count may differ if a measure is unavailable, duplicated by data value type, or uses a different reporting pattern.

