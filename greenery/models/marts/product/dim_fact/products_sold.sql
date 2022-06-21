{{ config(materialized='table')}}

SELECT
    po.name,
    po.price as listed_price,
    SUM(po.quantity) as products_sold,
    SUM(po.quantity) * po.price as listed_value_sold
FROM {{ref('intermediate_products_ordered')}} as po
GROUP BY 1,2