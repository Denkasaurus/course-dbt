{{ config(materialized='table')}}    
    
    select
      order_id,
      {{ dbt_utils.pivot('name', dbt_utils.get_column_values(ref('intermediate_products_ordered'), 'name'), agg='sum', cmp='=',
) }}
    from {{ ref('intermediate_products_ordered')}}
    group by order_id