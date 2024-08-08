WITH base AS (
    SELECT 
        ones.value AS ones,
        tens.value AS tens,
        hundreds.value AS hundreds,
        thousands.value AS thousands
    FROM (
        SELECT 0 AS value
        UNION ALL SELECT 1
        UNION ALL SELECT 2
        UNION ALL SELECT 3
        UNION ALL SELECT 4
        UNION ALL SELECT 5
        UNION ALL SELECT 6
        UNION ALL SELECT 7
        UNION ALL SELECT 8
        UNION ALL SELECT 9
    ) AS ones
    CROSS JOIN (
        SELECT 0 AS value
        UNION ALL SELECT 10
        UNION ALL SELECT 20
        UNION ALL SELECT 30
        UNION ALL SELECT 40
        UNION ALL SELECT 50
        UNION ALL SELECT 60
        UNION ALL SELECT 70
        UNION ALL SELECT 80
        UNION ALL SELECT 90
    ) AS tens
    CROSS JOIN (
        SELECT 0 AS value
        UNION ALL SELECT 100
        UNION ALL SELECT 200
        UNION ALL SELECT 300
        UNION ALL SELECT 400
        UNION ALL SELECT 500
        UNION ALL SELECT 600
        UNION ALL SELECT 700
        UNION ALL SELECT 800
        UNION ALL SELECT 900
    ) AS hundreds
    CROSS JOIN (
        SELECT 0 AS value
        UNION ALL SELECT 1000
        UNION ALL SELECT 2000
        UNION ALL SELECT 3000
        UNION ALL SELECT 4000
    ) AS thousands
),

date_range AS (
    SELECT
        DATE_ADD(DATE '2010-01-01', INTERVAL (ones + tens + hundreds + thousands) DAY) AS date
    FROM base
)

SELECT
    date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(QUARTER FROM date) AS quarter,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    FORMAT_DATE('%B', date) AS month_name,
    FORMAT_DATE('%A', date) AS day_name
FROM
    date_range
WHERE 
    date BETWEEN '2010-01-01' AND '2024-12-31'
ORDER BY
    date

