CREATE TABLE IF NOT EXISTS country_energy (
    country VARCHAR(200),
    iso_code VARCHAR(20),
    year INTEGER,
    population DOUBLE PRECISION,
    energy_per_capita DOUBLE PRECISION,
    renewables_consumption DOUBLE PRECISION,
    renewables_share_energy DOUBLE PRECISION,
    renewables_electricity DOUBLE PRECISION,
    renewables_share_elec DOUBLE PRECISION,
    fossil_fuel_consumption DOUBLE PRECISION,
    fossil_share_energy DOUBLE PRECISION,
    fossil_electricity DOUBLE PRECISION,
    fossil_share_elec DOUBLE PRECISION,
    electricity_generation DOUBLE PRECISION,
    carbon_intensity_elec DOUBLE PRECISION
);

CREATE UNIQUE INDEX IF NOT EXISTS ux_country_energy_iso_year
ON country_energy (iso_code, year);