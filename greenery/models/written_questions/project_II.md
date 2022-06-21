SELECT 
  CAST( sum(has_many_purchases) as float) / CAST( sum(has_purchased) as float) as repeat_rate
FROM (
    SELECT 
      user_id,
      (user_orders = 1)::int as has_one_purchases,
      (user_orders >= 2)::int as has_many_purchases,
      (user_orders > 0)::int as has_purchased
    FROM (SELECT 
            user_id,
            count(order_id) as user_orders
          FROM 
            dbt.dbt_jack_d.stg_orders
          GROUP BY 
            user_id
          ) AS user_order_count
    ) as user_order_buckets
  

Good indicators of a user who will purchase again...

  Time spent on site
  quantiy purchased
  previous order details, 
    quantity
    returns
    variety of items ordered
  promos
    money saved
    percent saved
    reason for promo
  engagement metrics
    where they came from 
    time of day
    time of year (holidays)
    email response
    survey response (y/n)
    survey response (g/b)
  shipping time

## Adding Models 
  I've added models mainly to aggregate on user and order levels. Intermediate marts are used to easily join datasets together in a repeatable fashion. they are then referenced for the end user marts.

## Testing
I struggled with the testing...  I couldnt figure out the freshness setup, I need to read/learn more about yml files and thier design.

I think I could have also set up my intermediate marts in a better way for testing, and could push a signifigant amount of testing farther upstream.