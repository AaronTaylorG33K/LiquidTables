-- Seed Initial Data

-- Seed Product Data
INSERT INTO product (product_id, product_name, product_price) VALUES (1, 'Jack Daniels', 50.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (2, 'Hennessy', 75.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (3, 'Jameson', 45.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (4, 'Johnnie Walker', 150.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (5, 'Glenfiddich', 60.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (6, 'Bombay Sapphire', 55.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (7, 'Patrón', 80.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (8, 'Absolut', 40.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (9, 'Don Julio', 85.00);
INSERT INTO product (product_id, product_name, product_price) VALUES (10, 'Belvedere', 70.00);

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
VALUES (1, '2024-09-01', 1, 1, 1, 7, 350.00); -- Jack Daniel: 50.00 * 7
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (2, '2024-09-02', 2, 2, 2, 4, 300.00); -- Hennessy: 75.00 * 4
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (3, '2024-09-03', 3, 3, 3, 6, 270.00); -- Jameson: 45.00 * 6
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (4, '2024-09-04', 4, 4, 4, 9, 1350.00); -- Johnnie Walker: 150.00 * 9
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (5, '2024-09-05', 5, 5, 5, 3, 180.00); -- Glenfiddich: 60.00 * 3
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (6, '2024-09-06', 6, 6, 6, 8, 440.00); -- Bombay Sapphire: 55.00 * 8
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (7, '2024-09-07', 7, 7, 7, 5, 400.00); -- Patrón: 80.00 * 5
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (8, '2024-09-08', 8, 8, 8, 10, 400.00); -- Absolut: 40.00 * 10
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (9, '2024-09-09', 9, 9, 9, 2, 170.00); -- Don Julio: 85.00 * 2
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (10, '2024-09-10', 10, 10, 10, 1, 70.00); -- Belvedere: 70.00 * 1
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (11, '2024-09-11', 1, 1, 2, 3, 225.00); -- Hennessy: 75.00 * 3
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (12, '2024-09-12', 2, 2, 3, 7, 315.00); -- Jameson: 45.00 * 7
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (13, '2024-09-13', 3, 1, 4, 9, 1350.00); -- Johnnie Walker: 150.00 * 9
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (14, '2024-09-14', 4, 2, 5, 4, 240.00); -- Glenfiddich: 60.00 * 4
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (15, '2024-09-15', 5, 3, 6, 6, 330.00); -- Bombay Sapphire: 55.00 * 6
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (16, '2024-09-16', 6, 4, 7, 2, 160.00); -- Patrón: 80.00 * 2
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (17, '2024-09-17', 7, 5, 8, 1, 40.00); -- Absolut: 40.00 * 1
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (18, '2024-09-18', 8, 6, 9, 8, 680.00); -- Don Julio: 85.00 * 8
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (19, '2024-09-19', 9, 7, 10, 7, 490.00); -- Belvedere: 70.00 * 7
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (20, '2024-09-20', 10, 8, 1, 5, 250.00); -- Jack Daniel: 50.00 * 5
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (21, '2024-09-21', 1, 9, 3, 2, 90.00); -- Jameson: 45.00 * 2
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (22, '2024-09-22', 2, 10, 4, 6, 900.00); -- Johnnie Walker: 150.00 * 6
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (23, '2024-09-23', 3, 1, 5, 9, 540.00); -- Glenfiddich: 60.00 * 9
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (24, '2024-09-24', 4, 2, 6, 10, 550.00); -- Bombay Sapphire: 55.00 * 10
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (25, '2024-09-25', 5, 3, 7, 1, 80.00); -- Patrón: 80.00 * 1
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (26, '2024-09-26', 6, 4, 8, 3, 120.00); -- Absolut: 40.00 * 3
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (27, '2024-09-27', 7, 5, 9, 8, 680.00); -- Don Julio: 85.00 * 8
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (28, '2024-09-28', 8, 6, 10, 4, 280.00); -- Belvedere: 70.00 * 4
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (29, '2024-09-29', 9, 7, 1, 7, 350.00); -- Jack Daniel: 50.00 * 7
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (30, '2024-09-30', 10, 8, 2, 6, 450.00); -- Hennessy: 75.00 * 6
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (31, '2024-10-01', 1, 1, 3, 10, 450.00); -- Jameson: 45.00 * 10
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (32, '2024-10-02', 2, 2, 4, 5, 750.00); -- Johnnie Walker: 150.00 * 5
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (33, '2024-10-03', 3, 1, 5, 8, 480.00); -- Glenfiddich: 60.00 * 8
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (34, '2024-10-04', 1, 2, 6, 7, 385.00); -- Bombay Sapphire: 55.00 * 7
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (35, '2024-10-05', 2, 1, 7, 6, 480.00); -- Patrón: 80.00 * 6
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (36, '2024-10-06', 3, 2, 8, 9, 360.00); -- Absolut: 40.00 * 9
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (37, '2024-10-07', 1, 1, 9, 4, 340.00); -- Don Julio: 85.00 * 4
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (38, '2024-10-08', 2, 2, 10, 3, 210.00); -- Belvedere: 70.00 * 3
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (39, '2024-10-09', 3, 1, 1, 5, 250.00); -- Jack Daniel: 50.00 * 5
INSERT INTO invoice (invoice_id, invoice_date, customer_id, salesperson_id, product_id, product_quantity, amount) 
VALUES (40, '2024-10-10', 1, 2, 2, 8, 600.00); -- Hennessy: 75.00 * 8