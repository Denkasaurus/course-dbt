{{ config(materialized='table')}}

SELECT
    EXTRACT(YEAR FROM o.created_at) as year,
    EXTRACT(MONTH FROM o.created_at) as month,
    po.name,
    po.price as listed_price,
    SUM(po.quantity) as products_sold,
    SUM(po.quantity) * po.price as listed_value_sold
FROM {{ref('intermediate_products_ordered')}} as po
JOIN {{ref('stg_orders')}} as o
    ON o.order_id = po.order_id
GROUP BY 1,2,3,4