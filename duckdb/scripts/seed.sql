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
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (1, '2024-09-01', 1, 1, 1, 7, 50.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (2, '2024-09-02', 2, 2, 2, 4, 75.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (3, '2024-09-03', 3, 3, 3, 6, 45.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (4, '2024-09-04', 4, 4, 4, 9, 150.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (5, '2024-09-05', 5, 5, 5, 3, 60.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (6, '2024-09-06', 6, 6, 6, 8, 55.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (7, '2024-09-07', 7, 7, 7, 5, 80.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (8, '2024-09-08', 8, 8, 8, 10, 40.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (9, '2024-09-09', 9, 9, 9, 2, 85.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (10, '2024-09-10', 10, 10, 10, 1, 70.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (11, '2024-09-11', 1, 2, 2, 3, 75.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (12, '2024-09-12', 2, 3, 3, 7, 45.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (13, '2024-09-13', 3, 4, 4, 9, 150.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (14, '2024-09-14', 4, 5, 5, 4, 60.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (15, '2024-09-15', 5, 6, 6, 6, 55.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (16, '2024-09-16', 6, 7, 7, 2, 80.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (17, '2024-09-17', 7, 8, 8, 1, 40.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (18, '2024-09-18', 8, 9, 9, 8, 85.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (19, '2024-09-19', 9, 10, 10, 7, 70.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (20, '2024-09-20', 10, 1, 1, 5, 50.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (21, '2024-09-21', 1, 3, 3, 2, 45.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (22, '2024-09-22', 2, 4, 4, 6, 150.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (23, '2024-09-23', 3, 5, 5, 9, 60.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (24, '2024-09-24', 4, 6, 6, 10, 55.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (25, '2024-09-25', 5, 7, 7, 1, 80.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (26, '2024-09-26', 6, 8, 8, 3, 40.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (27, '2024-09-27', 7, 9, 9, 8, 85.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (28, '2024-09-28', 8, 10, 10, 4, 70.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (29, '2024-09-29', 9, 1, 1, 7, 50.00);
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (30, '2024-09-30', 10, 2, 2, 6, 75.00);
