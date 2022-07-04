{{ config(materialized= 'table')}}

WITH agg_query as (SELECT
    COUNT( DISTINCT session_id) as unique_sessions,
    SUM(CASE WHEN page_view_event > 0 Then 1 Else 0 End) AS page_view_sessions,
    SUM(CASE WHEN add_to_cart_event > 0 Then 1 Else 0 End) AS add_to_cart_sessions,
    SUM(CASE WHEN checkout_event > 0 Then 1 Else 0 End) AS checkout_sessions,
    SUM(CASE WHEN package_shipped_event > 0 Then 1 Else 0 End) AS package_shipped_sessions
FROM 
    {{ ref('session_fact')}}
)

SELECT 
    agg_query.add_to_cart_sessions::float / page_view_sessions as conversions_stage_1,
    agg_query.checkout_sessions::float / agg_query.add_to_cart_sessions as conversion_stage_2,
    agg_query.package_shipped_sessions::float / agg_query.checkout_sessions as conversion_stage_3
FROM 
    agg_query