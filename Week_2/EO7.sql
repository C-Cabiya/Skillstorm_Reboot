-- EO7 Assignment -- 

USE retail_db

SELECT DISTINCT product_category_id, product_count
FROM(SELECT product_category_id, SUM (1) product_count
FROM products
GROUP BY product_category_id) AS counts
WHERE product_count >5

SELECT *
FROM orders
WHERE order_customer_id IN( SELECT order_customer_id
	FROM orders 
	GROUP BY orders.order_customer_id
	HAVING SUM(1) > 10)
ORDER BY order_id

SELECT AVG(product_price) [Average Price]
FROM products
WHERE product_id IN (SELECT order_item_product_id
	FROM order_items
	WHERE order_item_order_id IN (
		SELECT order_id
		FROM orders
		WHERE FORMAT(order_date,'yyyy-MM') = '2013-10'))

SELECT product_name [October Products]
FROM products
WHERE product_id IN (SELECT order_item_product_id
	FROM order_items
	WHERE order_item_order_id IN (
		SELECT order_id
		FROM orders
		WHERE FORMAT(order_date,'yyyy-MM') = '2013-10'))

SELECT order_item_order_id
FROM order_items
WHERE order_item_subtotal>(SELECT CAST(AVG(order_item_subtotal) AS DECIMAL(18,2)) average_order
						   FROM order_items)

