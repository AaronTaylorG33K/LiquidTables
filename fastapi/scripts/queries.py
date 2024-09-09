query = """
        SELECT 
            product.product_name AS product,
            produce.product_price AS price,
            customer.customer_name AS customer,
            salesperson.salesperson_name AS salesperson,
            invoice.invoice_id AS invoice_id,
            customer.customer_id AS customer_id,
            salesperson.salesperson_id AS salesperson_id,
            invoice.product_quantity AS quantity,
            SUM(product.product_price * invoice.product_quantity) AS amount,
            CASE
                WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 1 THEN 0  -- Grand total
                WHEN GROUPING(product.product_name) = 0 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 1 THEN 1  -- Product only
                WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 0 AND GROUPING(salesperson.salesperson_name) = 1 THEN 2  -- Customer only
                WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 0 THEN 3  -- Salesperson only
                WHEN GROUPING(product.product_name) = 0 AND GROUPING(customer.customer_name) = 0 AND GROUPING(salesperson.salesperson_name) = 0 THEN 4  -- Full detailed grouping
                ELSE 5
            END AS grouping_level
        FROM 
            invoice
        JOIN 
            product ON invoice.product_id = product.product_id
        JOIN 
            customer ON invoice.customer_id = customer.customer_id
        JOIN 
            salesperson ON invoice.salesperson_id = salesperson.salesperson_id
        WHERE 
            invoice.invoice_date >= '2023-01-01'
        GROUP BY 
            GROUPING SETS (
                (),  -- Grand total
                (product.product_name),  -- Product only
                (customer.customer_name, customer.customer_id),  -- Customer only
                (salesperson.salesperson_name, salesperson.salesperson_id),  -- Salesperson only
                (product.product_name, product.product_price, customer.customer_name, salesperson.salesperson_name, 
                invoice.invoice_id, customer.customer_id, salesperson.salesperson_id, invoice.product_quantity, amount)  -- Full grouping
            )
        ORDER BY 
            grouping_level,
            product.product_name, customer.customer_name, salesperson.salesperson_name, invoice.invoice_id;
        """