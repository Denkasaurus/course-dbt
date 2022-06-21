{{ config(materialized='view')}}

SELECT 
    product_id,
    name,
    price,
    inventory
FROM
    {{ source('public', 'products')}}