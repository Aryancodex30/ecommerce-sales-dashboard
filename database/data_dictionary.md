# E-Commerce Database - Data Dictionary

## Overview
Complete documentation of all tables, columns, and data types in the e-commerce database schema.

---

## 1. SUPPLIERS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| supplier_id | INT | PK, AUTO_INCREMENT | Unique identifier for supplier |
| supplier_name | VARCHAR(255) | NOT NULL | Name of supplier company |
| contact_person | VARCHAR(255) | - | Primary contact person name |
| email | VARCHAR(255) | - | Supplier email address |
| phone | VARCHAR(20) | - | Supplier phone number |
| country | VARCHAR(100) | - | Supplier country location |
| city | VARCHAR(100) | - | Supplier city location |
| rating | DECIMAL(2,1) | - | Supplier rating (1-10) |
| payment_terms | VARCHAR(100) | - | Payment terms (e.g., "Net 30") |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE | Last update timestamp |

---

## 2. PRODUCTS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| product_id | INT | PK, AUTO_INCREMENT | Unique product identifier |
| product_name | VARCHAR(255) | NOT NULL | Name of the product |
| category | VARCHAR(100) | NOT NULL | Primary product category |
| subcategory | VARCHAR(100) | - | Secondary product category |
| description | TEXT | - | Detailed product description |
| price | DECIMAL(10,2) | NOT NULL | Selling price |
| cost | DECIMAL(10,2) | NOT NULL | Cost/COGS |
| stock_quantity | INT | DEFAULT 0 | Current inventory quantity |
| reorder_level | INT | DEFAULT 100 | Min quantity before reorder |
| supplier_id | INT | FK → suppliers | Supplier reference |
| sku | VARCHAR(50) | UNIQUE | Stock keeping unit |
| rating | DECIMAL(3,2) | - | Average product rating (0-5) |
| review_count | INT | DEFAULT 0 | Number of customer reviews |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Product creation date |
| updated_date | TIMESTAMP | AUTO UPDATE | Last update timestamp |

**Indexes**: category, created_date, category + subcategory

---

## 3. CUSTOMERS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| customer_id | INT | PK, AUTO_INCREMENT | Unique customer identifier |
| customer_name | VARCHAR(255) | NOT NULL | Full customer name |
| email | VARCHAR(255) | UNIQUE | Customer email address |
| phone | VARCHAR(20) | - | Customer phone number |
| country | VARCHAR(100) | - | Customer country |
| state | VARCHAR(100) | - | Customer state/province |
| city | VARCHAR(100) | - | Customer city |
| postal_code | VARCHAR(20) | - | Customer postal/zip code |
| address | TEXT | - | Full street address |
| customer_segment | VARCHAR(50) | - | Segment (Premium/Standard/Budget) |
| signup_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Account creation date |
| last_purchase_date | DATE | - | Date of most recent purchase |
| lifetime_value | DECIMAL(12,2) | DEFAULT 0 | Total customer spend |
| total_orders | INT | DEFAULT 0 | Count of customer orders |
| is_active | BOOLEAN | DEFAULT TRUE | Active/inactive status |
| updated_date | TIMESTAMP | AUTO UPDATE | Last update timestamp |

**Indexes**: email, customer_segment, signup_date

---

## 4. ORDERS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| order_id | INT | PK, AUTO_INCREMENT | Unique order identifier |
| customer_id | INT | FK NOT NULL | Reference to customer |
| order_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Date order was placed |
| ship_date | DATE | - | Date order shipped |
| delivery_date | DATE | - | Date order delivered |
| total_amount | DECIMAL(12,2) | NOT NULL | Total order amount (final) |
| order_subtotal | DECIMAL(12,2) | - | Subtotal before tax/discount |
| discount_amount | DECIMAL(10,2) | DEFAULT 0 | Total discount applied |
| tax_amount | DECIMAL(10,2) | DEFAULT 0 | Tax charged |
| shipping_cost | DECIMAL(10,2) | DEFAULT 0 | Shipping fee |
| order_status | VARCHAR(50) | - | Status (Completed/Pending/Cancelled/Returned) |
| payment_method | VARCHAR(50) | - | Payment type (Credit Card/PayPal/etc) |
| shipping_method | VARCHAR(100) | - | Shipping carrier/method |
| shipping_address | TEXT | - | Delivery address |
| notes | TEXT | - | Internal order notes |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |

**Indexes**: customer_id, order_date, order_status, delivery_date, (customer_id + order_date)

---

## 5. ORDER ITEMS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| order_item_id | INT | PK, AUTO_INCREMENT | Unique order line item ID |
| order_id | INT | FK NOT NULL | Reference to order |
| product_id | INT | FK NOT NULL | Reference to product |
| quantity | INT | NOT NULL DEFAULT 1 | Quantity ordered |
| unit_price | DECIMAL(10,2) | NOT NULL | Price per unit at time of sale |
| discount_percent | DECIMAL(5,2) | DEFAULT 0 | Line item discount % |
| line_total | DECIMAL(12,2) | - | quantity × unit_price - discount |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |

**Indexes**: order_id, product_id, (order_id + product_id)

---

## 6. RETURNS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| return_id | INT | PK, AUTO_INCREMENT | Unique return identifier |
| order_id | INT | FK NOT NULL | Reference to original order |
| order_item_id | INT | FK | Reference to specific line item |
| return_date | DATE | NOT NULL | Date item was returned |
| reason | VARCHAR(255) | - | Return reason (Defective/Wrong/etc) |
| refund_amount | DECIMAL(12,2) | - | Amount refunded to customer |
| return_status | VARCHAR(50) | - | Status (Accepted/Rejected/Processing) |
| restocking_fee | DECIMAL(10,2) | DEFAULT 0 | Restocking fee charged |
| notes | TEXT | - | Additional return notes |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |
| updated_date | TIMESTAMP | AUTO UPDATE | Last update timestamp |

**Indexes**: order_id, return_date, return_status

---

## 7. PAYMENT TRANSACTIONS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| transaction_id | INT | PK, AUTO_INCREMENT | Unique transaction identifier |
| order_id | INT | FK NOT NULL | Reference to order |
| payment_method | VARCHAR(50) | - | Payment type |
| amount | DECIMAL(12,2) | - | Transaction amount |
| transaction_status | VARCHAR(50) | - | Status (Completed/Failed/Pending) |
| transaction_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Payment date/time |
| reference_number | VARCHAR(100) | - | Payment gateway reference |

**Indexes**: order_id, transaction_date

---

## 8. INVENTORY LOG Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| log_id | INT | PK, AUTO_INCREMENT | Unique log entry ID |
| product_id | INT | FK NOT NULL | Reference to product |
| transaction_type | VARCHAR(50) | - | Type (Purchase/Sale/Adjustment/Return) |
| quantity_change | INT | - | Quantity added/removed |
| previous_quantity | INT | - | Stock level before change |
| new_quantity | INT | - | Stock level after change |
| notes | TEXT | - | Transaction notes |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Transaction date |

**Indexes**: product_id, created_date

---

## 9. CUSTOMER REVIEWS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| review_id | INT | PK, AUTO_INCREMENT | Unique review identifier |
| product_id | INT | FK NOT NULL | Reference to product |
| customer_id | INT | FK NOT NULL | Reference to customer |
| order_id | INT | FK | Reference to order |
| rating | INT | CHECK (1-5) | Rating score (1-5 stars) |
| review_text | TEXT | - | Written review content |
| review_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Review submission date |
| helpful_count | INT | DEFAULT 0 | Count of "helpful" votes |

**Indexes**: product_id, rating, review_date

---

## 10. MARKETING CAMPAIGNS Table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| campaign_id | INT | PK, AUTO_INCREMENT | Unique campaign identifier |
| campaign_name | VARCHAR(255) | - | Marketing campaign name |
| campaign_type | VARCHAR(100) | - | Type (Email/Discount/Social/etc) |
| start_date | DATE | - | Campaign start date |
| end_date | DATE | - | Campaign end date |
| budget | DECIMAL(12,2) | - | Campaign budget amount |
| discount_percent | DECIMAL(5,2) | - | Discount offered (if applicable) |
| target_segment | VARCHAR(100) | - | Target customer segment |
| created_date | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Record creation date |

**Indexes**: campaign_type, (start_date + end_date)

---

## Analytics Views

### customer_summary
Aggregated customer metrics including order count, lifetime value, purchase frequency.

### product_performance
Product-level KPIs: revenue, profit, margin, ratings, inventory.

### daily_sales
Daily aggregated sales metrics: orders, revenue, discounts, taxes, shipping, AOV.

### return_analysis
Daily return metrics: count, refunds, return rate by reason.

### geographic_sales
Sales by country/state: customer count, orders, revenue, AOV.

---

## Data Quality Standards

- **Date Consistency**: All dates in YYYY-MM-DD format, timestamps in UTC
- **Pricing**: All amounts in decimal(X,2) format (2 decimal places)
- **Foreign Keys**: All relationships enforced with FK constraints
- **Status Fields**: Standardized values (Completed, Pending, Cancelled, Returned, etc)
- **Naming**: Snake_case for columns, consistent terminology across tables

---

## Common Calculations

### Order Value Calculations
```
total_amount = order_subtotal - discount_amount + tax_amount + shipping_cost
line_total = (unit_price × quantity) - (unit_price × quantity × discount_percent / 100)
```

### Profit Calculations
```
profit = revenue - cost
profit_margin = (revenue - cost) / revenue × 100
gross_margin = (price - cost) / price × 100
```

### Customer Metrics
```
lifetime_value = SUM(total_amount) for all customer orders
avg_order_value = SUM(total_amount) / COUNT(orders)
return_rate = COUNT(returns) / COUNT(orders) × 100
```

---

## Related Documents
- `schema.sql` - Database creation script
- `sample_data.sql` - Sample dataset
- See SQL queries folder for analysis examples
