select * from [dbo].[covid deaths]
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from [dbo].[covid deaths] 
order by 1,2

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercent
from [dbo].[covid deaths] 
where location='india'
order by 1,2


select location,date,total_cases,population,(total_cases/population)*100 as InfectionPercent
from [dbo].[covid deaths] 
where location='india'
order by 1,2

select location,population,date,max(total_cases)as HighestInfectionCount,max((total_cases/population))*100 as InfectionPercent
from [dbo].[covid deaths] 
group by location,population,date
order by InfectionPercent desc


select location,max(cast(total_deaths as int))as HighestDeathCount
from [dbo].[covid deaths] 
where continent is Null
and location not in('world','Upper middle income','High income','Low income','Lower middle income','International','European Union')
group by location
order by HighestDeathCount desc
 
 select continent,max(cast(total_deaths as int))as HighestDeathCount
from [dbo].[covid deaths] 
where continent is not Null
group by continent
order by HighestDeathCount desc


select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercent
from  [dbo].[covid deaths]
where continent is not Null
order by 1,2

select d.continent,d.location,d.date,d.population,v.new_vaccinations
from [dbo].[covid deaths] d
join [dbo].[covid vaccination] v
on d.location=v.location
and d.date=v.date
where d.continent is not null
order by 2,3

select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(convert(int,v.new_vaccinations))over (partition by d.location order by d.location,d.date)as RollingPeopleVaccinated
from [dbo].[covid deaths] d
join [dbo].[covid vaccination] v
on d.location=v.location
and d.date=v.date
where d.continent is not null
order by 2,3

with PopvsVac(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(convert(int,v.new_vaccinations))over (partition by d.location order by d.location,d.date)as RollingPeopleVaccinated
from [dbo].[covid deaths] d
join [dbo].[covid vaccination] v
on d.location=v.location
and d.date=v.date
where d.continent is not null
)

select *,(RollingPeopleVaccinated/Population)*100
from PopvsVac


create view PercentPopulationVaccinated as
select d.continent,d.location,d.date,d.population,v.new_vaccinations,
sum(convert(int,v.new_vaccinations))over (partition by d.location order by d.location,d.date)as RollingPeopleVaccinated
from [dbo].[covid deaths] d
join [dbo].[covid vaccination] v
on d.location=v.location
and d.date=v.date
where d.continent is not null

select * from PercentPopulationVaccinated

