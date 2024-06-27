-- EO 3 Assignment -- 

USE retail_db

SELECT TOP 10 * from categories;

BEGIN TRAN e03;

-- Get order count per customer for the month of 2014 January. -- 
SELECT customer_id, 
	customer_fname customer_first_name,
	customer_lname customer_last_name,
	COUNT(1) [customer_order_count]
FROM orders o
JOIN customers c ON o.order_customer_id = c.customer_id
WHERE format(order_date, 'yyyy-MM') LIKE '2014-01%'
GROUP BY customer_id, customer_fname, customer_lname
ORDER BY customer_order_count DESC, customer_id;


-- Get the customer details who have not placed any order for the month of 2014 January. --

SELECT * 
FROM customers
WHERE customer_id IN(
	SELECT DISTINCT order_customer_id 
	FROM orders 
	WHERE format(order_date, 'yyyy-MM') NOT LIKE '2014-01'
	);

-- Get the revenue generated by each customer for the month of 2014 January for COMPLETED and CLOSED orders --

SELECT customer_id, customer_fname customer_first_name, customer_lname customer_last_name, order_sum 
	FROM customers INNER JOIN
	(
	SELECT order_customer_id, SUM(order_item_subtotal) [order_sum]
	FROM orders JOIN order_items ON orders.order_id = order_items.order_item_order_id
	GROUP BY order_customer_id, order_date, order_status
	HAVING format(order_date,'yyyy-MM') LIKE  '2014-01' AND order_status LIKE 'C%'
	) AS x
	ON x.order_customer_id=customers.customer_id
	ORDER BY order_sum DESC, customer_id;

-- Revenue Per Category -- 

SELECT category_id, category_department_id, category_name, cast(SUM(order_item_subtotal) AS DECIMAL(10,2)) FROM products p 
JOIN categories c ON p.product_category_id = c.category_id 
JOIN order_items oi ON p.product_id = oi.order_item_product_id
GROUP BY category_id,category_department_id,category_name;

-- Product Count Per Department --

SELECT department_id, department_name, SUM(DISTINCT product_id) product_count
FROM products p
JOIN categories c ON p.product_category_id = c.category_id
JOIN departments d ON d.department_id = c.category_department_id
GROUP BY department_id, department_name
ORDER BY department_id;