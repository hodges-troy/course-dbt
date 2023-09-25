-- All delivered items should have a delivery date after the order was created

SELECT *
FROM {{ ref('stg_orders') }}
WHERE STATUS = 'delivered' and (CREATED_AT > DELIVERED_AT)