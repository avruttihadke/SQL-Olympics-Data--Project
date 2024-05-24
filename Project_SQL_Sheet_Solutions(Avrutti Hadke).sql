-- SQL PROJECT
create database sql_uploads;

use sql_uploads;

create table olympics(
ID int,
Name varchar(200),
Sex varchar(100),
Age int(100),
Height int(100),
Weight int(100),
Team varchar(100),
NOC	varchar(200),
Games varchar(200),
Year int(100),
Season varchar(200),
City varchar(200),
Sport varchar(100),
Event varchar(100),
Medal varchar(100)
);

show variables like 'secure_file_priv';

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Athletes_Cleaned.csv'
into table olympics
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from olympics;

-- 1. Show how many medal counts present for entire data

select Medal,count(Medal) as Medal_Count from olympics 
where Medal <>'NoMedal'
group by Medal
order by Medal_Count;

-- 2. Show count of unique sports present in Olympics

select count(distinct(Sport)) from olympics;

-- 3. Show how many different medals won by team India

select Medal,count(Medal) as Medal_Count,Team from olympics
where Medal not in('NoMedal') and Team='India'
group by Medal
order by Medal_Count;

-- 4. Show event wise medals won by India show from highest to lowest medals won in order

select Event,count(Medal) as Medal_Count,Team from olympics
where Team='India' and Medal not in('NoMedal')
group by Event
order by Medal_Count desc;

-- 5. Show event wise medals won by India in order of year

select Year,Team,Event,count(Medal) as Medal_Count from olympics
where Team='India'and Medal not in('NoMedal')
group by Event,Year
order by Year asc;

-- 6. show country who won maximum medals.

select Team, count(Medal) as Medal_count from olympics 
where Medal!='NoMedal'
group by Team
order by Medal_Count desc
limit 1;

-- 7.show top 10 countries whowon gold 

select Team,count(Medal) as Medal_Count from olympics 
where Medal='Gold'
group by Team
order by Medal_Count desc
limit 10;

--  8. show in which year did United states won most gold medal 

select Year,Team,count(Medal) as Medal_Count from olympics 
where Medal='Gold' and Team='United States'
group by Year
order by Medal_Count desc
limit 1;

-- 9. In which sports United States has most medals.

select Sport, Team,count(Medal) as Medal_Count from olympics 
where Medal !='NoMedal' and Team='United States'
group by Sport
order by Medal_Count desc
limit 1;

-- 10. Find top three players who won most medals along with their sports and country

select Name, Sport, Team,count(Medal) as Medal_Count from olympics 
where Medal !='NoMedal'
group by Name,Sport,Team
order by Medal_Count desc
limit 3;

-- 11. Find player with most gold medals in cycling along with his country.

select Name, Sport, Team,count(Medal) as Medal_Count from olympics 
where Sport='Cycling'and Medal ='Gold'
group by Name,Sport,Team
order by Medal_Count desc
limit 1;

-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.

select Name, Sport, Team,count(Medal) as Medal_Count from olympics 
where Sport='Basketball'and Medal !='NoMedal'
group by Name,Sport,Team
order by Medal_Count desc
limit 1;

-- 13. Find out the count of different medals of the top basketball player Teresa Edwards

select Name, Sport, Team, Medal,count(Medal) as Medal_Count from olympics 
where Sport='Basketball'and Name='Teresa Edwards'
group by Name,Sport,Team,Medal
order by Medal_Count desc;

-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel

Select Year, Sex,count(Medal) as Medal_Count from olympics
where Medal !='NoMedal'
group by Year,Sex
order by Year asc;
