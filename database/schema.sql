-- E-Commerce Sales Database Schema
-- Complete normalized database design for e-commerce analytics
-- Created: September 2026

-- ============================================
-- 1. SUPPLIERS TABLE
-- ============================================
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    country VARCHAR(100),
    city VARCHAR(100),
    rating DECIMAL(2, 1),
    payment_terms VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- 2. PRODUCTS TABLE
-- ============================================
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    subcategory VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    cost DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    reorder_level INT DEFAULT 100,
    supplier_id INT,
    sku VARCHAR(50) UNIQUE,
    rating DECIMAL(3, 2),
    review_count INT DEFAULT 0,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    INDEX idx_category (category),
    INDEX idx_created_date (created_date)
);

-- ============================================
-- 3. CUSTOMERS TABLE
-- ============================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    country VARCHAR(100),
    state VARCHAR(100),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    address TEXT,
    customer_segment VARCHAR(50),
    signup_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_purchase_date DATE,
    lifetime_value DECIMAL(12, 2) DEFAULT 0,
    total_orders INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_segment (customer_segment),
    INDEX idx_signup_date (signup_date)
);

-- ============================================
-- 4. ORDERS TABLE
-- ============================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ship_date DATE,
    delivery_date DATE,
    total_amount DECIMAL(12, 2) NOT NULL,
    order_subtotal DECIMAL(12, 2),
    discount_amount DECIMAL(10, 2) DEFAULT 0,
    tax_amount DECIMAL(10, 2) DEFAULT 0,
    shipping_cost DECIMAL(10, 2) DEFAULT 0,
    order_status VARCHAR(50),
    payment_method VARCHAR(50),
    shipping_method VARCHAR(100),
    shipping_address TEXT,
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    INDEX idx_customer_id (customer_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (order_status),
    INDEX idx_delivery_date (delivery_date)
);

-- ============================================
-- 5. ORDER ITEMS TABLE
-- ============================================
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    discount_percent DECIMAL(5, 2) DEFAULT 0,
    line_total DECIMAL(12, 2),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX idx_order_id (order_id),
    INDEX idx_product_id (product_id)
);

-- ============================================
-- 6. RETURNS TABLE
-- ============================================
CREATE TABLE returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    order_item_id INT,
    return_date DATE NOT NULL,
    reason VARCHAR(255),
    refund_amount DECIMAL(12, 2),
    return_status VARCHAR(50),
    restocking_fee DECIMAL(10, 2) DEFAULT 0,
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (order_item_id) REFERENCES order_items(order_item_id),
    INDEX idx_order_id (order_id),
    INDEX idx_return_date (return_date),
    INDEX idx_status (return_status)
);

-- ============================================
-- 7. PAYMENT TRANSACTIONS TABLE
-- ============================================
CREATE TABLE payment_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(50),
    amount DECIMAL(12, 2),
    transaction_status VARCHAR(50),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reference_number VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    INDEX idx_order_id (order_id),
    INDEX idx_transaction_date (transaction_date)
);

-- ============================================
-- 8. INVENTORY LOG TABLE
-- ============================================
CREATE TABLE inventory_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    transaction_type VARCHAR(50),
    quantity_change INT,
    previous_quantity INT,
    new_quantity INT,
    notes TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    INDEX idx_product_id (product_id),
    INDEX idx_created_date (created_date)
);

-- ============================================
-- 9. CUSTOMER REVIEWS TABLE
-- ============================================
CREATE TABLE customer_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    helpful_count INT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    INDEX idx_product_id (product_id),
    INDEX idx_rating (rating),
    INDEX idx_review_date (review_date)
);

-- ============================================
-- 10. MARKETING CAMPAIGNS TABLE
-- ============================================
CREATE TABLE marketing_campaigns (
    campaign_id INT PRIMARY KEY AUTO_INCREMENT,
    campaign_name VARCHAR(255),
    campaign_type VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12, 2),
    discount_percent DECIMAL(5, 2),
    target_segment VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_campaign_type (campaign_type),
    INDEX idx_dates (start_date, end_date)
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================
CREATE INDEX idx_orders_customer_date ON orders(customer_id, order_date);
CREATE INDEX idx_order_items_order_product ON order_items(order_id, product_id);
CREATE INDEX idx_products_category_subcategory ON products(category, subcategory);
CREATE INDEX idx_customers_segment_signup ON customers(customer_segment, signup_date);

-- ============================================
-- VIEWS FOR ANALYTICS
-- ============================================

-- Customer Summary View
CREATE VIEW customer_summary AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    c.signup_date,
    COUNT(o.order_id) as total_orders,
    SUM(o.total_amount) as total_revenue,
    AVG(o.total_amount) as avg_order_value,
    MAX(o.order_date) as last_purchase_date,
    DATEDIFF(CURDATE(), MAX(o.order_date)) as days_since_last_purchase
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_segment, c.signup_date;

-- Product Performance View
CREATE VIEW product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.price,
    p.cost,
    COUNT(DISTINCT o.order_id) as orders_count,
    SUM(oi.quantity) as total_quantity_sold,
    SUM(oi.line_total) as total_revenue,
    SUM(oi.line_total) - (p.cost * SUM(oi.quantity)) as total_profit,
    ROUND((SUM(oi.line_total) - (p.cost * SUM(oi.quantity))) / SUM(oi.line_total) * 100, 2) as profit_margin,
    AVG(pr.rating) as avg_rating,
    p.stock_quantity
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id
LEFT JOIN customer_reviews pr ON p.product_id = pr.product_id
GROUP BY p.product_id, p.product_name, p.category, p.subcategory, p.price, p.cost, p.stock_quantity;

-- Daily Sales View
CREATE VIEW daily_sales AS
SELECT 
    DATE(o.order_date) as sale_date,
    COUNT(o.order_id) as orders_count,
    SUM(o.total_amount) as revenue,
    SUM(o.order_subtotal) as subtotal,
    SUM(o.discount_amount) as discounts,
    SUM(o.tax_amount) as taxes,
    SUM(o.shipping_cost) as shipping,
    AVG(o.total_amount) as avg_order_value,
    COUNT(DISTINCT o.customer_id) as unique_customers
FROM orders o
GROUP BY DATE(o.order_date);

-- Return Analysis View
CREATE VIEW return_analysis AS
SELECT 
    DATE(r.return_date) as return_date,
    r.reason,
    COUNT(r.return_id) as return_count,
    SUM(r.refund_amount) as total_refunds,
    ROUND(COUNT(r.return_id) / (SELECT COUNT(*) FROM orders WHERE DATE(order_date) = DATE(r.return_date)) * 100, 2) as return_rate
FROM returns r
GROUP BY DATE(r.return_date), r.reason;

-- Geographic Sales View
CREATE VIEW geographic_sales AS
SELECT 
    c.country,
    c.state,
    COUNT(DISTINCT c.customer_id) as customer_count,
    COUNT(o.order_id) as order_count,
    SUM(o.total_amount) as revenue,
    AVG(o.total_amount) as avg_order_value
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.country, c.state;

-- ============================================
-- END OF SCHEMA
-- ============================================
