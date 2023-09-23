{{
  config(
    materialized='table'
  )
}}

SELECT 
    EVENT_ID,
    SESSION_ID,
    USER_ID,
    PAGE_URL,
    CREATED_AT,
    EVENT_TYPE,
    PRODUCT_ID
FROM {{ ref('stg_events') }}
WHERE EVENT_TYPE = 'page_view'