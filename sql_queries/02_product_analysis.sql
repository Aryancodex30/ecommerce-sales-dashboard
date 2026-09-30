SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.line_total) AS total_revenue,
    ROUND(AVG(cr.rating), 2) AS avg_rating,
    ROUND(
        ((SUM(oi.line_total) - (p.cost * SUM(oi.quantity))) / NULLIF(SUM(oi.line_total), 0)) * 100,
        2
    ) AS profit_margin_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN customer_reviews cr ON cr.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;
