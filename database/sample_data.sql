# Sample dataset insert script (example)

INSERT INTO suppliers (supplier_name, contact_person, email, phone, country, city, rating, payment_terms) VALUES
('Northwind Goods', 'Alice Stone', 'alice@northwindgoods.com', '+1-555-1001', 'USA', 'Seattle', 4.8, 'Net 30'),
('Global Mart Supply', 'Sam Lee', 'sam@globalmartsupply.com', '+44-20-555-2001', 'UK', 'London', 4.6, 'Net 45'),
('Pacific Retail Partners', 'Nina Patel', 'nina@pacificretail.com', '+61-2-555-3001', 'Australia', 'Sydney', 4.7, 'Net 30');

INSERT INTO products (product_name, category, subcategory, description, price, cost, stock_quantity, reorder_level, supplier_id, sku, rating, review_count) VALUES
('Wireless Mouse', 'Electronics', 'Accessories', 'Ergonomic wireless mouse', 29.99, 15.50, 220, 80, 1, 'ELE-1001', 4.7, 420),
('Office Chair', 'Furniture', 'Office', 'Comfortable ergonomic chair', 189.99, 110.00, 80, 30, 2, 'FUR-2001', 4.6, 310),
('Classic Hoodie', 'Apparel', 'Men', 'Cotton hoodie with logo', 54.99, 24.00, 150, 50, 3, 'APP-3001', 4.8, 500);

INSERT INTO customers (customer_name, email, phone, country, state, city, postal_code, address, customer_segment, signup_date, lifetime_value, total_orders) VALUES
('Emma Johnson', 'emma@example.com', '+1-555-0101', 'USA', 'California', 'Los Angeles', '90001', '10 Sunset Blvd', 'Premium', '2023-01-10', 1200.00, 6),
('Liam Carter', 'liam@example.com', '+44-20-555-0102', 'UK', 'England', 'London', 'SW1A', '12 Oxford Rd', 'Standard', '2022-08-15', 640.00, 3),
('Priya Singh', 'priya@example.com', '+61-2-555-0103', 'Australia', 'NSW', 'Sydney', '2000', '5 George St', 'Premium', '2024-02-20', 980.00, 4);

INSERT INTO orders (customer_id, order_date, ship_date, delivery_date, total_amount, order_subtotal, discount_amount, tax_amount, shipping_cost, order_status, payment_method, shipping_method, shipping_address) VALUES
(1, '2025-01-12 10:00:00', '2025-01-13', '2025-01-15', 89.98, 89.98, 0.00, 7.20, 8.99, 'Completed', 'Credit Card', 'Express', '10 Sunset Blvd'),
(2, '2025-02-05 15:30:00', '2025-02-06', '2025-02-09', 54.99, 54.99, 5.00, 4.40, 6.99, 'Completed', 'PayPal', 'Standard', '12 Oxford Rd'),
(3, '2025-03-18 09:15:00', '2025-03-19', '2025-03-23', 189.99, 189.99, 0.00, 15.20, 9.99, 'Completed', 'Credit Card', 'Express', '5 George St');

INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_percent, line_total) VALUES
(1, 1, 2, 29.99, 0, 59.98),
(2, 3, 1, 54.99, 10, 49.49),
(3, 2, 1, 189.99, 0, 189.99);

INSERT INTO returns (order_id, order_item_id, return_date, reason, refund_amount, return_status, restocking_fee) VALUES
(2, 2, '2025-02-12', 'Size mismatch', 49.49, 'Accepted', 5.00);
