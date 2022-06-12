{{config(materialized='view')}}

SELECT
    order_id,
    product_id,
    quantity
FROM
    {{ source('public', 'order_items')}}