# CDC PLACES Measure Plan

## Dataset

CDC PLACES: Local Data for Better Health, County Data 2024 release

## Purpose in Project

CDC PLACES will power the Community Health Burden and Prevention Gap portions of the Texas Healthcare Workforce Access & Community Need Analysis.

The dataset is county-level and includes measures for chronic disease, preventive services, health behaviors, disability, health status, and social needs. The 2024 release uses 2022 BRFSS data for most measures and 2021 BRFSS data for several measures collected every other year.

## Initial Texas Filter

Use Texas records only:

```text
stateabbr = TX
```

## Primary Fields to Keep

| Portfolio Field | CDC Field | Purpose |
|---|---|---|
| `state_abbr` | `stateabbr` | State filter |
| `state_name` | `statedesc` | State display |
| `county_fips` | `locationid` | County join key |
| `county_name` | `locationname` | County display |
| `measure_id` | `measureid` | Measure code |
| `measure_name` | `measure` | Measure display |
| `measure_category` | `category` | Measure grouping |
| `estimate_value` | `data_value` | Main numeric estimate |
| `confidence_interval_low` | `low_confidence_limit` | Estimate lower bound |
| `confidence_interval_high` | `high_confidence_limit` | Estimate upper bound |
| `data_year` | `data_value_year` | Reporting year |
| `data_value_type` | `data_value_type` | Usually crude prevalence or age-adjusted prevalence |

## Recommended First Measure Set

Start focused. Importing everything is fine technically, but a focused first set makes dashboard design and scoring easier.

| Domain | Measure ID | Measure |
|---|---|---|
| Chronic disease burden | `DIABETES` | Diagnosed diabetes among adults |
| Chronic disease burden | `OBESITY` | Obesity among adults |
| Chronic disease burden | `CHD` | Coronary heart disease among adults |
| Chronic disease burden | `COPD` | Chronic obstructive pulmonary disease among adults |
| Chronic disease burden | `STROKE` | Stroke among adults |
| Chronic disease burden | `KIDNEY` | Chronic kidney disease among adults |
| Health status | `PHLTH` | Frequent physical health distress among adults |
| Health status | `MHLTH` | Frequent mental health distress among adults |
| Health status | `GHLTH` | Fair or poor self-rated health status among adults |
| Risk behavior | `CSMOKING` | Current smoking among adults |
| Risk behavior | `LPA` | No leisure-time physical activity among adults |
| Risk behavior | `SLEEP` | Sleeping less than 7 hours among adults |
| Prevention | `CHECKUP` | Routine checkup among adults |
| Prevention | `DENTAL` | Dental visit among adults |
| Prevention | `COLON_SCREEN` | Colorectal cancer screening among adults |
| Prevention | `MAMMOUSE` | Mammography use among women |
| Coverage / access | `ACCESS2` | Current lack of health insurance among adults |

## Dashboard Use

### Community Health Burden Page

Recommended measures:

- Diabetes
- Obesity
- Coronary heart disease
- COPD
- Stroke
- Chronic kidney disease
- Poor physical health
- Poor mental health
- Fair or poor health

### Prevention Gap Page

For preventive measures where higher is better, calculate a gap:

```text
prevention_gap = 100 - estimate_value
```

Recommended measures:

- Routine checkup
- Dental visit
- Colorectal cancer screening
- Mammography use

### Access / Vulnerability Page

Recommended measures:

- Lack of health insurance
- Disability-related measures, if included in the final extract
- Health-related social needs, if included in the final extract

## First Data Quality Checks

| Check | Expected Result |
|---|---|
| Texas county count | Up to 254 counties for county-level records |
| `county_fips` type | Text |
| `county_fips` length | Five characters |
| `estimate_value` type | Decimal number |
| Duplicate county-measure-year rows | None after filtering to one data value type |
| Measure IDs | Match selected project measure list |

## Notes for Scoring

Most burden measures are scored so that higher values mean higher need.

Preventive measures should be inverted when used as gaps:

```text
Routine checkup gap = 100 - routine checkup estimate
Dental visit gap = 100 - dental visit estimate
Screening gap = 100 - screening estimate
```

Insurance access is already directional if using lack of insurance:

```text
Higher ACCESS2 = higher access barrier
```

