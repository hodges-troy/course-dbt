{{
    config(
        materialized='table'
    )
}}

WITH checkouts as (
    SELECT COUNT(DISTINCT session_id) as sessions_with_checkouts
    FROM {{ ref('stg_events') }}
    WHERE EVENT_TYPE = 'checkout'
),

sessions as (
    SELECT COUNT(DISTINCT session_id) as total_sessions
    FROM {{ ref('stg_events') }}
)

SELECT
    c.sessions_with_checkouts,
    s.total_sessions,
    ROUND(sessions_with_checkouts / s.total_sessions, 2) as total_conversion_rate
FROM checkouts c
CROSS JOIN sessions s