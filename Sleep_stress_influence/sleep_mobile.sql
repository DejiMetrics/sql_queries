SELECT *
FROM sleep_mobile_stress_dataset_15000;

......Checking for duplicate in the dataset;

SELECT user_id, count(user_id) as occurrence
FROM sleep_mobile_stress_dataset_15000
GROUP BY user_id
HAVING COUNT(user_id) > 1;

.....Analyzing average metrics by occupation: determination of 
stress level against professions;

SELECT occupation, Round(avg(sleep_duration_hours), 2) AS avg_sleep, 
Round(avg(stress_level), 2) AS avg_stress
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY avg_stress desc;

......determining the impact of sleep quality on stress-level;

SELECT occupation, Round(avg(sleep_quality_score), 2) AS avg_qualitysleep,
Round(avg(stress_level), 2) AS avg_stress
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY avg_stress desc;


......determining the impact of sleep duration on stress_quality;

SELECT occupation, Round(avg(sleep_quality_score), 2) AS avg_sleepquality,
Round(avg(sleep_duration_hours), 2) AS avg_sleepduration
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY avg_sleepduration desc;

.....analyzing gender against daily screen time;

SELECT gender, Round(avg(daily_screen_time_hours), 2) AS daily_screen
FROM sleep_mobile_stress_dataset_15000
GROUP BY gender
ORDER BY daily_screen asc;


SELECT gender, Round(avg(daily_screen_time_hours), 2) AS daily_screen,
Round(avg(physical_activity_minutes), 2) AS physical_engagement,
Round(avg(stress_level), 2) AS avg_stress
FROM sleep_mobile_stress_dataset_15000
GROUP BY gender
ORDER BY daily_screen asc;

.....The effect of caffeine on stress_level against occupation;

SELECT Occupation, Count(caffeine_intake_cups) AS total_caffeine_cups,
Round(avg(stress_level), 2) AS avg_stress
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY avg_stress desc;

....The effect of caffeine intake against sleep_duration;

SELECT Occupation, Count(caffeine_intake_cups) AS total_caffeine_cups,
Round(avg(sleep_duration_hours), 2) AS avg_sleep,
Round(avg(sleep_quality_score), 2) AS avg_sleep_quality
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY total_caffeine_cups desc;

SELECT *
FROM sleep_mobile_stress_dataset_15000;

....Checking the relationship between stress_level and caffeine_intake;

SELECT stress_level, avg(caffeine_intake_cups)
FROM sleep_mobile_stress_dataset_15000
GROUP BY stress_level
ORDER BY stress_level desc;

...Determining the influence of age on sleep_duration intake age;

SELECT MAX(age), MIN(age)
FROM sleep_mobile_stress_dataset_15000; 


SELECT age, sleep_duration_hours,
CASE
    WHEN age > 30 THEN 'adult'
    WHEN age <= 30 THEN 'Young'
END AS age_bracket
FROM sleep_mobile_stress_dataset_15000
ORDER BY sleep_duration_hours desc;


SELECT user_id, age, stress_level
FROM sleep_mobile_stress_dataset_15000
ORDER BY stress_level desc;


....Screen time classification;

SELECT gender, Round(avg(daily_screen_time_hours), 2) AS avg_screen, 
Round(avg(mental_fatigue_score), 2) AS mental
FROM sleep_mobile_stress_dataset_15000
GROUP BY gender;

SELECT gender, Round(avg(daily_screen_time_hours), 2) AS avg_screen, Round(avg(mental_fatigue_score), 2) AS mental,
CASE
    WHEN Round(avg(daily_screen_time_hours), 2) >= 5.55 THEN 'high'
    WHEN Round(avg(daily_screen_time_hours), 2) >= 5.50 THEN 'medium'
    WHEN Round(avg(daily_screen_time_hours), 2) < 5.50 THEN 'low'
END AS Risk
FROM sleep_mobile_stress_dataset_15000
GROUP BY gender
ORDER BY Round(avg(daily_screen_time_hours), 2) desc;

...Determining the impact of stress, mental fatigue against occupation;

SELECT occupation, Round(avg(sleep_quality_score), 2) AS avg_sleep_quality, 
Round(avg(stress_level), 2) AS avg_stress, 
Round(avg(mental_fatigue_score), 2) AS avg_mental_fatigue
FROM sleep_mobile_stress_dataset_15000
GROUP BY occupation
ORDER BY avg_mental_fatigue desc;

...Determining the impact of stress, mental fatigue against gender;

SELECT gender, Round(avg(sleep_quality_score), 2) AS avg_sleep_quality, 
Round(avg(stress_level), 2) AS avg_stress, 
Round(avg(mental_fatigue_score), 2) AS avg_mental_fatigue
FROM sleep_mobile_stress_dataset_15000
GROUP BY gender
ORDER BY avg_mental_fatigue desc;
