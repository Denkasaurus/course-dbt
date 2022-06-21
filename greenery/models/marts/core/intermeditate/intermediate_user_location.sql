{{ config(materialized='table')}}

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    ad.zipcode,
    ad.state,
    ad.country
FROM {{ ref('stg_users')}} as u
RIGHT JOIN {{ ref('stg_addresses')}} as ad
    ON u.address_id = ad.address_id