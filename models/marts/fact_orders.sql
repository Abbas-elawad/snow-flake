{{ config(
    materialized='table'
) }} 
 
 select 
    oi.order_id,
    oi.order_date,
    oi.customer_id,
    oi.employee_id,
    oi.store_id,
    oi.status,
    oi.order_status,
    count(distinct oi.order_id) as order_count,
    sum(d.total_price) as Revenue,
    oi.updated_at
 from {{ref('order_stg') }} oi
 left join {{ ref('order_item_stg') }} d 
 on oi.order_id = d.order_id
 group by 
    oi.order_id,
    oi.order_date,
    oi.customer_id,
    oi.employee_id,
    oi.store_id,
    oi.status,
    oi.order_status,
    oi.updated_at
