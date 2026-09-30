-- SQL: Order and fulfillment analysis
WITH fulfillment AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_date,
        o.ship_date,
        o.delivery_date,
        DATEDIFF(o.delivery_date, o.ship_date) AS shipping_days,
        DATEDIFF(o.delivery_date, o.order_date) AS total_cycle_days,
        o.order_status,
        o.shipping_method,
        o.total_amount
    FROM orders o
)
SELECT
    shipping_method,
    COUNT(order_id) AS orders_count,
    ROUND(AVG(shipping_days), 2) AS avg_shipping_days,
    ROUND(AVG(total_cycle_days), 2) AS avg_cycle_days,
    ROUND(SUM(CASE WHEN order_status = 'Completed' THEN total_amount ELSE 0 END), 2) AS completed_revenue
FROM fulfillment
GROUP BY shipping_method
ORDER BY completed_revenue DESC;
