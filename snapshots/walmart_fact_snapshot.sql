{% snapshot walmart_fact_snapshot %}
{{ config(
    target_database='SCD1_DB',
    target_schema='PUBLIC',
    unique_key='natural_key',         
    strategy='check',
    check_cols=['STORE_SIZE','STORE_WEEKLY_SALES','FUEL_PRICE','TEMPERATURE','uneomployment','CPI',
                'MARKDOWN1','MARKDOWN2','MARKDOWN3','MARKDOWN4','MARKDOWN5']
) }}

SELECT
  -- stable business key: store|YYYY-MM-DD|dept
  TO_VARCHAR(fact.Store) || '|' ||
  fact."DATE" || '|' ||
  TO_VARCHAR(dept.Dept)  AS natural_key,

  fact.Store          AS store_id,
  dept.Dept           AS dept_id,
  fact."DATE"         AS date_day,
  store.Size          AS store_size,
  dept.Weekly_Sales   AS store_weekly_sales,
  fact.Fuel_Price,
  fact.Temperature,
  fact.uneomployment,
  fact.CPI,
  fact.MarkDown1,
  fact.MarkDown2,
  fact.MarkDown3,
  fact.MarkDown4,
  fact.MarkDown5
FROM {{ source('scd1_db','fact_raw') }}  fact
JOIN {{ source('scd1_db','store_raw') }} store
  ON store.Store = fact.Store
JOIN {{ source('scd1_db','department_raw') }} dept
  ON dept.Store = fact.Store
 AND dept."DATE" = fact."DATE"

{% endsnapshot %}
