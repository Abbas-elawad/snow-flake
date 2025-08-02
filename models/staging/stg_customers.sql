{{ config(
    materialized='table'
) }}

select 
    id as customer_id,
    first_name || ' ' || last_name as full_name,
    first_name as givenname,
    last_name as surname
 from {{ source('landing', 'CUSTOMERS') }}


