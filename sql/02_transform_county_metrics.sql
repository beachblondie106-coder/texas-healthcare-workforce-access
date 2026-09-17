-- Texas Healthcare Workforce Access & Community Need Analysis
-- Script 02: Create county-level analytic metrics

-- Health burden indicators from CDC PLACES.
-- Update the measure_id values after the final CDC PLACES measure list is selected.

CREATE VIEW vw_county_health_burden AS
SELECT
    county_fips,
    AVG(
        CASE
            WHEN measure_id IN (
                'DIABETES',
                'OBESITY',
                'CHD',
                'COPD',
                'STROKE',
                'PHLTH',
                'MHLTH'
            )
            THEN estimate_value
        END
    ) AS health_burden_avg
FROM fact_places_health
GROUP BY county_fips;

-- Prevention gap indicators from CDC PLACES.
-- For measures where higher is better, the gap can be calculated as 100 - estimate.

CREATE VIEW vw_county_prevention_gaps AS
SELECT
    county_fips,
    AVG(
        CASE
            WHEN measure_id IN (
                'CHECKUP',
                'DENTAL',
                'COLON_SCREEN',
                'MAMMOUSE'
            )
            THEN 100 - estimate_value
        END
    ) AS prevention_gap_avg
FROM fact_places_health
GROUP BY county_fips;

-- Workforce access summary.
-- Lower provider availability indicates higher access need.

CREATE VIEW vw_county_workforce_access AS
SELECT
    county_fips,
    AVG(providers_per_10k) AS avg_providers_per_10k,
    MIN(providers_per_10k) AS lowest_provider_ratio,
    SUM(provider_count) AS total_provider_count
FROM fact_workforce
GROUP BY county_fips;

-- Shortage designation summary.

CREATE VIEW vw_county_shortage_summary AS
SELECT
    county_fips,
    COUNT(*) AS shortage_designation_count,
    AVG(hpsa_score) AS avg_hpsa_score,
    SUM(fte_short) AS total_fte_short
FROM fact_shortage_area
WHERE status IS NULL OR LOWER(status) IN ('designated', 'active')
GROUP BY county_fips;

-- Facility access summary.

CREATE VIEW vw_county_facility_access AS
SELECT
    county_fips,
    SUM(facility_count) AS total_facility_count,
    SUM(hospital_count) AS total_hospital_count,
    MAX(critical_access_flag) AS has_critical_access_hospital
FROM fact_facility
GROUP BY county_fips;

-- Combined county metric view for Power BI.

CREATE VIEW vw_county_access_metrics AS
SELECT
    c.county_fips,
    c.county_name,
    c.state,
    c.region,
    c.rural_urban_status,
    c.gulf_coast_flag,
    c.border_county_flag,
    hb.health_burden_avg,
    pg.prevention_gap_avg,
    wa.avg_providers_per_10k,
    wa.lowest_provider_ratio,
    wa.total_provider_count,
    ss.shortage_designation_count,
    ss.avg_hpsa_score,
    ss.total_fte_short,
    fa.total_facility_count,
    fa.total_hospital_count,
    fa.has_critical_access_hospital
FROM dim_county c
LEFT JOIN vw_county_health_burden hb
    ON c.county_fips = hb.county_fips
LEFT JOIN vw_county_prevention_gaps pg
    ON c.county_fips = pg.county_fips
LEFT JOIN vw_county_workforce_access wa
    ON c.county_fips = wa.county_fips
LEFT JOIN vw_county_shortage_summary ss
    ON c.county_fips = ss.county_fips
LEFT JOIN vw_county_facility_access fa
    ON c.county_fips = fa.county_fips;

