### COVID-19 Data Analysis Project README

---

#### **Overview**

This project utilizes two datasets, `covid_deaths` and `covid_vaccinations`, to analyze global trends and insights related to COVID-19 cases, deaths, testing, and vaccination. 
The analysis was conducted using MySQL queries, focusing on patterns such as total_deaths, new_deaths, and people_fully_vaccinated.

---

#### **Database Setup**

1. **Database Creation**:
   - Database used: `portfolioproject`.

2. **Tables Created**:
   - **`covid_deaths`**:
     Contains data on COVID-19 deaths, and hospital admissions across various countries and continents.
   - **`covid_vaccinations`**:
     Contains vaccination statistics and population in different continents.

3. **Data Import**:
   - Datasets were imported using the `LOAD DATA INFILE` command. Necessary adjustments to the `secure_file_priv` setting were made to enable file imports. Set it to ""

4. **Column Adjustments**:
   - The `population` column in `covid_deaths` was modified to `BIGINT` to accommodate larger values.
   - The `new_tests` column in `covid_vaccinations` was adjusted to `INT` to prevent out-of-range errors.

---

#### **Queries and Analysis**

##### **Data Cleaning**
- Ensured no null values in key columns such as `continent` by filtering out invalid data.
- Renamed columns for consistency (e.g., `new_tests` to `new_cases` in `covid_deaths`).

##### **Key Analyses**

1. **Total Cases and Deaths**:
   - Query to calculate the death percentage for countries like the United States:
     ```sql
     SELECT continent, location, date, total_cases, total_deaths, 
            (total_deaths/total_cases)*100 AS death_percentage
     FROM portfolioproject.covid_deaths
     WHERE location LIKE '%states%' AND continent IS NOT NULL
     ORDER BY 1, 2, 3;
     ```

2. **Infection Rate by Population**:
   - Query to calculate the percentage of the population infected:
     ```sql
     SELECT location, date, total_cases, population, 
            (total_cases/population)*100 AS cases_percentage
     FROM portfolioproject.covid_deaths
     WHERE location LIKE '%states%' AND continent IS NOT NULL
     ORDER BY 1, 2;
     ```

3. **Countries with Highest Infection Rates**:
   - Identified countries with the highest percentage of their population infected:
     ```sql
     SELECT continent, location, population, MAX(total_cases) AS highest_infection_count, 
            MAX((total_cases/population))*100 AS percentage_population_infected
     FROM portfolioproject.covid_deaths
     WHERE continent IS NOT NULL
     GROUP BY continent, location
     ORDER BY percentage_population_infected DESC;
     ```

4. **Vaccination Impact**:
   - Queries included comparisons of vaccination rates with infection and mortality rates.

---

#### **Technical Challenges and Resolutions**

1. **Secure File Import**:
   - Adjusted `secure_file_priv` to allow unrestricted file import.
   - Files were preprocessed to ensure consistent formatting.

2. **Out-of-Range Errors**:
   - Adjusted column sizes (e.g., `new_tests` to `INT`) to accommodate larger data values.

3. **Data Formatting**:
   - Used `NULLIF` and `CASE` statements to handle inconsistent or missing data during imports.

---

#### **Insights and Learnings**

1. The likelihood of dying from COVID-19 varies significantly across countries, influenced by healthcare quality.
2. The percentage of population infected is important in understanding the spread of the virus relative to total population size.
3. Vaccination data highlights disparities in access and coverage across continents.

---

#### **Future Work**
Present the data in Tableau

---
