{{ config(materialized='table')}}

SELECT
    event_id,
    session_id,
    user_id,
    CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END as page_view_event,
    CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END as add_to_cart_event,
    CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END as checkout_event,
    CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END as package_shipped_event,
    page_url,
    created_at,
    order_id,
    product_id
FROM {{ref('stg_events')}}