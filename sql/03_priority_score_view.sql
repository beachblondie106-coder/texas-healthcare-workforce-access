-- Texas Healthcare Workforce Access & Community Need Analysis
-- Script 03: Draft priority scoring view

-- This view uses a first-pass scoring structure.
-- Final scoring should be validated after reviewing distributions and missing values.

CREATE VIEW vw_priority_score_draft AS
WITH base AS (
    SELECT
        county_fips,
        county_name,
        state,
        region,
        rural_urban_status,
        gulf_coast_flag,
        border_county_flag,
        health_burden_avg,
        prevention_gap_avg,
        avg_providers_per_10k,
        shortage_designation_count,
        avg_hpsa_score,
        total_fte_short,
        total_facility_count,
        total_hospital_count
    FROM vw_county_access_metrics
),
ranked AS (
    SELECT
        base.*,
        PERCENT_RANK() OVER (ORDER BY health_burden_avg) * 100 AS health_burden_score,
        PERCENT_RANK() OVER (ORDER BY prevention_gap_avg) * 100 AS prevention_gap_score,
        PERCENT_RANK() OVER (ORDER BY avg_providers_per_10k DESC) * 100 AS workforce_ratio_score,
        PERCENT_RANK() OVER (ORDER BY COALESCE(avg_hpsa_score, 0)) * 100 AS hpsa_score_index,
        PERCENT_RANK() OVER (ORDER BY COALESCE(total_facility_count, 0) DESC) * 100 AS facility_access_score
    FROM base
)
SELECT
    county_fips,
    county_name,
    state,
    region,
    rural_urban_status,
    gulf_coast_flag,
    border_county_flag,
    health_burden_avg,
    prevention_gap_avg,
    avg_providers_per_10k,
    shortage_designation_count,
    avg_hpsa_score,
    total_fte_short,
    total_facility_count,
    total_hospital_count,
    (
        (workforce_ratio_score * 0.50)
        + (hpsa_score_index * 0.50)
    ) AS workforce_shortage_score,
    (
        (health_burden_score * 0.70)
        + (prevention_gap_score * 0.30)
    ) AS community_health_score,
    facility_access_score,
    (
        (
            ((workforce_ratio_score * 0.50) + (hpsa_score_index * 0.50)) * 0.35
        )
        + (
            ((health_burden_score * 0.70) + (prevention_gap_score * 0.30)) * 0.30
        )
        + (facility_access_score * 0.20)
    ) AS priority_score
FROM ranked;

