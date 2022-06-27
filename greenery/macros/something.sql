
FOR
    session_id, 
    {% for event_type in event_types %}
        MAX(CASE WHEN event_type = '{{event_type}}' then 1 else 0 as {{event_types}}_present,
    {% endfor %}
FROM {{ref('stg_events') }}
GROUP BY session_id