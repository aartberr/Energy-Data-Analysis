-- 1a. Countries with the highest renewable electricity share in 2023
SELECT
    country,
    iso_code,
    year,
    renewables_share_elec,
    fossil_share_elec
FROM country_energy
WHERE year = 2023
  AND renewables_share_elec IS NOT NULL
ORDER BY renewables_share_elec DESC
LIMIT 10;

-- 1b. Countries with the highest renewable electricity share in 2025
SELECT
        country,
        iso_code,
        year,
        renewables_share_elec,
        fossil_share_elec
FROM country_energy
WHERE year = 2025
    AND renewables_share_elec IS NOT NULL
ORDER BY renewables_share_elec DESC
LIMIT 10;

-- 2. Countries that reduced fossil-fuel dependence from their first
-- available observation to their last available observation
WITH first_year AS (
    SELECT
        iso_code,
        MIN(year) AS first_year
    FROM country_energy
    WHERE fossil_share_energy IS NOT NULL
    GROUP BY iso_code
),
first_values AS (
    SELECT
        c.iso_code,
        c.country,
        c.year AS first_year,
        c.fossil_share_energy AS fossil_share_first
    FROM country_energy c
    JOIN first_year fy
        ON c.iso_code = fy.iso_code
       AND c.year = fy.first_year
),
last_year AS (
    SELECT
        iso_code,
        MAX(year) AS last_year
    FROM country_energy
    WHERE fossil_share_energy IS NOT NULL
    GROUP BY iso_code
),
last_values AS (
    SELECT
        c.iso_code,
        c.fossil_share_energy AS fossil_share_last
    FROM country_energy c
    JOIN last_year ly
        ON c.iso_code = ly.iso_code
       AND c.year = ly.last_year
)
SELECT
    fv.country,
    fv.iso_code,
    fv.fossil_share_first,
    lv.fossil_share_last,
    fv.fossil_share_first - lv.fossil_share_last
        AS reduction_pct_points
FROM first_values fv
JOIN last_values lv
    ON fv.iso_code = lv.iso_code
ORDER BY reduction_pct_points DESC
LIMIT 10;

-- 3. Countries with the highest energy consumption per person in 2023
SELECT
    country,
    iso_code,
    year,
    energy_per_capita
FROM country_energy
WHERE year = 2023
  AND energy_per_capita IS NOT NULL
ORDER BY energy_per_capita DESC
LIMIT 10;

-- 4. Countries with the highest initial carbon intensity and the reduction
-- to their last available observation
WITH first_year AS (
    SELECT iso_code, MIN(year) AS first_year
    FROM country_energy
    WHERE carbon_intensity_elec IS NOT NULL
    GROUP BY iso_code
),
first_values AS (
    SELECT
        c.country,
        c.iso_code,
        c.year AS first_year,
        c.carbon_intensity_elec AS carbon_first
    FROM country_energy c
    JOIN first_year fy
        ON c.iso_code = fy.iso_code
       AND c.year = fy.first_year
),
last_year AS (
    SELECT iso_code, MAX(year) AS last_year
    FROM country_energy
    WHERE carbon_intensity_elec IS NOT NULL
    GROUP BY iso_code
),
last_values AS (
    SELECT
        c.iso_code,
        c.year AS last_year,
        c.carbon_intensity_elec AS carbon_last
    FROM country_energy c
    JOIN last_year ly
        ON c.iso_code = ly.iso_code
       AND c.year = ly.last_year
)
SELECT
    fv.country,
    fv.iso_code,
    fv.first_year,
    lv.last_year,
    fv.carbon_first,
    lv.carbon_last,
    fv.carbon_first - lv.carbon_last
        AS reduction_in_carbon_intensity
FROM first_values fv
JOIN last_values lv
    ON fv.iso_code = lv.iso_code
ORDER BY fv.carbon_first DESC
LIMIT 10;