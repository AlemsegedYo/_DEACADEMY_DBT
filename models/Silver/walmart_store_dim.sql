{{ config(
materialized='incremental',
database='SCD1_DB',
schema='PUBLIC'
) }}
WITH source AS (
SELECT DISTINCT
Store AS Store_id,
Dept AS Dept_id,
Type AS Store_type,
Size AS Store_size,
CURRENT_TIMESTAMP() AS Insert_date,
CURRENT_TIMESTAMP() AS Update_date
FROM SCD1_DB.PUBLIC.stores_raw
JOIN SCD1_DB.PUBLIC.department_raw USING (Store)
)
SELECT * FROM source