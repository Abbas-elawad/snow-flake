{{ config(
    materialized='view'
) }}

select 
	DATE,
	DAY,
	MONTH,
	YEAR,
	QUARTER,
	DAYOFWEEK,
	WEEKOFYEAR,
	UPDATED_AT 
from {{ source('landing', 'DATES') }}