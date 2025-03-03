-- Based on the analysis it is evident that SQL is the most in-demand skill --
--required in most data analyst roles that allows work from home --





SELECT 
        skills,
        COUNT(skills_job_dim.job_id) AS demand_skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst' AND 
        job_work_from_home = TRUE
GROUP BY 
        skills  
ORDER BY 
        demand_skills DESC
LIMIT 10