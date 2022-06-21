## Question 1
    How many users do we have?

    # Query

    SELECT
        count(DISTINCT user_id)
    FROM 
        dbt.dbt_jack_d.stg_users

    # Answer = 130

## Question 2
    On average, how many orders do we receive per hour?
    # Query

    SELECT 
        date_part('day', created_at) as create_day,
        date_part('hour', created_at) AS create_hour, 
        count(*) AS Count_Of_Deliveries
    FROM 
        dbt.dbt_jack_d.stg_orders
    GROUP BY 
        create_day, create_hour
    ORDER BY 
        1,2

## Question 3
    On average, how long does an order take from being placed to being delivered
    
    # Query
    SELECT
        AVG(delivery_time) /(3600*12) as avg_hours_to_delivery
    FROM (
        SELECT
            order_id,
            EXTRACT(EPOCH FROM(delivered_at - created_at)) as delivery_time
        FROM 
            dbt.dbt_jack_d.stg_orders
        ) as sq

## Question 4
    How many users have only made one purchase? Two purchases? Three+ purchases

    # Query
    SELECT 
        distinct purchase_count,
        count(purchase_count)
    FROM (
      SELECT user_id, count(user_id) as purchase_count
      FROM dbt.dbt_jack_d.stg_orders
      GROUP BY user_id
      ORDER BY purchase_count desc
        ) AS sq
    GROUP BY 
        purchase_count
    ORDER BY 
        purchase_count desc

## Question 5
    On average, how many unique sessions do we have per hour?

    # Query

    SELECT 
        AVG(uniq_sessions) as avg_uniq_sessions
    FROM (
        SELECT 
            date_part('day', created_at) as create_day,
            date_part('hour', created_at) AS create_hour, 
            count(DISTINCT session_id) AS uniq_sessions
        FROM 
            dbt.dbt_jack_d.stg_events
        GROUP BY 
            create_day, create_hour
        ORDER BY 
            1,2
        ) AS sq     