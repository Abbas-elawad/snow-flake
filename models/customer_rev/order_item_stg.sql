{{ config(
    materialized='view'
) }}
 select 
	ORDERID as order_id,
	ORDERITEMID as order_item,
	PRODUCTID as product_id,
	QUANTITY as quantity,
	UNITPRICE as unit_price,
    QUANTITY * UNITPRICE as total_price,
	UPDATED_AT as updated_at
from {{ source('landing', 'ORDERITEMS') }}
