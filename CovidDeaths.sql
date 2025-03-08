Select * from CovidDeaths order by 3,4

Select * from INFORMATION_SCHEMA.COLUMNS where table_name like 'CovidDeaths'

--Looking at Total Cases VS Total Deaths All over World
Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 [DeathPercentage] 
from CovidDeaths 
where continent is not null
order by 1,2

--Looking at Total Cases VS Total Deaths in India
Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 [DeathPercentage] 
from CovidDeaths 
where location like'India' and continent is not null
order by 1,2

--Looking at Total Cases VS Population 
Select location,date,total_cases,population,(total_cases/population)*100 [CasesPercentage] 
from CovidDeaths 
where location like'India' and continent is not null

--Looking at Countries with Highest Infection Rate compare to The Population
Select location,population,MAX(total_cases) [Total Cases],MAX((total_cases/population))*100 [CasesPercentage] 
from CovidDeaths 
where continent is not null
Group by location,population
order by 4 desc

--Looking at India with Highest Infection Rate compare to The Population
Select location,population,MAX(total_cases) [Total Cases],MAX((total_cases/population))*100 [CasesPercentage] 
from CovidDeaths 
where location like 'India' and continent is not null
Group by location,population

--Looking at Countries with Highest Death Count per Population
Select location,population,MAX(cast(total_deaths as int)) [Total Death]
from CovidDeaths 
where continent is not null
Group by location,population
order by 3 desc

--Looking at India with Highest Death Count per Population
Select location,population,MAX(total_deaths) [Total Death],MAX((total_deaths/population))*100 [DeathPercentage] 
from CovidDeaths 
where location like 'India' and continent is not null
Group by location,population
order by 4 desc


--Looking at Continent with Highest Death Count per Population
Select continent,MAX(cast(total_deaths as int)) [Total Death]
from CovidDeaths 
where continent is not null
Group by continent
order by 2 Desc

-- Continent with the Highest Death Count
Select continent,Sum(cast(total_deaths as int)) [Total Deaths]
from CovidDeaths
where continent is not null
Group by continent
Order By 2 Desc

--Global Record
Select date, Sum(new_cases) [Cases], Sum(cast(new_deaths as int)) [Deaths],
(Sum(cast(total_deaths as int))/Sum(total_cases))*100 [Death Percentage]
from CovidDeaths
where continent is not null
Group by date
Order By 1,2


