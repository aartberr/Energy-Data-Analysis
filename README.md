# Global Energy Data Analysis

This project analyses global energy data, focusing on renewable electricity, fossil-fuel dependence, energy consumption per person, and electricity carbon intensity across countries and over time.

The project uses country-level data from the Our World in Data Energy dataset and combines data preparation with SQL-based analysis.

## **Analysis Questions**

The project addresses the following questions:

1. Which countries have the highest renewable share of electricity in 2023 and 2025?
2. Which countries reduced fossil-fuel dependence between their first and last available observations?
3. How does energy consumption per person vary between countries in 2023?
4. Which countries had the highest initial electricity carbon intensity, and how much did it change by their last available observation?

## **Data Preparation**

The raw dataset is processed using `main.py`.

The script:

- Loads the Our World in Data energy dataset.
- Selects the variables required for the analysis.
- Removes regional and global aggregate rows.
- Keeps country-level records with valid ISO codes.
- Checks for missing country identifiers.
- Checks for duplicate country-year records.
- Exports the cleaned dataset as `country_energy_clean.csv`.

## **Dataset**

The project uses the following dataset:

[Our World in Data Energy Dataset](https://github.com/owid/energy-data)

The cleaned dataset contains:

- 17,265 country-year records
- 220 countries
- Data covering the period from 1900 to 2025
- 15 selected energy and electricity variables

## **SQL Analysis**

The SQL analysis is divided into four main analytical tasks:

1. Renewable electricity share for 2023 and 2025.
2. Reduction in fossil-fuel dependence over time.
3. Energy consumption per person in 2023.
4. Reduction in electricity carbon intensity from the first to the last available observation.

The SQL scripts support both PostgreSQL and BigQuery analysis.

## **PostgreSQL**

The cleaned dataset can be loaded into PostgreSQL using the scripts in the `sql` folder.

The PostgreSQL workflow includes:

- Creating the `country_energy` table.
- Loading the cleaned CSV file.
- Running the analysis queries.

## **BigQuery**

The cleaned dataset was also uploaded to Google BigQuery as the `country_energy` table inside the `energy_transition` dataset.

The same analytical questions were then executed in BigQuery, and the results were exported as CSV files.

## **Key Features**

- Country-level data validation and cleaning.
- Removal of aggregate rows.
- Duplicate country-year validation.
- Full historical country-level dataset.
- PostgreSQL table creation and CSV loading.
- Analytical SQL queries using joins, aggregation, ordering, and time comparisons.
- BigQuery cloud warehouse analysis.
- Separate exported result tables for each research question.
- A report presenting the main findings and limitations.

## **Files**

- `main.py` – Loads, validates, filters, and exports the energy dataset.
- `owid-energy-data.csv` – Raw Our World in Data energy dataset.
- `country_energy_clean.csv` – Cleaned country-level dataset.
- `renewable_energy_analysis.pdf` – Project report.
- `sql/create_energy_table.sql` – Creates the PostgreSQL table.
- `sql/load_energy_table.sql` – Loads the cleaned CSV into PostgreSQL.
- `sql/analysis_queries.sql` – Contains the four main SQL analyses.
- `bigquery_results/` – Contains the exported BigQuery analysis results.

## **Usage**

1. **Run the data preparation script**:  
   ```bash
   python main.py
   ```
  
2.a. **Run the PostgreSQL workflow**:  
   ```bash
   psql -U postgres -d energy_db -f sql/create_energy_table.sql
   psql -U postgres -d energy_db -f sql/load_energy_table.sql
   psql -U postgres -d energy_db -f sql/analysis_queries.sql
   ```
or 

2.b. **Run the BigQuery analysis**:  
   ```bash
   Upload country_energy_clean.csv to the energy_transition dataset in BigQuery and create a table named country_energy. The same analysis questions can then be run using BigQuery SQL.
   ```

## **Future Work**  

- Add visualisations or a BI dashboard.
- Extend the analysis with additional energy and emissions indicators.
