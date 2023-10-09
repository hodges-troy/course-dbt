{{
    config(
        materialized='table'
    )
}}


SELECT 
session_id
{{ value_counts(table='stg_events', column='event_type') }}
FROM {{ ref('stg_events') }}
GROUP BY session_id