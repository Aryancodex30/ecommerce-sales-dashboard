# Power BI / Tableau dashboard specification

## Overview
This dashboard should tell a clear business story for an e-commerce sales team:
- Are sales growing?
- Which products and customers matter most?
- Are customers being retained?
- Are fulfillment and returns hurting profitability?

## Recommended pages
### 1. Executive Overview
- KPI cards: revenue, orders, AOV, profit margin, return rate
- Revenue trend line (monthly)
- Category revenue bar chart
- Sales by geography map
- Top products table

### 2. Product Performance
- Product revenue waterfall or horizontal bar chart
- Units sold by product
- Profit margin by category
- Stock and reorder alert table
- Rating vs sales correlation

### 3. Customer Insights
- RFM segment chart
- New vs returning customers
- Customer lifetime value by segment
- Sales by customer segment
- Retention trend by cohort

### 4. Fulfillment
- Order status distribution
- Delivery time by carrier
- Return reasons
- Cancelation rate and refund trends
- Shipping costs by method

## Measures to create
- Total Revenue = SUM(orders[total_amount])
- Total Orders = DISTINCTCOUNT(orders[order_id])
- AOV = DIVIDE([Total Revenue], [Total Orders])
- Profit Margin = DIVIDE([Total Revenue] - [Cost of Goods Sold], [Total Revenue])
- Return Rate = DIVIDE([Returns Count], [Total Orders])

## DAX examples
```DAX
Total Revenue = SUM(orders[total_amount])

Total Orders = DISTINCTCOUNT(orders[order_id])

AOV = DIVIDE([Total Revenue], [Total Orders])

Profit Margin % =
DIVIDE(
    [Total Revenue] - SUM(products[cost]),
    [Total Revenue]
)

Return Rate % =
DIVIDE(
    CALCULATE(COUNT(returns[return_id])),
    [Total Orders]
)
```

## Design principles
- Use clean, uncluttered layout
- Keep performance KPIs above the fold
- Use consistent colors for revenue, margin, and risk
- Format numbers in currency and percentages cleanly
- Add filters for date, category, customer segment, geography
