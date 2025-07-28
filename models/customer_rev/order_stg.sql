{{ config(
    materialized='view'
) }}
select 
	ORDERID as order_id,
	ORDERDATE as order_date,
	CUSTOMERID as customer_id,
	EMPLOYEEID as employee_id,
	STOREID as store_id,
	STATUS as status,
    case    
        when STATUS = '01' then 'Complete'
        when STATUS = '02' then 'In Progress'
        when STATUS = '03' then 'Cancelled'
        else null
    end as order_status,
	UPDATED_AT as updated_at
from {{ source('landing', 'ORDERS') }}