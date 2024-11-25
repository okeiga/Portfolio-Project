use portfolioproject;
CREATE TABLE covid_deaths (
    iso_code VARCHAR(30),
    continent VARCHAR(50),
    location VARCHAR(50),
    date DATETIME,
    population INT,
    total_cases INT,
    new_tests MEDIUMINT,
    new_cases_smoothed DOUBLE,
    total_deaths MEDIUMINT,
    new_deaths SMALLINT,
    new_deaths_smoothed DOUBLE,
    total_cases_per_million DOUBLE,
    new_cases_per_million DOUBLE,
    new_cases_smoothed_per_million DOUBLE,
    total_deaths_per_million DOUBLE,
    new_deaths_per_million DOUBLE,
    new_deaths_smoothed_per_million DOUBLE,
    reproduction_rate DOUBLE,
    icu_patients SMALLINT,
    icu_patients_per_million DOUBLE,
    hosp_patients MEDIUMINT,
    hosp_patients_per_million DOUBLE,
    weekly_icu_admissions DOUBLE,
    weekly_icu_admissions_per_million DOUBLE,
    weekly_hosp_admissions DOUBLE,
    weekly_hosp_admissions_per_million DOUBLE
);


-- checking allowed directory for load data infile
/* The allowed directory was local_disk C but had to go to LocaldiskC_ProgramData_MySQL_MySQLserver8.0_my) and changed the code 
in secure-file-priv="" to an empty space to allow load_data_infile to accept files from any directory */

SHOW VARIABLES LIKE 'secure_file_priv';




use portfolioproject;
ALTER TABLE covid_deaths MODIFY population BIGINT;

use portfolioproject;
TRUNCATE TABLE covid_deaths;

-- loading data to the tables
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\covid_deaths.csv' -- file must be stored in local C to show_variables 
INTO TABLE covid_deaths
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(@iso_code, @continent, @location, @date, @population, @total_cases, @new_tests, 
@new_cases_smoothed, @total_deaths, @new_deaths, @new_deaths_smoothed, 
@total_cases_per_million, @new_cases_per_million, @new_cases_smoothed_per_million, 
@total_deaths_per_million, @new_deaths_per_million, @new_deaths_smoothed_per_million, 
@reproduction_rate, @icu_patients, @icu_patients_per_million, @hosp_patients, 
@hosp_patients_per_million, @weekly_icu_admissions, @weekly_icu_admissions_per_million, 
@weekly_hosp_admissions, @weekly_hosp_admissions_per_million)
SET 
    iso_code = NULLIF(TRIM(@iso_code), ''),
    continent = NULLIF(TRIM(@continent), ''),
    location = NULLIF(TRIM(@location), ''),
    date = STR_TO_DATE(TRIM(@date), '%Y-%m-%d'),  -- Adjust if necessary for your date format
    population = CASE 
                     WHEN @population REGEXP '^-?[0-9]+$' THEN @population -- population can start(^) with one or no ngative(-?) followed by any digit from [0-9] (+) there is atleast one didgit and no characters at the end($)
                     ELSE NULL 
                 END,
    total_cases = NULLIF(@total_cases, ''), -- if empty, replace with NULL
    new_tests = NULLIF(@new_tests, ''),
    new_cases_smoothed = NULLIF(@new_cases_smoothed, ''),
    total_deaths = NULLIF(@total_deaths, ''),
    new_deaths = NULLIF(@new_deaths, ''),
    new_deaths_smoothed = NULLIF(@new_deaths_smoothed, ''),
    total_cases_per_million = NULLIF(@total_cases_per_million, ''),
    new_cases_per_million = NULLIF(@new_cases_per_million, ''),
    new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million, ''),
    total_deaths_per_million = NULLIF(@total_deaths_per_million, ''),
    new_deaths_per_million = NULLIF(@new_deaths_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(@reproduction_rate, ''),
    icu_patients = NULLIF(@icu_patients, ''),
    icu_patients_per_million = NULLIF(@icu_patients_per_million, ''),
    hosp_patients = NULLIF(@hosp_patients, ''),
    hosp_patients_per_million = NULLIF(@hosp_patients_per_million, ''),
    weekly_icu_admissions = NULLIF(@weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million, ''),
    weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = 
        CASE 
            WHEN TRIM(@weekly_hosp_admissions_per_million) = '' THEN NULL
            WHEN @weekly_hosp_admissions_per_million REGEXP '^-?[0-9]+(\.[0-9]+)?$' THEN @weekly_hosp_admissions_per_million -- \. escape character, matches .
            ELSE NULL
        END;



use portfolioproject;
CREATE TABLE covid_vaccinations (
    iso_code VARCHAR(50),
    continent VARCHAR(50),
    location VARCHAR(50),
    date DATE,
    new_tests MEDIUMINT,
    total_tests INT,
    total_tests_per_thousand DOUBLE,
    new_tests_per_thousand DOUBLE,
    new_tests_smoothed MEDIUMINT,
    new_tests_smoothed_per_thousand DOUBLE,
    positive_rate DOUBLE,
    tests_per_case DOUBLE,
    tests_units VARCHAR(50),
    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    new_vaccinations INT,
    new_vaccinations_smoothed INT,
    total_vaccinations_per_hundred DOUBLE,
    people_vaccinated_per_hundred DOUBLE,
    people_fully_vaccinated_per_hundred DOUBLE,
    new_vaccinations_smoothed_per_million MEDIUMINT,
    stringency_index DOUBLE,
    population_density DOUBLE,
    median_age DOUBLE,
    aged_65_older DOUBLE,
    aged_70_older DOUBLE,
    gdp_per_capita DOUBLE,
    extreme_poverty DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE,
    female_smokers DOUBLE,
    male_smokers DOUBLE,
    handwashing_facilities DOUBLE,
    hospital_beds_per_thousand DOUBLE,
    life_expectancy DOUBLE,
    human_development_index DOUBLE
);

-- loading data to covid_vaccinations table

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\covid_vaccinations.csv"
INTO TABLE covid_vaccinations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
( @iso_code, @continent, @location, @date, @new_tests, @total_tests, @total_tests_per_thousand, @new_tests_per_thousand,
@new_tests_smoothed, @new_tests_smoothed_per_thousand, @positive_rate, @tests_per_case, @tests_units,
@total_vaccinations, @people_vaccinated, @people_fully_vaccinated, @new_vaccinations, @new_vaccinations_smoothed,
@total_vaccinations_per_hundred, @people_vaccinated_per_hundred, @people_fully_vaccinated_per_hundred, @new_vaccinations_smoothed_per_million,
@stringency_index, @population_density, @median_age, @aged_65_older, @aged_70_older, @gdp_per_capita, @extreme_poverty,
@cardiovasc_death_rate, @diabetes_prevalence, @female_smokers, @male_smokers, @handwashing_facilities, @hospital_beds_per_thousand,
@life_expectancy, @human_development_index)

SET
	iso_code = NULLIF(TRIM(@iso_code), ''),
	continent = NULLIF(TRIM(@continent), ''),
	location = NULLIF(TRIM(@location), ''),
	date= STR_TO_DATE(TRIM(@date), '%Y-%m-%d'),
	new_tests = NULLIF(TRIM(@new_tests), ''),
	total_tests = NULLIF(TRIM(@total_tests), ''),
	total_tests_per_thousand = NULLIF(TRIM(@total_tests_per_thousand), ''),
	new_tests_per_thousand = NULLIF(TRIM(@new_tests_per_thousand), ''),
    new_tests_smoothed = NULLIF(TRIM(@new_tests_smoothed), ''),
    new_tests_smoothed_per_thousand = NULLIF(TRIM(@new_tests_smoothed_per_thousand), ''),
    positive_rate = NULLIF(TRIM(@positive_rate), ''),
    tests_per_case = NULLIF(TRIM(@tests_per_case), ''),
    tests_units = NULLIF(TRIM(@tests_units), ''),
    total_vaccinations = NULLIF(TRIM(@total_vaccinations), ''),
    people_vaccinated = NULLIF(TRIM(@people_vaccinated), ''),
    people_fully_vaccinated = NULLIF(TRIM(@people_fully_vaccinated), ''),
    new_vaccinations = NULLIF(TRIM(@new_vaccinations), ''),
    new_vaccinations_smoothed= NULLIF(TRIM(@new_vaccinations_smoothed), ''),
    total_vaccinations_per_hundred = NULLIF(TRIM(@total_vaccinations_per_hundred), ''), 
    people_vaccinated_per_hundred = NULLIF(TRIM(@people_vaccinated_per_hundred), ''),
    people_fully_vaccinated_per_hundred = NULLIF(TRIM(@people_fully_vaccinated_per_hundred), ''),
    new_vaccinations_smoothed_per_million = NULLIF(TRIM(@new_vaccinations_smoothed_per_million), ''), 
    stringency_index = NULLIF(TRIM(@stringency_index), ''), 
    population_density = NULLIF(TRIM(@population_density), ''),
    median_age = NULLIF(TRIM(@median_age), ''),
    aged_65_older = NULLIF(TRIM(@aged_65_older), ''),
    aged_70_older = NULLIF(TRIM(@aged_70_older), ''),
    gdp_per_capita = NULLIF(TRIM(@gdp_per_capita), ''),
    extreme_poverty = NULLIF(TRIM(extreme_poverty), ''),
    cardiovasc_death_rate= NULLIF(TRIM(cardiovasc_death_rate), ''),
    diabetes_prevalence = NULLIF(TRIM(diabetes_prevalence), ''), 
    female_smokers = NULLIF(TRIM(female_smokers), ''),
    male_smokers = NULLIF(TRIM(male_smokers), ''),
    handwashing_facilities = NULLIF(TRIM(handwashing_facilities), ''), 
    hospital_beds_per_thousand = NULLIF(TRIM(hospital_beds_per_thousand), ''),
    life_expectancy = NULLIF(TRIM(life_expectancy), ''), 
    human_development_index = NULLIF(TRIM(human_development_index), '');

-- out of range error, adjust new-tests column size
use portfolioproject;
alter table covid_vaccinations
modify column new_tests INT;

-- ANALYSIS
-- correcting column name
use portfolioproject;
alter table covid_deaths
rename column new_tests to new_cases;

select *
from portfolioproject.covid_deaths
where continent is not null -- some location have 'asia' as location instead of continent and have 'null' in continent
order by 3,4;


select continent, location, date, total_cases, new_cases, total_deaths, population
from portfolioproject.covid_deaths
where continent is not null
order by 1,2,3;

-- calculating total cases vs total deaths
-- shows the likelihood of dyin gif you contract covid in your country
select continent, location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
from portfolioproject.covid_deaths
where location like '%states%' and continent is not null
order by 1,2, 3;

-- Total cases vs the population
-- shows percentage population of people who got covid
select location,  date, total_cases, population, (total_cases/population)*100 as cases_percentage
from portfolioproject.covid_deaths
where location like '%states%' and continent is not null
order by 1,2;

select continent, location,  date, total_cases, population, (total_cases/population)*100 as cases_percentage
from portfolioproject.covid_deaths
where location like '%states%' and continent is not null
order by 1,2,3;



-- countries with highest infection rate compared to population
select continent, location, population, MAX(total_cases) as highest_infection_count, MAX((total_cases/population))*100 as percentage_population_infected
from portfolioproject.covid_deaths
-- where location like '%states%'
where continent is not null
Group by continent, population, location
order by percentage_population_infected desc;

-- continents with highest death count per population

select continent, MAX(total_deaths) as total_death_count
from portfolioproject.covid_deaths
-- where location like '%states%'
where continent is not null
Group by continent
order by total_death_count desc;



-- ANALYSIS BY CONTINENT
-- continents with the highest death count

select continent, MAX(total_deaths) as total_death_count
from portfolioproject.covid_deaths
where continent is not null
Group by continent
order by total_death_count desc;

-- GLOBAL NUMBERS
select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
from portfolioproject.covid_deaths
-- where location like '%states%' and 
where continent is not null
order by 1,2;

Select date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_percentage
from portfolioproject.covid_deaths
where continent is not null
group By date
order by 1,2;

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_percentage
from portfolioproject.covid_deaths
where continent is not null
-- group By date
order by 1,2;

-- Vaccination table
Select * 
From portfolioproject.covid_vaccinations;

-- Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location
, dea.date) as rolling_people_vaccinated -- (rolling_people_vaccinated/dea.populationn)*100 use CTE
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac. date
where dea.continent is not null
order by 2,3;

-- USE CTE
With PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
as 
(Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location
, dea.date) as rolling_people_vaccinated 
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac. date
where dea.continent is not null)

select *, (rolling_people_vaccinated/population) * 100
from PopvsVac;


-- TEMP TABLE
Drop table if exists percent_population_vaccinated;
Create Temporary Table percent_population_vaccinated
(
continent varchar(50),
location varchar (50),
date datetime,
population bigint,
new_vaccination bigint,
rolling_people_vaccinated bigint );

Insert into percent_population_vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location
, dea.date) as rolling_people_vaccinated -- (rolling_people_vaccinated/dea.populationn)*100 use CTE
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac. date
where dea.continent is not null
order by 2,3; 

select *, (rolling_people_vaccinated/population) * 100
from percent_population_vaccinated;

-- Creating views to store data for later visualizations
create view percent_population_vaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.location Order by dea.location
, dea.date) as rolling_people_vaccinated -- (rolling_people_vaccinated/dea.populationn)*100 use CTE
From portfolioproject.covid_deaths dea
Join portfolioproject.covid_vaccinations vac
	On dea.location = vac.location
	and dea.date = vac. date
where dea.continent is not null;

select * 
from percent_population_vaccinated;
















