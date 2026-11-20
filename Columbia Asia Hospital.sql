USE hospital_analysis;
SELECT COUNT(*) FROM hospital_er;

SELECT
    COUNT(*) AS Total_Records,
    COUNT(patient_sat_score) AS Recorded_Scores,
    SUM(patient_sat_score IS NULL) AS Missing_Scores
FROM hospital_er;
-- as wizard only imported rows with available patient_sat_score, that's why i droped the table and imported it again by setting the datatype as VARCHAR.
DROP TABLE hospital_er;

UPDATE hospital_er
SET patient_sat_score = NULL
WHERE TRIM(patient_sat_score) = '';

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE hospital_er
MODIFY patient_sat_score INT NULL;

DESCRIBE hospital_er;

SELECT date
FROM hospital_er
LIMIT 10;

UPDATE hospital_er
SET date = STR_TO_DATE(date, '%d-%m-%Y %H:%i');

ALTER TABLE hospital_er
MODIFY date DATETIME;

ALTER TABLE doctor_patients_data
RENAME COLUMN `ï»¿patient_id` TO patient_id;

DESCRIBE doctor_patients_data;

-- 15
SELECT `Doctor Name`, COUNT(patient_id) AS patient_count, SUM(`Total Bill`) AS total_revenue
FROM doctor_patients_data
GROUP BY `Doctor Name`
ORDER BY patient_count ASC, total_revenue DESC
LIMIT 5;

SELECT * FROM doctor_patients_data;

-- 16
WITH monthly_avg_wait AS (
    SELECT
        department_referral,
        DATE_FORMAT(date, '%Y-%m') AS month,
        AVG(patient_waittime) AS avg_wait_time
    FROM hospital_er
    GROUP BY department_referral, DATE_FORMAT(date, '%Y-%m')
),
wait_comparison AS (
    SELECT
        department_referral,
        month,
        avg_wait_time,
        LAG(month, 1) OVER (PARTITION BY department_referral ORDER BY month) AS previous_month,
        LAG(month, 2) OVER (PARTITION BY department_referral ORDER BY month) AS two_months_ago,
        LAG(avg_wait_time, 1) OVER (PARTITION BY department_referral ORDER BY month) AS previous_month_wait,
        LAG(avg_wait_time, 2) OVER (PARTITION BY department_referral ORDER BY month) AS two_months_ago_wait
    FROM monthly_avg_wait)
SELECT
    department_referral,
    two_months_ago,
    ROUND(two_months_ago_wait, 2) AS first_month_avg,
    previous_month,
    ROUND(previous_month_wait, 2) AS second_month_avg,
    month AS third_month,
    ROUND(avg_wait_time, 2) AS third_month_avg
FROM wait_comparison
WHERE
    PERIOD_DIFF(REPLACE(month, '-', ''),REPLACE(previous_month, '-', '')) = 1
    AND PERIOD_DIFF(REPLACE(previous_month, '-', ''),REPLACE(two_months_ago, '-', '')) = 1
    AND avg_wait_time < previous_month_wait
    AND previous_month_wait < two_months_ago_wait
ORDER BY department_referral, two_months_ago;
    
-- 17
WITH doctor_gender_count AS (
    SELECT d.`Doctor ID`, d.`Doctor Name`,
        SUM(CASE WHEN h.patient_gender = 'M' THEN 1 ELSE 0 END) AS male_patients,
		SUM(CASE WHEN h.patient_gender = 'F' THEN 1 ELSE 0 END) AS female_patients
    FROM doctor_patients_data d
    JOIN hospital_er h
	ON d.patient_id = h.patient_id
    GROUP BY d.`Doctor ID`, d.`Doctor Name`
),
doctor_ratio AS (
    SELECT `Doctor ID`, `Doctor Name`, male_patients, female_patients,
        ROUND(male_patients / NULLIF(female_patients, 0),2) AS male_female_ratio
    FROM doctor_gender_count
)
SELECT `Doctor ID`, `Doctor Name`, male_patients, female_patients, male_female_ratio,
    DENSE_RANK() OVER (ORDER BY male_female_ratio DESC) AS doctor_rank

FROM doctor_ratio
ORDER BY doctor_rank;

-- 19
SELECT
    d.`Doctor ID`,
    d.`Doctor Name`,
    COUNT(DISTINCT h.patient_race) AS race_diversity,
    COUNT(DISTINCT d.patient_id) AS total_patients
FROM doctor_patients_data d
JOIN hospital_er h
ON d.patient_id = h.patient_id
WHERE h.patient_race IS NOT NULL AND TRIM(h.patient_race) <> ''
GROUP BY d.`Doctor ID`, d.`Doctor Name`
HAVING COUNT(DISTINCT h.patient_race) > 1
ORDER BY race_diversity DESC, total_patients DESC;

-- 20
SELECT
    d.department_referral,
    SUM(CASE WHEN h.patient_gender = 'M' THEN d.`Total Bill` ELSE 0 END) AS male_total_bill,
    SUM(CASE WHEN h.patient_gender = 'F' THEN d.`Total Bill` ELSE 0 END) AS female_total_bill,
    CASE
        WHEN SUM(CASE WHEN h.patient_gender = 'F' THEN d.`Total Bill` ELSE 0 END) = 0 THEN NULL
        ELSE ROUND(
            SUM(CASE WHEN h.patient_gender = 'M' THEN d.`Total Bill` ELSE 0 END) /
            SUM(CASE WHEN h.patient_gender = 'F' THEN d.`Total Bill` ELSE 0 END), 
            2) END AS male_female_bill_ratio
FROM doctor_patients_data d
JOIN hospital_er h
ON d.patient_id = h.patient_id
GROUP BY d.department_referral;

-- 21
-- Step 1. Create a backup column
ALTER TABLE hospital_er
ADD COLUMN original_patient_sat_score INT;

-- Step 2. Preserve the original scores
UPDATE hospital_er
SET original_patient_sat_score = patient_sat_score;

SET SQL_SAFE_UPDATES = 0;

SET SQL_SAFE_UPDATES = 1;

-- Step 3. Update the satisfaction scores
UPDATE hospital_er
SET patient_sat_score = LEAST(original_patient_sat_score + 2, 10)
WHERE department_referral = 'General Practice'
AND patient_waittime > 30
AND original_patient_sat_score IS NOT NULL;

-- 4. Verify the changes:
SELECT
    patient_id,
    department_referral,
    patient_waittime,
    original_patient_sat_score AS old_score,
    patient_sat_score AS new_score
FROM hospital_er
WHERE department_referral = "General Practice" 
AND original_patient_sat_score IS NOT NULL
AND patient_sat_score IS NOT NULL;








