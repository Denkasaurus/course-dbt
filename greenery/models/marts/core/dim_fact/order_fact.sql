{{ config(materialized= 'table')}}

SELECT
    od.order_id,
    ul.user_id,
    ul.first_name,
    ul.last_name,
    ul.email,
    od.order_cost,
    od.status,
    od.created_at,
    SUM(po.quantity) as item_count,
    od.shipping_cost
FROM {{ ref('stg_orders')}} as od
JOIN {{ ref('intermediate_user_location')}} as ul
    ON od.user_id = ul.user_id
JOIN {{ ref('intermediate_products_ordered')}} as po
    ON od.order_id = po.order_id
GROUP BY 1,2,3,4,5,6,7,8,10