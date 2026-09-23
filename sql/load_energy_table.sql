\copy country_energy (
    country,
    iso_code,
    year,
    population,
    energy_per_capita,
    renewables_consumption,
    renewables_share_energy,
    renewables_electricity,
    renewables_share_elec,
    fossil_fuel_consumption,
    fossil_share_energy,
    fossil_electricity,
    fossil_share_elec,
    electricity_generation,
    carbon_intensity_elec
)
FROM 'C:/Users/artbe/Documents/tools projects/environmental/country_energy_clean.csv'
WITH (
    FORMAT csv,
    HEADER true,
    NULL ''
);