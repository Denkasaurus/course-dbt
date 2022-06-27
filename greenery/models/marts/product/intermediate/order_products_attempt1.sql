{{config(materialized='table')}}

{% set products = dbt_utils.get_query_results_as_dict(
    "SELECT DISTINCT name FROM" ~ ref('intermediate_products_ordered')) %}

SELECT 
    order_id,
    {% for product in products %}
        SUM(CASE WHEN product = '{{product}}' then 1 else 0 end) as{{product}}_ordered
    {% endfor %} 
FROM {{ ref('intermediate_products_ordered') }}
GROUP BY 1