------------------------------------ Step1 : Create Database ------------------------------------

create database HR_Analytics
use HR_Analytics


------------------------------------ Step2 : Import Data ------------------------------------

-- After importing data fetch all the records
select * from HR_Data


------------------------------------ Step3 : Data Cleaning ------------------------------------

-- Check null values are there or not

select COUNT(*) cnt
from HR_Data
where not( Attrition is null or [Business Travel] is null or Department is null or 
		   [Education Field] is null or [Employee Number] is null or Gender is null or 
		   [Job Role] is null or [Marital Status] is null or [Over Time] is null or 
		   Over18 is null or Age is null or [Daily Rate] is null or [Distance From Home] is null or
		   Education is null or [Environment Satisfaction] is null or [Hourly Rate] is null or
		   [Job Involvement] is null or [Job Level] is null or [Job Satisfaction] is null or 
		   [Monthly Income] is null or [Monthly Rate] is null or [Num Companies Worked] is null or
		   [Percent Salary Hike] is null or [Performance Rating] is null or 
		   [Relationship Satisfaction] is null or [Standard Hours] is null or 
		   [Stock Option Level] is null or [Total Working Years] is null or [Work Life Balance] is null or
		   [Years At Company] is null or [Years In Current Role] is null or [Years Since Last Promotion] is null
		   or [Years With Curr Manager] is null)

	-- No null values are present


-- Check duplicates based on employee number

select [Employee Number], COUNT(*)
from HR_Data
group by [Employee Number]
having COUNT(*) > 1 

	-- No duplicates are there



------------------------------------ Step4 : Feature Engineering ------------------------------------

-- Add new column as age_group

alter table hr_data
add age_group varchar(30)

update HR_Data
set age_group = (
	case
		when Age <= 29 then '18-29'
		when Age between 30 and 39 then '30-39'
		when Age between 40 and 49 then '40-49'
		when Age between 50 and 59 then '50-59'
		else '60 or older'
	end)

alter table hr_data
drop column age_group


-- Add new column monthly_income_group

alter table hr_data
add monthly_income_group varchar(30)

update HR_Data
set monthly_income_group = (
case
	when [Monthly Income] < 5000 then '1k-4k'
	when [Monthly Income] between 5000 and 9999 then '5k-9k'
	when [Monthly Income] between 10000 and 14999 then '10k-14k'
	when [Monthly Income] between 15000 and 19999 then '15k-19k'
	else '20k or more than 20k'
end )
from HR_Data


-- Add new column perc_sal_hike_range
alter table hr_data
add perc_sal_hike_range varchar(30)

update HR_Data
set perc_sal_hike_range = (
case
	when [Percent Salary Hike] <= 10 then 'less than 10%'
	when [Percent Salary Hike] between 11 and 15 then '11-15%'
	when [Percent Salary Hike] between 16 and 20 then '16-20%'
	when [Percent Salary Hike] between 21 and 25 then '21-25%'
	else 'more than 25%'
end )
from HR_Data


------------------------------------ Step5 : EDA ------------------------------------

-- 1. Overall attrition count and total employees count

select COUNT(*) Employee_count,
count(case 
		when Attrition = 'Yes' then 1
	  end) Attrition_count
from HR_Data
	
	-- Here we have total employee count - 1470 out of which 237 left the company (attrition count)


-- 2. Relation between business travel and attrition count

select [Business Travel], COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Business Travel]
order by attrition_count desc

	-- There is no relation between business travel and attrition count 
		-- as most employees who travelled rarely left the company as compared to those who frequently travelled


-- 3. Department wise attrition count

select Department, COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by Department

	-- Attrition count for R&D is higher followed by sales department.


-- 4. Education field and education wise attrition count

select [Education Field], Education , COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Education Field], Education
order by [Education Field], attrition_count desc

	-- Most of the employees belongs to Life Sciences education field and Bachelor's Degree education left the company


-- 5. Overall employee count and attrition count based on gender

select gender, COUNT(*) total_employee_count,
COUNT(case
		when attrition = 'yes' then 1
	  end) attrition_count
from HR_Data
group by Gender

	-- Here we have total employee count - 1470 out of which 882 are male and 588 are female
	-- Out of 237 attrition count, 87 female left the company and 150 male left the company


-- 6. Relation between job role and attrition count

select [Job Role], COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Job Role]
order by attrition_count desc
	
	-- Most of the employees from Laboratory Technician left the company. 
	-- Very less number of employees from Research Director left the company.


-- 7. Relation between marital status, gender and attrition count

select [Marital Status], gender, COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Marital Status], Gender
order by attrition_count desc

	-- Most of the employees those are single left the company


-- 8. Presence of overtime and attrition relation

select [Over Time], COUNT(attrition) Attrition_count
from HR_Data
where Attrition = 'yes'
group by [Over Time]

	-- Here out of 237 people, 127 people are over timed and left the company and 
		-- 110 are not over timed still they left the company
	-- So, over time is not playing an important role in terms of attrition


-- 9. Attrition count based on age_group

select age_group, COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes' 
group by age_group

	-- Age group of 18-29 and 30-39 have the maximum attrition counts for those employees who have been working in the company from last 1 year.


-- 10. Relation between distance from home and attrition

select [Distance From Home], COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Distance From Home]
order by attrition_count desc

	-- There is no relation between distance from home and attrition 


-- 11. Environment satisfaction on attrition count

select [Environment Satisfaction], COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Environment Satisfaction]
order by attrition_count desc

	-- There is no relation between Environment satisfaction and attrition



-- 12. job satisfaction on attrition count

select [Job Satisfaction] ,COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Job Satisfaction]
order by attrition_count desc

	-- There is no relation between Job satisfaction and attrition


-- 13. Relation between monthly income group and attrition count

select monthly_income_group, COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by monthly_income_group
order by attrition_count desc

	-- Most of the employees having monthly income between 1k-4k left the company


-- 14. Relation between percentage salary hike group and attrition

select perc_sal_hike_range, COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by perc_sal_hike_range
order by perc_sal_hike_range, attrition_count desc

	-- There is a relation between percentage salary hike and attrition
	-- As less the salary hike higher the attrition count


-- 15. Relation between performance rating and attrition

select [Performance Rating], COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Performance Rating]

	-- There is a relation between performance rating and attrition
	-- As the rating is lower then attrition count will be higher


-- 16. relationship satisfaction on attrition count

select [Relationship Satisfaction], COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Relationship Satisfaction]
order by attrition_count desc

	-- There is no relation between relationship satisfaction and attrition


-- 17. Relation between work life balance and attrition

select [Work Life Balance], COUNT(*) attrition_count
from HR_Data
where Attrition = 'yes'
group by [Work Life Balance]

	-- There is no relation between work life balance and attrition


-- 18. Relation between years in current role and attrition count

select [Years In Current Role], 
COUNT(case
		when Attrition = 'yes' then 1
	  end) attrition_count
from HR_Data
group by [Years In Current Role]
order by [Years In Current Role], attrition_count desc

	-- Employees who are having the same role from last 0-10 years are having the highest attrition count.


-- 19. Relation between year since last promotion and attrition count

select [Years Since Last Promotion], COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Years Since Last Promotion]
order by attrition_count desc

	-- If they didn't get promotion the chances of leaving the company is high


-- 20. Relation between years with current manager and attrition count

select [Years With Curr Manager], COUNT(*) attrition_count
from HR_Data
where attrition = 'yes'
group by [Years With Curr Manager]
order by [Years With Curr Manager], attrition_count desc

	-- It depends upon the employee if they found toxic relation with their manager 
		-- then they might request for change of manager or left the company