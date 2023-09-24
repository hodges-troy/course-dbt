{{
  config(
    materialized='table'
  )
}}

SELECT 
    events.EVENT_ID,
    events.SESSION_ID,
    events.USER_ID,
    events.PAGE_URL,
    events.CREATED_AT,
    events.EVENT_TYPE,
    events.PRODUCT_ID,
    products.NAME
FROM {{ ref('stg_events') }} AS events
JOIN (SELECT DISTINCT NAME, PRODUCT_ID FROM {{ ref('stg_products') }}) AS products
USING (PRODUCT_ID)
WHERE events.EVENT_TYPE = 'page_view'