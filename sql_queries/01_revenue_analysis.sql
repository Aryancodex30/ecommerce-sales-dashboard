# SQL: Revenue analysis

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_amount) AS revenue,
        COUNT(DISTINCT order_id) AS total_orders,
        ROUND(AVG(total_amount), 2) AS avg_order_value
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    month,
    revenue,
    total_orders,
    avg_order_value,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month))
        / NULLIF(LAG(revenue) OVER (ORDER BY month), 0)) * 100,
        2
    ) AS revenue_growth_pct
FROM monthly_sales
ORDER BY month;
