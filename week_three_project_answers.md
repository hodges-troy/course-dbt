## Week Three Project Answers

### Part 1. New Models
**What is our overall conversion rate?**

The conversion rate is 62% (quite high!) See model `fact_conversion_rate.sql` in `models/marts/product` subdirectory.

The model uses this query:
```
WITH checkouts as (
    SELECT COUNT(DISTINCT session_id) as sessions_with_checkouts
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_EVENTS
    WHERE EVENT_TYPE = 'checkout'
),

sessions as (
    SELECT COUNT(DISTINCT session_id) as total_sessions
    FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_EVENTS
)

SELECT
    c.sessions_with_checkouts,
    s.total_sessions,
    ROUND(sessions_with_checkouts / s.total_unique_sessions, 2) as total_conversation_rate
FROM checkouts c
CROSS JOIN sessions s
```

**What is our conversation rate by product?**

Did not get to.


## Part 2. Add Macro


