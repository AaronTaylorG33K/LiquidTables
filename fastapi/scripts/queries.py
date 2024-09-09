query = """
    SELECT 
        product.product_name AS product,
        customer.customer_name AS customer,
        salesperson.salesperson_name AS salesperson,
        SUM(invoice.amount) AS amount,
        CASE
            WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 1 THEN 0
            WHEN GROUPING(product.product_name) = 0 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 1 THEN 1
            WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 0 AND GROUPING(salesperson.salesperson_name) = 1 THEN 2
            WHEN GROUPING(product.product_name) = 1 AND GROUPING(customer.customer_name) = 1 AND GROUPING(salesperson.salesperson_name) = 0 THEN 3
            WHEN GROUPING(product.product_name) = 0 AND GROUPING(customer.customer_name) = 0 AND GROUPING(salesperson.salesperson_name) = 0 THEN 4
            WHEN GROUPING(product.product_name) = 0 AND GROUPING(customer.customer_name) = 0 AND GROUPING(salesperson.salesperson_name) = 1 THEN 5
            ELSE 6
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
        CUBE(product.product_name, customer.customer_name, salesperson.salesperson_name)
    ORDER BY 
        grouping_level,
        product.product_name, customer.customer_name, salesperson.salesperson_name
"""