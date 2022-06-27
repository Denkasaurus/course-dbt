{{ config(materialized='table')}}

{% set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"] %}

SELECT
    event_id,
    session_id,
    user_id,
    {% for event_type in event_types %}
        MAX(CASE WHEN event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present,
    {% endfor %}
    page_url,
    created_at,
    order_id,
    product_id
FROM {{ref('stg_events')}}
GROUP BY 1,2,3,page_url, created_at, order_id, product_id