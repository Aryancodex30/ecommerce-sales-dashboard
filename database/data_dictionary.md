# E-Commerce Data Dictionary

## suppliers
| Column | Type | Description |
|---|---|---|
| supplier_id | INT | Unique supplier ID |
| supplier_name | VARCHAR(255) | Supplier company name |
| contact_person | VARCHAR(255) | Primary contact |
| email | VARCHAR(255) | Supplier email |
| phone | VARCHAR(20) | Supplier phone |
| country | VARCHAR(100) | Country |
| city | VARCHAR(100) | City |
| rating | DECIMAL(2,1) | Supplier rating |
| payment_terms | VARCHAR(100) | Payment conditions |
| created_date | TIMESTAMP | Record creation date |
| updated_date | TIMESTAMP | Last update |

## products
| Column | Type | Description |
|---|---|---|
| product_id | INT | Unique product ID |
| product_name | VARCHAR(255) | Product name |
| category | VARCHAR(100) | Product category |
| subcategory | VARCHAR(100) | Product subcategory |
| description | TEXT | Product description |
| price | DECIMAL(10,2) | Selling price |
| cost | DECIMAL(10,2) | Cost of goods sold |
| stock_quantity | INT | Current inventory |
| reorder_level | INT | Reorder threshold |
| supplier_id | INT | Supplier reference |
| sku | VARCHAR(50) | Stock keeping unit |
| rating | DECIMAL(3,2) | Product rating |
| review_count | INT | Number of reviews |
| created_date | TIMESTAMP | Product registration date |
| updated_date | TIMESTAMP | Last update |

## customers
| Column | Type | Description |
|---|---|---|
| customer_id | INT | Unique customer ID |
| customer_name | VARCHAR(255) | Full name |
| email | VARCHAR(255) | Email address |
| phone | VARCHAR(20) | Phone number |
| country | VARCHAR(100) | Country |
| state | VARCHAR(100) | State or region |
| city | VARCHAR(100) | City |
| postal_code | VARCHAR(20) | Postal code |
| address | TEXT | Customer address |
| customer_segment | VARCHAR(50) | Segment like Premium or Standard |
| signup_date | TIMESTAMP | Account creation date |
| last_purchase_date | DATE | Most recent order date |
| lifetime_value | DECIMAL(12,2) | Total customer value |
| total_orders | INT | Total order count |
| is_active | BOOLEAN | Active buyer flag |
| updated_date | TIMESTAMP | Last update |

## orders
| Column | Type | Description |
|---|---|---|
| order_id | INT | Unique order ID |
| customer_id | INT | Customer reference |
| order_date | TIMESTAMP | Order date |
| ship_date | DATE | Shipment date |
| delivery_date | DATE | Delivery date |
| total_amount | DECIMAL(12,2) | Final order value |
| order_subtotal | DECIMAL(12,2) | Before tax and shipping |
| discount_amount | DECIMAL(10,2) | Discount amount |
| tax_amount | DECIMAL(10,2) | Tax amount |
| shipping_cost | DECIMAL(10,2) | Delivery cost |
| order_status | VARCHAR(50) | Completed, Pending, Returned, etc. |
| payment_method | VARCHAR(50) | Card, PayPal, etc. |
| shipping_method | VARCHAR(100) | Shipping provider |
| shipping_address | TEXT | Delivery address |
| notes | TEXT | Internal order notes |
| created_date | TIMESTAMP | Order creation timestamp |

## order_items
| Column | Type | Description |
|---|---|---|
| order_item_id | INT | Unique line item ID |
| order_id | INT | Order reference |
| product_id | INT | Product reference |
| quantity | INT | Quantity sold |
| unit_price | DECIMAL(10,2) | Unit price |
| discount_percent | DECIMAL(5,2) | Discount on line item |
| line_total | DECIMAL(12,2) | Total after discounts |
| created_date | TIMESTAMP | Row creation date |

## returns
| Column | Type | Description |
|---|---|---|
| return_id | INT | Unique return ID |
| order_id | INT | Related order |
| order_item_id | INT | Related item |
| return_date | DATE | Return date |
| reason | VARCHAR(255) | Return reason |
| refund_amount | DECIMAL(12,2) | Refund value |
| return_status | VARCHAR(50) | Accepted or rejected |
| restocking_fee | DECIMAL(10,2) | Restocking fee |
| notes | TEXT | Additional notes |
| created_date | TIMESTAMP | Record creation date |
| updated_date | TIMESTAMP | Last update |

## payment_transactions
| Column | Type | Description |
|---|---|---|
| transaction_id | INT | Unique payment ID |
| order_id | INT | Related order |
| payment_method | VARCHAR(50) | Payment type |
| amount | DECIMAL(12,2) | Payment amount |
| transaction_status | VARCHAR(50) | Completed or failed |
| transaction_date | TIMESTAMP | Payment date |
| reference_number | VARCHAR(100) | Payment gateway reference |

## inventory_log
| Column | Type | Description |
|---|---|---|
| log_id | INT | Unique inventory log ID |
| product_id | INT | Product reference |
| transaction_type | VARCHAR(50) | Purchase, sale, or adjustment |
| quantity_change | INT | Change in stock |
| previous_quantity | INT | Stock before update |
| new_quantity | INT | Stock after update |
| notes | TEXT | Inventory log notes |
| created_date | TIMESTAMP | Event date |

## customer_reviews
| Column | Type | Description |
|---|---|---|
| review_id | INT | Unique review ID |
| product_id | INT | Product reference |
| customer_id | INT | Customer reference |
| order_id | INT | Related order |
| rating | INT | 1 to 5 rating |
| review_text | TEXT | Review content |
| review_date | TIMESTAMP | Date written |
| helpful_count | INT | Helpful votes |

## marketing_campaigns
| Column | Type | Description |
|---|---|---|
| campaign_id | INT | Unique campaign ID |
| campaign_name | VARCHAR(255) | Campaign name |
| campaign_type | VARCHAR(100) | Email, discount, social, etc. |
| start_date | DATE | Campaign start |
| end_date | DATE | Campaign end |
| budget | DECIMAL(12,2) | Budget |
| discount_percent | DECIMAL(5,2) | Discount percentage |
| target_segment | VARCHAR(100) | Audience target |
| created_date | TIMESTAMP | Creation date |
