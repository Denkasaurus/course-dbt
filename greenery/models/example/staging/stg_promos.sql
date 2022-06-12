{{ config(materialized='view')}}

SELECT
    promo_id,
    discount,
    status
FROM
    {{ source('public', 'promos')}}