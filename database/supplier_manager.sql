-- Supplier Manager Database SQL Export
-- Database for Supply Chain Management System
-- Created: 2026-05-25

-- Create Database
CREATE DATABASE IF NOT EXISTS supplier_manager;
USE supplier_manager;

-- Table: suppliers (Προμηθευτές)
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    lead_time_days INT DEFAULT 5,
    rating INT DEFAULT 3,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: products (Προϊόντα)
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    supplier_id INT,
    price DECIMAL(10, 2) NOT NULL,
    available_stock INT DEFAULT 0,
    reserved_stock INT DEFAULT 0,
    damaged_stock INT DEFAULT 0,
    reorder_level INT DEFAULT 10,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Table: customers (Πελάτες)
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    address TEXT,
    outstanding_balance DECIMAL(10, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: orders (Παραγγελίες)
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    total_amount DECIMAL(10, 2) DEFAULT 0,
    payment_method VARCHAR(50),
    tracking_number VARCHAR(100),
    delivery_date_estimated DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Table: order_items (Είδη Παραγγελίας)
CREATE TABLE IF NOT EXISTS order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Table: warehouse_movements (Κινήσεις Αποθήκης)
CREATE TABLE IF NOT EXISTS warehouse_movements (
    movement_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    movement_type ENUM('inbound', 'outbound', 'transfer') NOT NULL,
    quantity INT NOT NULL,
    from_warehouse VARCHAR(100),
    to_warehouse VARCHAR(100),
    movement_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Table: shipments (Αποστολές)
CREATE TABLE IF NOT EXISTS shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    courier_name VARCHAR(100),
    tracking_number VARCHAR(100),
    estimated_delivery DATE,
    actual_delivery DATE,
    status VARCHAR(50) DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Insert Sample Data: Suppliers
INSERT INTO suppliers (supplier_name, contact_person, email, phone, address, lead_time_days, rating) VALUES
('Acme Supplies Inc.', 'John Smith', 'john@acme.com', '+30210123456', '123 Main St, Athens', 5, 5),
('Global Trade Ltd.', 'Maria Garcia', 'maria@globaltrade.com', '+30210234567', '456 Business Ave, Thessaloniki', 7, 4),
('Premium Parts Co.', 'Peter Mueller', 'peter@premiumparts.com', '+30210345678', '789 Industrial Way, Patras', 3, 5);

-- Insert Sample Data: Products
INSERT INTO products (product_name, supplier_id, price, available_stock, reserved_stock, reorder_level) VALUES
('Product A - Electronics', 1, 45.99, 120, 20, 30),
('Product B - Hardware', 1, 12.50, 300, 50, 100),
('Product C - Components', 2, 8.75, 200, 40, 75),
('Product D - Materials', 3, 55.00, 50, 10, 25),
('Product E - Tools', 2, 29.99, 85, 15, 40);

-- Insert Sample Data: Customers
INSERT INTO customers (customer_name, email, phone, address, outstanding_balance) VALUES
('ABC Trading Company', 'info@abctrading.com', '+30210111111', '100 Market St, Athens', 5000.00),
('XYZ Retail Store', 'contact@xyzretail.com', '+30210222222', '200 Commercial Rd, Thessaloniki', 2500.00),
('Delta Distribution', 'sales@delta.com', '+30210333333', '300 Warehouse Ave, Patras', 0.00),
('Omega Solutions', 'support@omega.com', '+30210444444', '400 Tech Park, Athens', 1200.00);

-- Insert Sample Data: Orders
INSERT INTO orders (customer_id, order_date, status, total_amount, payment_method, tracking_number) VALUES
(1, '2026-05-20', 'Delivered', 2456.78, 'Credit Card', 'TRK001234567'),
(2, '2026-05-21', 'Shipped', 1890.50, 'Bank Transfer', 'TRK001234568'),
(3, '2026-05-22', 'Processing', 3456.00, 'Credit Card', 'TRK001234569'),
(4, '2026-05-23', 'Pending', 1234.75, 'Check', 'TRK001234570'),
(1, '2026-05-24', 'Approved', 2345.90, 'Credit Card', 'TRK001234571');

-- Insert Sample Data: Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 10, 45.99, 459.90),
(1, 2, 20, 12.50, 250.00),
(2, 3, 15, 8.75, 131.25),
(3, 4, 5, 55.00, 275.00),
(4, 5, 8, 29.99, 239.92),
(5, 1, 12, 45.99, 551.88);

-- Insert Sample Data: Warehouse Movements
INSERT INTO warehouse_movements (product_id, movement_type, quantity, from_warehouse, to_warehouse, notes) VALUES
(1, 'inbound', 50, 'Supplier', 'Main Warehouse', 'Received from Acme Supplies'),
(2, 'outbound', 30, 'Main Warehouse', 'Customer', 'Shipped to ABC Trading'),
(3, 'transfer', 25, 'Main Warehouse', 'Secondary Warehouse', 'Stock rebalancing'),
(4, 'inbound', 20, 'Supplier', 'Main Warehouse', 'Received from Premium Parts');

-- Insert Sample Data: Shipments
INSERT INTO shipments (order_id, courier_name, tracking_number, estimated_delivery, actual_delivery, status) VALUES
(1, 'DHL', 'TRK001234567', '2026-05-23', '2026-05-23', 'Delivered'),
(2, 'UPS', 'TRK001234568', '2026-05-25', NULL, 'Shipped'),
(3, 'FedEx', 'TRK001234569', '2026-05-26', NULL, 'Processing'),
(4, 'DHL', 'TRK001234570', '2026-05-27', NULL, 'Pending');

-- Create Indexes for Performance
CREATE INDEX idx_supplier ON products(supplier_id);
CREATE INDEX idx_customer ON orders(customer_id);
CREATE INDEX idx_order ON order_items(order_id);
CREATE INDEX idx_product ON order_items(product_id);
CREATE INDEX idx_product_movements ON warehouse_movements(product_id);
CREATE INDEX idx_order_shipments ON shipments(order_id);
CREATE INDEX idx_order_status ON orders(status);

-- View: Order Summary
CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    c.customer_name,
    COUNT(oi.item_id) as item_count,
    o.total_amount,
    o.status,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- View: Stock Status
CREATE VIEW stock_status AS
SELECT 
    p.product_id,
    p.product_name,
    s.supplier_name,
    p.available_stock,
    p.reserved_stock,
    p.damaged_stock,
    (p.available_stock - p.reserved_stock) as net_stock,
    p.reorder_level,
    CASE 
        WHEN (p.available_stock - p.reserved_stock) <= p.reorder_level THEN 'LOW'
        ELSE 'OK'
    END as stock_status
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id;

-- View: Pending Orders
CREATE VIEW pending_orders AS
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    o.total_amount,
    COUNT(oi.item_id) as items
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status IN ('Pending', 'Approved', 'Processing')
GROUP BY o.order_id
ORDER BY o.order_date;
