select * from [dbo].[athlete_events$] 
select * from [dbo].[noc_regions$]

--Total participated athletes
Select count(distinct(name)) 
from [dbo].[athlete_events$]

--Number of athletes who won
Select count(distinct(name)) 
from [dbo].[athlete_events$]
where medal<>'na' 

--Countries with highest medals

Select team,count(medal) as medal_won
from [dbo].[athlete_events$]
where Medal<>'NA'
group by medal,team
order by medal_won desc

--Average age of male and female who won a medal

select sex,avg(age) as avg_Age from [dbo].[athlete_events$]
where Medal<>'NA'
group by sex,age

--Sports in which female athletes have won most medals

select sport,count(medal) as medal_count from [dbo].[athlete_events$]
where sex='F'
group by medal,sport
order by medal_count

--Total number of sports
SELECT COUNT(DISTINCT sport) FROM [dbo].[athlete_events$]

--Total number of events
SELECT COUNT(DISTINCT event) FROM [dbo].[athlete_events$]

--Top 5 youngest atheletes
SELECT DISTINCT name, CAST(age AS INTEGER), sport, event, noc, games, city, medal FROM [dbo].[athlete_events$]
WHERE age <> 'NA'
ORDER BY age
LIMIT 5

--Top 5 Oldest athelets
SELECT DISTINCT name, CAST(age AS INTEGER), sport, event,noc, games, city, medal FROM [dbo].[athlete_events$]
WHERE age <> 'NA'
ORDER BY age DESC
LIMIT 5

--Top 5 heaviest athletes
SELECT DISTINCT name, CAST(weight AS DECIMAL), sport, event, noc, games, city, medal FROM [dbo].[athlete_events$]
WHERE weight <> 'NA'
ORDER BY weight DESC
LIMIT 5

--Which region had most participants
Select region,count(name) as Participants
from [dbo].[athlete_events$] a
join [dbo].[noc_regions$] b
on a.noc=b.noc
group by region
order by Participants desc


--Canadian who has won most gold medals
 
Select name, gold_number from [dbo].[athlete_events$]
where team = 'Canada'
and gold_number = (
	select max(medal) from [dbo].[athlete_events$]
	where team = 'Canada'
	);

