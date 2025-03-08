Select * from CovidVaccinations
Select * from INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME like 'covidvaccinations'

--Looking at Total Population VS Vaccinations

Select CD.continent,CD.location,cd.date,CD.population,CV.new_vaccinations
from CovidDeaths CD JOIN CovidVaccinations CV
ON CD.date=CV.date and CD.location = CV.location
where CD.continent is not null
order by 1,2,3

With PopuVSVaccinated (Continent,Location,Date,Population,new_vaccinations,Total_People_Vaccinated) as(
Select CD.continent,CD.location,cd.date,CD.population,CV.new_vaccinations,
SUM(cast(CV.new_vaccinations as numeric)) OVER(PARTITION BY CD.location ORDER BY cd.date ASC,cd.location)  [Total People Vaccinated]
from CovidDeaths CD JOIN CovidVaccinations CV
ON CD.date=CV.date and CD.location = CV.location
where CD.continent is not null

)
Select Continent,Location,Population,MAX(Total_People_Vaccinated) [Population_Vaccinated], MAX(Total_People_Vaccinated/Population)*100 [Percentage]
from PopuVSVaccinated
Group By Continent,Location,Population
Order By 1


--Temp Table Method
Create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric ,
Total_People_Vaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select CD.continent,CD.location,cd.date,CD.population,CV.new_vaccinations,
SUM(cast(CV.new_vaccinations as numeric)) OVER(PARTITION BY CD.location ORDER BY cd.date ASC,cd.location)  [Total People Vaccinated]
from CovidDeaths CD JOIN CovidVaccinations CV
ON CD.date=CV.date and CD.location = CV.location
where CD.continent is not null

Select *,(Total_People_Vaccinated/Population)*100 [Percentage]
from #PercentPopulationVaccinated


--Creating View

Create View PercentPopulationVaccinated AS
Select CD.continent,CD.location,cd.date,CD.population,CV.new_vaccinations,
SUM(cast(CV.new_vaccinations as numeric)) OVER(PARTITION BY CD.location ORDER BY cd.date ASC,cd.location)  [Total People Vaccinated]
from CovidDeaths CD JOIN CovidVaccinations CV
ON CD.date=CV.date and CD.location = CV.location
where CD.continent is not null

Select * From PercentPopulationVaccinated