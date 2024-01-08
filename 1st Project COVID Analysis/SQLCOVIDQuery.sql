/* COVID PROJECT */

SELECT * FROM [Covid-Project]..[Covid-Deaths]
ORDER BY 3,4 -- OREDER BY Location & Date

SELECT * FROM [Covid-Project]..[Covid-Vaccination]
ORDER BY 3,4

/* Select the Data that we are going to be using */

SELECT location, date,  total_cases, new_cases, total_deaths, population
FROM [Covid-Project]..[Covid-Deaths]
ORDER BY 1,2 -- OREDER BY Location & Date



/***************************************************************************************************** 
   Looking at Total Cases vs Total Deaths 
   How many cases are there in this country and How many deaths do they have for their entire cases.
   What's the percentage of the people who died who were infected */

/* The following is not working because the Data type of the total_deaths & total_cases are nvarchar, it should be float to preform arthematic operations */
/* SELECT location, date,  total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
ORDER BY 1,2 */

/* The following shows the data type of all the columns in the table (ex : COVID-DEATHS) */
EXEC sp_columns 'Covid-Deaths';

/* The following Query convert the column data type temparorliy into float without ALerting the table */

/* CHATGPT CODE */
/* SELECT location, date, total_cases, total_deaths, 
CASE
	WHEN ISNUMERIC(total_deaths) = 1 AND ISNUMERIC(total_cases) = 1 
    THEN (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100
    ELSE NULL  -- Handle cases where data is not numeric
END AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
WHERE continent IS NULL
ORDER BY 1,2 */

/* My CODE but same result */
SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS INT)/CAST(total_cases AS INT)) *100 AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
WHERE continent IS NULL
ORDER BY 1,2

/* To see highest Death percent in India */
SELECT location, date, total_cases, total_deaths, (CAST(total_deaths AS INT)/CAST(total_cases AS INT)) *100 AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
WHERE location = 'India'
ORDER BY 5 DESC

/* To see highest Death percent in all countries */
SELECT location, 
       MAX(date) AS Date,
       MAX(total_cases) AS total_cases,
       MAX(total_deaths) AS total_deaths,
       MAX((CAST(total_deaths AS INT)/CAST(total_cases AS INT)) *100) AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
GROUP BY location
ORDER BY Death_Percent DESC;

/* To the at which place the country rank among all */
WITH DeathPercentCTE AS (
    SELECT
        location,
        MAX(date) AS date,
        MAX(total_cases) AS total_cases,
        MAX(total_deaths) AS total_deaths,
        MAX((CAST(total_deaths AS float)/CAST(total_cases AS float)) *100) AS Death_Percent,
        RANK() OVER (ORDER BY MAX((CAST(total_deaths AS Float)/CAST(total_cases AS float)) *100 ) DESC) AS Rank
    FROM [Covid-Project]..[Covid-Deaths]
    GROUP BY location
)

SELECT
    location,
    Death_Percent,
    Rank
FROM DeathPercentCTE
WHERE location = 'India';

/*The difference is the data type to which the columns are convernted */

WITH DeathPercentCTE AS (
    SELECT
        location,
        MAX(date) AS date,
        MAX(total_cases) AS total_cases,
        MAX(total_deaths) AS total_deaths,
        MAX(CASE
			WHEN ISNUMERIC(total_deaths) = 1 AND ISNUMERIC(total_cases) = 1 
			THEN (CAST(total_deaths AS float) / CAST(total_cases AS float)) * 100
			ELSE NULL  -- Handle cases where data is not numeric
		END) AS Death_Percent,
        RANK() OVER (ORDER BY MAX((CAST(total_deaths AS INT)/CAST(total_cases AS INT)) *100 ) DESC) AS Rank
    FROM [Covid-Project]..[Covid-Deaths]
    GROUP BY location
)

SELECT
    location,
    Death_Percent,
    Rank
FROM DeathPercentCTE
WHERE location = 'India';

/******************************************************************************************************
  Looking at the Total cases vs Population
  Shows what percentage of population got covid */
SELECT location, date, total_cases, population, (CAST(total_cases AS float)/population)*100 AS Population_Infected
FROM [Covid-Project]..[Covid-Deaths]
WHERE location = 'India' 
ORDER BY 5 DESC

/* Total Death Count */ 
SELECT location, MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM [Covid-Project]..[Covid-Deaths]
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathCount DESC


/* Showing contintents with the highest death count per population */
SELECT continent, MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM [Covid-Project]..[Covid-Deaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC

/* GLOBAL NUBERS */

/* Number of Deaths and Cases along with the Death percentage according to the dates all over the world */
SELECT date, SUM(new_cases) AS Cases, SUM(new_deaths) AS Deaths, (SUM(new_deaths)/NULLIF(SUM(new_cases),0))*100 AS Death_Percent
FROM [Covid-Project]..[Covid-Deaths]
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2

/* GPT code */
SELECT
    date,
    SUM(new_cases) AS Cases,
    SUM(new_deaths) AS Deaths,
    CASE
        WHEN SUM(new_cases) = 0 THEN NULL
        ELSE (SUM(new_deaths) / NULLIF(SUM(new_cases), 0)) * 100
    END AS Death_Percent
FROM
    [Covid-Project]..[Covid-Deaths]
WHERE
    continent IS NULL
--GROUP BY
--    date
ORDER BY
    date;


/* Looking at Total Population vs Vaccinations */

SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations
FROM [Covid-Project]..[Covid-Deaths] CD
JOIN [Covid-Project]..[Covid-Vaccination] CV
ON CD.location = CV.location
AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
ORDER BY 1,2,3


/* Adding up with the pervious row in the RollingPeopleVaccinated */
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(Float,CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CV.location, CV.date) AS RollingPeopleVaccinated
FROM [Covid-Project]..[Covid-Deaths] CD
JOIN [Covid-Project]..[Covid-Vaccination] CV
ON CD.location = CV.location
AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
ORDER BY 2,3

/* Using CTE 
   Pop - Population
   VS
   Vac - Vaccination*/

WITH PopVSVac (continent, location, date, population, new_vaccination, rollingpeoplevaccinated)
AS (
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(Float,CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CV.location, CV.date) AS RollingPeopleVaccinated
FROM [Covid-Project]..[Covid-Deaths] CD
JOIN [Covid-Project]..[Covid-Vaccination] CV
ON CD.location = CV.location
AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
--ORDER BY 2,3
)

SELECT *, (rollingpeoplevaccinated/population)*100
FROM PopVSVac


/* TEMP TABLE */
DROP Table IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinated
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(Float,CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CV.location, CV.date) AS RollingPeopleVaccinated
FROM [Covid-Project]..[Covid-Deaths] CD
JOIN [Covid-Project]..[Covid-Vaccination] CV
ON CD.location = CV.location
AND CD.date = CV.date
--WHERE CD.continent IS NOT NULL
--ORDER BY 2,3

SELECT *, (rollingpeoplevaccinated/population)*100
FROM #PercentPopulationVaccinated


/* Creating View to store data for later visualization */

Create View PercentPopulationVaccinated AS
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(Float,CV.new_vaccinations)) OVER (PARTITION BY CD.location ORDER BY CV.location, CV.date) AS RollingPeopleVaccinated
FROM [Covid-Project]..[Covid-Deaths] CD
JOIN [Covid-Project]..[Covid-Vaccination] CV
ON CD.location = CV.location
AND CD.date = CV.date
WHERE CD.continent IS NOT NULL
--ORDER BY 2,3

SELECT * FROM PercentPopulationVaccinated
