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
FROM DEV_DB.DBT_TJHODGES12GMAILCOM.STG_EVENTS
WHERE EVENT_TYPE = 'page_view'