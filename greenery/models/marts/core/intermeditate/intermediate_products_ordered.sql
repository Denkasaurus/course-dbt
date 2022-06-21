{{ config(materialized = 'table')}}

SELECT
    oi.order_id,
    oi.quantity,
    pr.name,
    pr.price
FROM {{ ref('stg_order_items')}} as oi
JOIN {{ ref('stg_products')}} as pr
    ON oi.product_id = pr.product_id
