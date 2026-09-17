-- Texas Healthcare Workforce Access & Community Need Analysis
-- Script 01: Create starter tables

CREATE TABLE dim_county (
    county_fips TEXT PRIMARY KEY,
    county_name TEXT NOT NULL,
    state TEXT NOT NULL,
    region TEXT,
    rural_urban_status TEXT,
    gulf_coast_flag INTEGER DEFAULT 0,
    border_county_flag INTEGER DEFAULT 0
);

CREATE TABLE dim_measure (
    measure_id TEXT PRIMARY KEY,
    measure_name TEXT NOT NULL,
    measure_category TEXT,
    source TEXT,
    numerator_definition TEXT,
    denominator_definition TEXT
);

CREATE TABLE fact_places_health (
    county_fips TEXT NOT NULL,
    measure_id TEXT NOT NULL,
    measure_name TEXT,
    measure_category TEXT,
    estimate_value REAL,
    confidence_interval_low REAL,
    confidence_interval_high REAL,
    data_year INTEGER,
    source TEXT DEFAULT 'CDC PLACES',
    PRIMARY KEY (county_fips, measure_id, data_year),
    FOREIGN KEY (county_fips) REFERENCES dim_county(county_fips)
);

CREATE TABLE fact_workforce (
    county_fips TEXT NOT NULL,
    profession TEXT NOT NULL,
    provider_count INTEGER,
    population INTEGER,
    providers_per_10k REAL,
    data_year INTEGER,
    source TEXT DEFAULT 'HRSA AHRF',
    PRIMARY KEY (county_fips, profession, data_year),
    FOREIGN KEY (county_fips) REFERENCES dim_county(county_fips)
);

CREATE TABLE fact_shortage_area (
    shortage_area_id TEXT,
    county_fips TEXT NOT NULL,
    shortage_type TEXT NOT NULL,
    designation_type TEXT,
    hpsa_score REAL,
    fte_short REAL,
    rural_status TEXT,
    status TEXT,
    data_year INTEGER,
    source TEXT DEFAULT 'HRSA',
    FOREIGN KEY (county_fips) REFERENCES dim_county(county_fips)
);

CREATE TABLE fact_facility (
    county_fips TEXT NOT NULL,
    facility_type TEXT NOT NULL,
    facility_count INTEGER,
    hospital_count INTEGER,
    critical_access_flag INTEGER DEFAULT 0,
    data_year INTEGER,
    source TEXT DEFAULT 'CMS Provider Characteristics',
    PRIMARY KEY (county_fips, facility_type, data_year),
    FOREIGN KEY (county_fips) REFERENCES dim_county(county_fips)
);

CREATE TABLE fact_priority_score (
    county_fips TEXT PRIMARY KEY,
    workforce_shortage_score REAL,
    health_burden_score REAL,
    facility_access_score REAL,
    population_vulnerability_score REAL,
    priority_score REAL,
    county_rank INTEGER,
    FOREIGN KEY (county_fips) REFERENCES dim_county(county_fips)
);

