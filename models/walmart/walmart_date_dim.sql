
{{ config(
materialized='incremental',
database='SCD1_DB',
schema='PUBLIC'
) }}
WITH source AS (
SELECT DISTINCT
ROW_NUMBER() OVER (ORDER BY Date) AS Date_Id,
Date as Store_date,
IsHoliday,
CURRENT_TIMESTAMP() AS Insert_date,
CURRENT_TIMESTAMP() AS Update_date
FROM SCD1_DB.PUBLIC.department_raw
)
SELECT * FROM source