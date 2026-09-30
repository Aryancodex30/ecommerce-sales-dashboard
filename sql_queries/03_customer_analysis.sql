# SQL: Customer analysis

WITH customer_order_summary AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_segment,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(o.total_amount) AS total_spend,
        MAX(o.order_date) AS last_purchase_date,
        DATEDIFF(CURDATE(), MAX(o.order_date)) AS recency_days
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.customer_name, c.customer_segment
)
SELECT
    customer_id,
    customer_name,
    customer_segment,
    order_count,
    total_spend,
    last_purchase_date,
    recency_days,
    CASE
        WHEN recency_days <= 30 AND order_count >= 3 THEN 'High Value'
        WHEN recency_days <= 60 AND order_count >= 2 THEN 'Loyal'
        WHEN recency_days > 90 THEN 'At Risk'
        ELSE 'Standard'
    END AS customer_group
FROM customer_order_summary
ORDER BY total_spend DESC;
