{{
    config(
        materialized='table'
    )
}}

SELECT
    orders.order_id,
    array_agg(items.product_id) AS product_id,
    array_agg(items.quantity) AS product_quantity,
    orders.user_id,
    orders.promo_id,
    orders.address_id,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_id,
    orders.shipping_service,
    orders.estimated_delivery_at,
    orders.delivered_at,
    orders.status
FROM {{ ref('stg_orders') }} orders
LEFT JOIN {{ ref('stg_order_items')}} items
ON orders.order_id = items.order_id
GROUP BY 
    orders.order_id,
    order_cost,
    orders.user_id,
    orders.promo_id,
    orders.address_id,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_id,
    orders.shipping_service,
    orders.estimated_delivery_at,
    orders.delivered_at,
    orders.status