{{ config(
    materialized='view'
) }}
select 
	CUSTOMERID as customer_id,
    FIRSTNAME as first_name,
    LASTNAME as last_name,
    concat(FIRSTNAME, ' ', LASTNAME) as full_name,
	EMAIL as email,
	PHONE as phone,
	ADDRESS as address,
	CITY as city,
	STATE as state,
	ZIPCODE as zipcode,
	UPDATED_AT as updated_at
from {{ source('landing', 'CUSTOMERS') }}
