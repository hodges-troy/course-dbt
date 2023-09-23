{{
    config(
        materialized='table'
    )
}}

SELECT 
    events.PRODUCT_ID,
    products.NAME,
    TO_CHAR(events.CREATED_AT, 'YYYY-MM-DD') AS VIEW_DATE,
    COUNT(VIEW_DATE) AS PAGE_VIEWS
FROM {{ ref('stg_events') }} AS events
JOIN (SELECT DISTINCT NAME, PRODUCT_ID FROM {{ ref('stg_products') }}) AS products
USING (PRODUCT_ID)
WHERE events.EVENT_TYPE = 'page_view'
GROUP BY events.PRODUCT_ID, NAME, VIEW_DATE
ORDER BY PRODUCT_ID, NAME, VIEW_DATE