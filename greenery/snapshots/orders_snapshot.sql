{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      strategy='check',
      unique_key='order_id',
      check_cols=['status'],
    )
  }}

  SELECT 
    * 
  FROM 
    {{ ref('stg_orders')}}

{% endsnapshot %}