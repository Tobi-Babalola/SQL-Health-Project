-- gender distribution
SELECT sex, count(*) as num
FROM insurance
group by sex;

-- age
SELECT 
    COUNT(*) AS total_num,
    Round(AVG(Age), 2) AS avg_age,
    MIN(Age) AS youngest,
    MAX(Age) AS oldest
FROM insurance;

-- bmi
SELECT 
    Round(AVG(bmi), 2) AS avg_bmi,
    MIN(bmi) AS youngest,
    MAX(bmi) AS oldest
FROM insurance;

-- create new columns for age groups and bmi groups
ALTER TABLE insurance
ADD COLUMN age_group VARCHAR(30),
ADD COLUMN bmi_group VARCHAR(30);

-- input the data
/* 
Youth (18-29), Young Adults (30-39), Middle Age (40-49), Seniors (50-64)
Underweight (<18.5), Normal (18.5-24.9), Overweight (25-29.9), Obese (30+)
*/ 

UPDATE insurance
SET age_group = CASE 
    WHEN age BETWEEN 18 AND 29 THEN 'Youth'
    WHEN age BETWEEN 30 AND 39 THEN 'Young Adults'
    WHEN age BETWEEN 40 AND 49 THEN 'Middle Age'
    WHEN age BETWEEN 50 AND 64 THEN 'Seniors'
END;

UPDATE insurance
SET bmi_group = CASE 
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi >= 18.5 AND bmi < 25 THEN 'Normal'
    WHEN bmi >= 25 AND bmi < 30 THEN 'Overweight'
    WHEN bmi >= 30 THEN 'Obese'
END;

-- crosschecking
SELECT *
FROM insurance
LIMiT 25;

-- age group distribution
SELECT age_group, count(*) as num
FROM insurance
group by age_group;

-- bmi group distribution
SELECT bmi_group, count(*) as num
FROM insurance
group by bmi_group;

-- smokers distribution
SELECT smoker, count(*) as num
FROM insurance
group by smoker;

-- charges
SELECT 
    Round(AVG(charges), 2) AS avg_charge,
    MIN(charges) AS lowest,
    MAX(charges) AS highest
FROM insurance;

-- regional distribution
SELECT region, count(*) as num
FROM insurance
group by region;

-- children
SELECT 
    AVG(children) AS avg_children_per_family
FROM insurance;

-- average charge by sex
SELECT 
    sex, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY sex;

-- average charge by num of children
SELECT 
    children, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY children
ORDER BY children;

-- average charge by Smokers
SELECT 
    smoker, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY smoker;

-- average charge by age group
SELECT 
    age_group, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY age_group;

-- average charge by bmi group
SELECT 
    bmi_group, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY bmi_group;

-- average charge by region
SELECT 
    region, 
    ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY region;

-- age + smoking
SELECT age_group, smoker, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY age_group, smoker
ORDER BY age_group, smoker;

-- bmi + smoking
SELECT bmi_group, smoker, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY bmi_group, smoker
ORDER BY bmi_group, smoker;

-- children + smoking
SELECT children, smoker, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY children, smoker
ORDER BY children, smoker;

-- Top 10 charges
SELECT sex, children, smoker, region, charges, age_group, bmi_group
FROM insurance
ORDER BY charges DESC
LIMIT 10;

-- charges category
SELECT 
    CASE 
        WHEN charges < 5000 THEN 'Low (<5k)'
        WHEN charges BETWEEN 5000 AND 20000 THEN 'Medium (5k-20k)'
        ELSE 'High (>20k)'
    END AS charge_group,
    COUNT(*) AS count,
    smoker
FROM insurance
GROUP BY charge_group, smoker
ORDER BY charge_group;

-- region & smoking
SELECT region, smoker, COUNT(*) AS count, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY region, smoker
Order by region
;

-- region & bmi group
SELECT region, bmi_group, COUNT(*) AS count, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY region, bmi_group
Order by region
;

-- region & age group
SELECT region, age_group, COUNT(*) AS count, ROUND(AVG(charges), 2) AS avg_charge
FROM insurance
GROUP BY region, age_group
Order by region
;
