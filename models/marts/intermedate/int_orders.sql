with
orders as 
    (select * from {{ ref('stg_orders') }}
    ),

payments as
     (select * from {{ ref('stg_payments') }}
     where payment_status != 'fail'
),

order_total as ( 
    select 
        order_id, 
        payment_status,
        sum(payment_amount) as order_value_dollars
    from payments
    group by order_id, payment_status
),

order_value_join as ( 
    select 
        orders.*,
        order_total.payment_status,
        order_total.order_value_dollars
    from orders
    left join order_total
    on orders.order_id = order_total.order_id
)
select * from order_value_join

{{ config(
    materialized='table'
) }}

