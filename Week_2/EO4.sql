-- EO4 Assignment -- 

SELECT MAX(category_id)
FROM categories

SELECT MAX(customer_id)
FROM customers

SELECT MAX(department_id)
FROM departments

SELECT MAX(order_item_id)
FROM order_items

SELECT MAX(order_id)
FROM orders

SELECT MAX(product_id)
from products

-- Foreign Keys -- 
-- No updates will be made if there are no violations 
-- Both exersize 3 and 2 can be accomplished by running the following queries
--	as they both check foreign key constraints and update if necessary

UPDATE orders
SET orders.order_customer_id = -1
WHERE order_customer_id IN(
	SELECT o.order_customer_id
	FROM orders o LEFT JOIN customers c ON c.customer_id = o.order_customer_id
	WHERE c.customer_id IS NULL
);

UPDATE order_items
SET order_item_order_id = -1
WHERE order_item_order_id IN(
	SELECT oi.order_item_order_id
	FROM order_items oi LEFT JOIN orders o ON oi.order_item_order_id = o.order_id
	WHERE oi.order_item_order_id IS NULL
);

UPDATE products
SET product_category_id = -1 
WHERE product_category_id IN  (
	SELECT oi.order_item_product_id, p.product_id
	FROM order_items oi LEFT JOIN products p ON oi.order_item_product_id = p.product_id 
	WHERE p.product_id IS NULL)
 
UPDATE products
SET product_category_id = -1 
WHERE product_category_id IN  (
	SELECT DISTINCT p.product_category_id
	FROM products p LEFT JOIN categories c ON p.product_category_id = c.category_id 
	WHERE c.category_id IS NULL)

UPDATE categories
SET category_department_id = -1 
WHERE category_department_id IN  (
	SELECT c.category_department_id
	FROM categories c LEFT JOIN departments d ON c.category_department_id = d.department_id
	WHERE d.department_id = NULL)