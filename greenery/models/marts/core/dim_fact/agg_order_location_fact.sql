{{ config(materialized = 'table')}}

SELECT
    ad.state,
    ad.country,
    COUNT(o.order_id) as order_count,
    COUNT(DISTINCT o.user_id) as user_count,
    AVG(o.order_cost) as avg_order_value,
    SUM(o.order_cost) as total_orders_value
FROM {{ref ('stg_orders')}} as o
JOIN {{ref ('stg_addresses')}} as ad
    ON o.address_id = ad.address_id
GROUP BY ad.state, ad.country

    