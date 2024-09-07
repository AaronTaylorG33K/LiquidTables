-- Seed Initial Data

-- Seed Product Data
INSERT INTO product (product_id, product_name, product_price) VALUES (1, 'Jack Daniel Old No. 7 Tennessee Whiskey', 50.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (2, 'Hennessy V.S Cognac', 75.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (3, 'Jameson Irish Whiskey', 45.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (4, 'Johnnie Walker Blue Label', 150.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (5, 'Glenfiddich 12 Year Old Single Malt Scotch', 60.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (6, 'Bombay Sapphire Gin', 55.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (7, 'Patrón Silver Tequila', 80.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (8, 'Absolut Vodka', 40.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (9, 'Don Julio Blanco Tequila', 85.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (10, 'Belvedere Vodka', 70.00);

-- Seed Customer Data
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (1, 'Alice Johnson', 'alice.johnson@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (2, 'Bob Smith', 'bob.smith@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (3, 'Charlie Brown', 'charlie.brown@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (4, 'David Wilson', 'david.wilson@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (5, 'Eva Davis', 'eva.davis@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (6, 'Frank Miller', 'frank.miller@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (7, 'Grace Lee', 'grace.lee@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (8, 'Hank Garcia', 'hank.garcia@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (9, 'Ivy Martinez', 'ivy.martinez@example.com');
INSERT INTO customer (customer_id, customer_name, customer_email) VALUES (10, 'Jake Anderson', 'jake.anderson@example.com');

-- Seed Salesperson Data
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (1, 'Sarah Taylor', 'sarah.taylor@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (2, 'Tom Brown', 'tom.brown@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (3, 'Jessica Lee', 'jessica.lee@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (4, 'Michael Clark', 'michael.clark@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (5, 'Laura Scott', 'laura.scott@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (6, 'Daniel Harris', 'daniel.harris@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (7, 'Olivia Lewis', 'olivia.lewis@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (8, 'James Young', 'james.young@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (9, 'Sophia King', 'sophia.king@example.com');
INSERT INTO salesperson (salesperson_id, salesperson_name, salesperson_email) VALUES (10, 'Liam Wright', 'liam.wright@example.com');

-- Seed Invoice Data
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (1, '2024-09-01', 1, 1, 1, 50.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (2, '2024-09-02', 2, 2, 2, 75.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (3, '2024-09-03', 3, 3, 3, 45.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (4, '2024-09-04', 4, 4, 4, 150.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (5, '2024-09-05', 5, 5, 5, 60.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (6, '2024-09-06', 6, 6, 6, 55.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (7, '2024-09-07', 7, 7, 7, 80.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (8, '2024-09-08', 8, 8, 8, 40.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (9, '2024-09-09', 9, 9, 9, 85.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, amount) VALUES (10, '2024-09-10', 10, 10, 10, 70.00);
