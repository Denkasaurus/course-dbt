## What is our overall conversion rate?
    WITH subquery AS (

    SELECT
        COUNT(session_id) as unique_sessions,
        SUM(checkout_event) as checkout_sessions
    FROM dbt.dbt_jack_d.session_fact
    )

    SELECT 
    checkout_sessions/unique_sessions as conversion_rate
    FROM subquery

    38.44% conversion rate

## conversion rate per product

        WITH 
        
        sq1 as (
            SELECT
            product_id,
            count(session_id) as prod_view_count
            FROM dbt.dbt_jack_d.stg_events
            WHERE event_type = 'page_view'
            GROUP BY 1
            ),
            
        sq2 as (
            SELECT
            product_id,
            count(session_id) as prod_covert_count
            FROM dbt.dbt_jack_d.stg_events
            WHERE event_type = 'add_to_cart'
            GROUP BY 1
            )
            
        SELECT 
            sq1.product_id,
            prod_covert_count::float / prod_view_count
        FROM 
            sq1
        JOIN sq2
            ON sq1.product_id = sq2.product_id

    So I did get different generalized results... averages of 50% conversion just looking at the data. Unsure if this is correct as my overall conversion is signifigantly lower. I believe this may be due to the non-use of sessions and could be manipulating the data that way but I'll have to think about it more.