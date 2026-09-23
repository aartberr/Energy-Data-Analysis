import pandas as pd

# Load the raw Our World in Data energy dataset.
df = pd.read_csv("owid-energy-data.csv")

# Keep only fields required for the project's research questions.
required_columns = [
    "country",
    "iso_code",
    "year",
    "population",
    "energy_per_capita",
    "renewables_consumption",
    "renewables_share_energy",
    "renewables_electricity",
    "renewables_share_elec",
    "fossil_fuel_consumption",
    "fossil_share_energy",
    "fossil_electricity",
    "fossil_share_elec",
    "electricity_generation",
    "carbon_intensity_elec",
]

# Fail early if the source dataset does not match the expected schema.
missing_columns = [column for column in required_columns if column not in df.columns]

if missing_columns:
    raise ValueError(f"Missing required columns: {missing_columns}")

# Exclude regional and global aggregates by requiring an ISO country code.
country_energy = df.loc[df["iso_code"].notna(),required_columns,].copy()

# A country-year pair should identify one unique observation.
if country_energy[["country", "iso_code", "year"]].isna().any().any():
    raise ValueError("Country, ISO code, and year must not be missing")

if country_energy.duplicated(subset=["iso_code", "year"]).any():
    raise ValueError("Duplicate country-year rows found")

# Preserve the full historical country-level dataset for later SQL analysis.
country_energy.to_csv("country_energy_clean.csv", index=False)

print(f"Exported {len(country_energy):,} rows for "
      f"{country_energy['iso_code'].nunique()} countries")