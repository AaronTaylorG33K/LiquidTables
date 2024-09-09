
-- Drop the existing tables if they exist
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS salesperson;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS invoice;

-- Check if the 'customer' table exists, and if not, create it
CREATE TABLE IF NOT EXISTS customer (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255)
);

-- Check if the 'salesperson' table exists, and if not, create it
CREATE TABLE IF NOT EXISTS salesperson (
    salesperson_id INTEGER PRIMARY KEY,
    salesperson_name VARCHAR(255),
    salesperson_email VARCHAR(255)
);

-- Check if the 'product' table exists, and if not, create it
CREATE TABLE IF NOT EXISTS product (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(255),
    product_price DECIMAL(10, 2)
);

-- Check if the 'invoice' table exists, and if not, create it
CREATE TABLE IF NOT EXISTS invoice (
    invoice_id INTEGER PRIMARY KEY,
    invoice_date DATE,
    customer_id INTEGER,
    salesperson_id INTEGER,
    product_id INTEGER,
    product_quantity INTEGER,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);