{{ config(materialized='table')}}

SELECT
    ul.user_id,
    ul.first_name,
    ul.last_name,
    ul.email,
    ul.state,
    ul.country,
    ul.created_at as user_creation,
    COUNT(od.order_id) as number_of_orders,
    SUM(od.order_total) as total_value_of_orders,
    AVG(od.order_total) as avg_order_value,
    COUNT(od.promo_id) as promos_used
FROM {{ref ('intermediate_user_location')}} as ul
JOIN {{ref ('stg_orders')}} as od
    ON ul.user_id = od.user_id
GROUP BY 1,2,3,4,5,6,7