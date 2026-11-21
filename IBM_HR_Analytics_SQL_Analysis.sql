CREATE DATABASE ibm_hr_analytics;
USE ibm_hr_analytics;

-- Check Duplicate Employee IDs
SELECT
    COUNT(EmployeeNumber) AS total_ids,
    COUNT(DISTINCT EmployeeNumber) AS unique_ids
FROM HR;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Overall HR Analysis
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1	How many employees are currently recorded in the dataset?
-- Answer 
		  select * from  total_employees ;

create view  total_employees as 
select    
        count(*) as total_employees
from hr ;

-- Q2	How many employees have left the company, and how many are still working?
-- Answer 
          select * from employees_left_and_still_working ;
          
create view employees_left_and_still_working as 
select
    Attrition,
    COUNT(*) AS employee_count
FROM HR
GROUP BY Attrition;

-- Q3. What is the overall employee attrition rate?
-- Answer
          select * from overall_employees_attrition_rate ;

create view overall_employees_attrition_rate as 
SELECT
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR;


-- Q4. What is the gender distribution of employees?
-- Answer 
          select * from gender_distribution_employees ;

create view gender_distribution_employees as
SELECT
    Gender,
    COUNT(*) AS employee_count
FROM HR
GROUP BY Gender;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Department & Job Role Analysis
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q5.Which department has the highest employee attrition?
-- Answer 
         select * from department_Attrition ;

create view department_Attrition as 
SELECT
    Department,
    COUNT(*) AS attrition_count
FROM HR
WHERE Attrition = 'Yes'
GROUP BY Department
ORDER BY attrition_count DESC ;

-- Q6. Which job role has the highest employee attrition?
-- Answer 
         select * from job_role_highest_attrition ;
         
create view job_role_highest_attrition as 
select
      jobrole,
      count(*) as attrition_count
from HR
where Attrition = 'yes'
group by jobrole
order by attrition_count desc ;

-- Q7. How many employees have left the company in each department?
-- Answer 
          select * from employee_left_each_department ;
          
create view employee_left_each_department as 
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS employees_stayed
FROM HR
GROUP BY Department;

-- Q8. What is the average monthly income across different departments?
-- Answer 
          select * from Avg_monthly_income_across_departments ;

create view Avg_monthly_income_across_departments as
SELECT
    Department,
    AVG(MonthlyIncome) AS avg_monthly_income
FROM HR
GROUP BY Department
ORDER BY avg_monthly_income DESC;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Employee Behaviour Analysis
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q9. Do employees who work overtime have a higher attrition rate?
-- Answer 
         select * from overtime_attrition_rate ;
         
create view overtime_attrition_rate as
SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR
GROUP BY OverTime ;


-- Q10. Is job satisfaction associated with employee attrition?
-- Answer 
          select * from job_satisfaction_attrition ;
          
create view job_satisfaction_attrition as 
SELECT
    JobSatisfaction,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction ;

-- Q11. Which age groups have the highest attrition rate?
-- Answer 
          select * from age_wise_attrition ;
          
create view age_wise_attrition as
SELECT
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR
GROUP BY age_group
ORDER BY attrition_rate DESC;

-- Q12. Are employees with fewer years at the company more likely to leave?
-- Answer
		select * from year_at_company ;

        
create view year_at_company as 
SELECT
    YearsAtCompany,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attrition_rate
FROM HR
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany ;

