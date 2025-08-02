{{ config(
    materialized='table'
) }}

select   id as payment_id,
         paymentmethod,
         orderid as order_id,
         round(amount / 100.0, 2) as payment_amount,
         status as payment_status
from {{ source('landing', 'PAYMENTS') }}