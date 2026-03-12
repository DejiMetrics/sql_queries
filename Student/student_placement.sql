SELECT *
FROM student_placement_synthetic;

CREATE TABLE student_2
LIKE student_placement_synthetic;

INSERT student_2
SELECT *
FROM student_placement_synthetic;

SELECT *
FROM student_2;

SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch, college_tier, cgpa, backlogs,
coding_skills, dsa_score, aptitude_score, communication_skills, 
ml_knowledge, system_design, internships, projects_count, certifications, 
hackathons, open_source_contributions, extracurriculars, 
placement_status, salary_package_lpa) AS row_num_1
FROM student_2;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY branch, college_tier, cgpa, backlogs,
coding_skills, dsa_score, aptitude_score, communication_skills, 
ml_knowledge, system_design, internships, projects_count, certifications, 
hackathons, open_source_contributions, extracurriculars, 
placement_status, salary_package_lpa) AS row_num_1
FROM student_2
)
SELECT *
FROM duplicate_cte
WHERE row_num_1 > 1;


SELECT branch, salary_package_lpa
FROM student_2
WHERE salary_package_lpa = '';

UPDATE student_2
SET salary_package_lpa = null
WHERE salary_package_lpa = '';

SELECT cgpa
FROM student_2
WHERE cgpa like '6%';

SELECT branch, college_tier, ROUND(avg(cgpa), 2) AS avg_cgpa,
ROUND(avg(salary_package_lpa), 2) AS avg_sal
FROM student_2
GROUP BY branch, college_tier
ORDER BY avg_cgpa desc;

SELECT college_tier, ROUND(avg(cgpa), 2) AS avg_cgpa,
CASE
	WHEN avg(cgpa) >= 7.6 THEN 'Excellent'
    WHEN avg(cgpa) >= 7.0 THEN 'Good'
    WHEN avg(cgpa) <= 7.0 THEN 'average'
END AS Remark
FROM Student_2
GROUP BY college_tier;


SELECT branch, college_tier, ROUND(avg(backlogs), 2) AS back
FROM student_2
GROUP BY branch, college_tier
ORDER BY  back asc;

SELECT branch, ROUND(avg(cgpa), 2) AS avg_cgpa, ROUND(avg(coding_skills), 2) AS avg_coding,
ROUND(avg(communication_skills), 2) AS avg_communication, ROUND(avg(ml_knowledge), 2) AS avg_ml
FROM student_2
GROUP BY branch
ORDER BY avg_cgpa desc;

SELECT college_tier, COUNT(backlogs), round(avg(cgpa), 2)
FROM student_2
GROUP BY college_tier
ORDER BY round(avg(cgpa), 2) desc;

SELECT college_tier,round(avg(cgpa), 2), COUNT(internships), ROUND(avg(salary_package_lpa), 2)
FROM student_2
GROUP BY college_tier
ORDER BY round(avg(cgpa), 2) desc;

SELECT college_tier, ROUND(avg(cgpa), 2) AS avg_cgpa,
ROUND(avg(coding_skills), 2) AS avg_coding,
ROUND(avg(communication_skills), 2) AS avg_communication, 
ROUND(avg(ml_knowledge), 2) AS avg_ml,
COUNT(internships)
FROM student_2
GROUP BY college_tier
ORDER BY avg_cgpa desc;

SELECT branch, ROUND(avg(cgpa), 2) AS avg_cgpa,
ROUND(avg(coding_skills), 2) AS avg_coding,
ROUND(avg(communication_skills), 2) AS avg_communication, 
ROUND(avg(ml_knowledge), 2) AS avg_ml,
COUNT(internships)
FROM student_2
GROUP BY branch
ORDER BY avg_cgpa desc;

SELECT branch, ROUND(avg(aptitude_score), 2) AS ap_score, count(placement_status) AS placement
FROM student_2
GROUP BY branch
ORDER BY 2 desc;

SELECT college_tier, ROUND(avg(cgpa), 2) AS avg_cgpa, count(extracurriculars) AS total_extracurriculars
FROM student_2
GROUP BY college_tier
ORDER BY  total_extracurriculars desc;

SELECT college_tier, count(placement_status) AS total_placement, count(extracurriculars) AS total_extracurriculars
FROM student_2
GROUP BY college_tier
ORDER BY  total_extracurriculars desc;


SELECT college_tier, count(certifications) AS total_cert, 
count(placement_status) AS total_placement
FROM student_2
GROUP BY college_tier
ORDER BY  total_cert desc;

