-- import CTEs
with 

customers as (select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('int_orders') }}
),
 
customer_orders as (
select 
        orders.* ,
        customers.givenname,
        customers.surname,
        customers.full_name,
        min(orders.order_date) over (partition by customers.customer_id) as customer_first_order_date,
        min(orders.valid_order_date) over (partition by customers.customer_id) as customer_first_non_returned_order_date,
        max(orders.valid_order_date) over (partition by customers.customer_id) as customer_most_recent_non_returned_order_date,
        count(*) over (partition by customers.customer_id) as customer_order_count,
        sum(nvl2(orders.valid_order_date, 1, 0)) over (partition by customers.customer_id) as customer_non_returned_order_count,
        sum(case when orders.valid_order_date is not null then orders.order_value_dollars else 0 end) 
        over (partition by customers.customer_id) as customer_total_lifetime_value,
        array_agg(distinct orders.order_id) over (partition by customers.customer_id) as customer_order_ids
from orders 
inner join customers
on orders.customer_id = customers.customer_id
),

add_avg_order_history as 
    (
    select 
        *,
        customer_total_lifetime_value / customer_non_returned_order_count as avg_non_returned_order_value

    from customer_orders
    ),

final as ( 
    select 
    order_id ,
    customer_id ,
    surname,
    givenname,
    customer_first_order_date as first_order_date,
    customer_order_count as order_count,
    customer_total_lifetime_value as total_lifetime_value,
    order_value_dollars,
    order_status ,
    payment_status
    from add_avg_order_history
)

select * from final