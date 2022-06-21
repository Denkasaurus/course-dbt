{{ config(materialized= 'table')}}

SELECT
    session_id,
    user_id,
    MAX(created_at) - MIN(created_at) as session_length,
    order_id,
    SUM(page_view_event) as page_view_event,
    SUM(add_to_cart_event) as add_to_cart_event,
    SUM(checkout_event) as checkout_event,
    SUM(package_shipped_event) as package_shipped_event
FROM {{ ref('intermediate_event_actions')}}
GROUP by 1,2,4