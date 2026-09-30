-- SQL: Geographic sales performance
SELECT
    c.country,
    c.state,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value,
    ROUND(
        (SUM(CASE WHEN o.order_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT o.order_id), 0)) * 100,
        2
    ) AS completion_rate_pct
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country, c.state
ORDER BY total_revenue DESC;
