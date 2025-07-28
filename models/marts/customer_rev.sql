{{ config(materialized='table') }}

select 
o.customer_id,
c.full_name,
sum(o.order_count) as total_order_count,
sum(o.Revenue) as total_revenue
from {{ ref('fact_orders') }} o
left join {{ ref('customer_stg') }} c
on o.customer_id = c.customer_id
group by 
o.customer_id,
c.full_name