-- duplicate table
CREATE TABLE insurance_copy LIKE insurance;
INSERT INTO insurance_copy SELECT * FROM insurance;

-- check to see if both match
SELECT COUNT(*) FROM insurance;
SELECT COUNT(*) FROM insurance_copy;

-- check columns info
SHOW COLUMNS FROM insurance;

-- add an id column
ALTER TABLE insurance
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

SELECT * FROM insurance LIMIT 20;

-- allow modifications
SET SQL_SAFE_UPDATES = 0;

-- check for duplicates
WITH duplic AS (
    SELECT 
        id, age, sex, bmi, children, smoker, region, charges,
        ROW_NUMBER() OVER (
            PARTITION BY age, sex, bmi, children, smoker, region, charges
            ORDER BY id
        ) AS row_num
    FROM insurance
)
SELECT * 
FROM duplic
WHERE row_num > 1;

-- delete duplicates
WITH duplic AS (
    SELECT 
        id,
        ROW_NUMBER() OVER (
            PARTITION BY age, sex, bmi, children, smoker, region, charges
            ORDER BY id
        ) AS row_num
    FROM insurance
)
DELETE FROM insurance
WHERE id IN (
    SELECT id FROM duplic WHERE row_num > 1
);

-- check for nulls and blanks
SELECT *
FROM insurance
WHERE age IS NULL
   OR sex IS NULL OR sex = ''
   OR bmi IS NULL
   OR children IS NULL
   OR smoker IS NULL OR smoker = ''
   OR region IS NULL OR region = ''
   OR charges IS NULL;

-- crosscheck rows
SELECT DISTINCT region
FROM insurance
ORDER BY 1;
SELECT DISTINCT sex
FROM insurance
ORDER BY 1;
SELECT DISTINCT smoker
FROM insurance
ORDER BY 1;