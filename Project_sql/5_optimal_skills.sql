/* Optimal demand means high demand and high salary
the code below will produce the results the optimal skills to learn */

WITH top_demand_skills AS (
    SELECT 
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.job_id) AS demand_skills
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
            job_title_short = 'Data Analyst' AND 
            salary_year_avg IS NOT NULL AND
            job_work_from_home = TRUE
    GROUP BY 
            skills_dim.skill_id  
), average_salary AS (
    SELECT 
            skills_dim.skill_id,
            skills_dim.skills,
            ROUND(AVG(salary_year_avg),0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
            job_title_short = 'Data Analyst' AND 
            salary_year_avg IS NOT NULL
            AND job_work_from_home = TRUE
    GROUP BY 
            skills_dim.skill_id  
 )

 SELECT 
        top_demand_skills.skill_id,
        top_demand_skills.skills,
        demand_skills,
        avg_salary
FROM 
    top_demand_skills
INNER JOIN average_salary ON top_demand_skills.skill_id = average_salary.skill_id
ORDER BY
        demand_skills DESC,
        avg_salary DESC
LIMIT 25