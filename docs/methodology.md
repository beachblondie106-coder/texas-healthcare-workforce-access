# Methodology

## Geographic Scope

Texas counties.

## Data Sources

### CDC PLACES 2024 County Data

CDC PLACES county-level modeled estimates are used to evaluate community health burden, prevention/access indicators, health risk behaviors, and health status measures.

### HRSA HPSA / MUA-P Data

HRSA Health Professional Shortage Area and Medically Underserved Area/Population data are used to evaluate primary care, dental, and mental health shortage designations, provider shortage estimates, HPSA scores, and medically underserved patterns.

### HRSA Area Health Resources File

AHRF county-level data is used to add workforce supply, facility capacity, population, rural/urban, uninsured, and poverty context.

## Analytic Approach

The project uses county-level public data to compare Texas counties across three related access questions:

1. Where is community health burden higher?
2. Where do shortage and underservice designations appear?
3. How does county-level workforce and facility supply compare with population need?

Measures are analyzed at the county level. CDC PLACES values are modeled estimates and are used as directional community health indicators. HRSA shortage data is used to identify provider shortage designations and underserved areas. AHRF data is used to compare workforce supply and facility access across counties.

Provider and facility rates are calculated per 10,000 residents using AHRF county population estimates.

## Key Calculations

### CDC PLACES

CDC values are aggregated primarily as averages because the source fields represent modeled estimate values rather than counts.

### HPSA Shortage Profiles

Shortage profile pages summarize:

- HPSA designation counts
- Counties with HPSA records
- Average HPSA score
- Total provider shortage
- County rankings by selected shortage measures

### MUA/P Profile

MUA/P records are used to evaluate medically underserved designations and IMU scores. Lower nonzero IMU scores indicate greater medical underservice.

### AHRF Workforce and Facility Measures

AHRF provider and facility fields are converted to rates per 10,000 residents where appropriate:

- Primary care physicians per 10,000 residents
- Dentists per 10,000 residents
- Psychiatrists per 10,000 residents
- Hospital beds per 10,000 residents

The AHRF county profile page includes benchmark measures that remove the county slicer filter so selected county values can be compared against Texas statewide benchmark values.

Texas benchmark rates are calculated as statewide aggregate rates rather than unweighted averages of county rates. This keeps the benchmark aligned with the total Texas provider or facility supply divided by total Texas population.

## Rural/Urban Classification

The dashboard includes a simplified rural/urban category derived from the USDA Rural-Urban Continuum Code:

- Codes 1-3: Metro
- Codes 4-9: Nonmetro / Rural

This classification is used as context for interpreting provider and facility access patterns.

## Limitations

- Public datasets may use different reporting years, methodologies, and definitions.
- County-level analysis may hide variation within counties.
- Facility presence does not guarantee appointment availability, service capacity, or geographic accessibility.
- Provider counts may not reflect full-time availability, accepted insurance, or specialty coverage.
- CDC PLACES values are modeled estimates and should be interpreted as directional indicators rather than exact clinical counts.
- HPSA and MUA/P designations may not align perfectly to county boundaries.
- Mental health HPSA records included a non-county value, "Not Determined," which is excluded from Texas county count measures and county-level visuals.

## Intended Use

This project is intended as a portfolio demonstration of Power BI, Power Query, DAX, healthcare analytics, public data integration, and dashboard storytelling.

It is not a clinical, regulatory, funding, or policy determination tool.

## Disclaimer

This is an independent portfolio project using publicly available data. It is not affiliated with, endorsed by, or sponsored by CDC, HRSA, CMS, Texas Health and Human Services, or any healthcare organization.
