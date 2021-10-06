-- Q1
SELECT c.category_name, COUNT(*) AS count, MAX(i.list_price) AS most_expensive
FROM categories c, instruments i
WHERE
	c.category_id = i.category_id
GROUP BY i.category_id
ORDER BY count DESC;

-- Q2
SELECT email_address, SUM(oi.item_price) * oi.quantity AS item_price_total, SUM(oi.discount_amount) * oi.quantity AS discount_amount_total
FROM musicians m, order_instruments oi, orders o
WHERE oi.order_id = o.order_id AND o.musician_id = m.musician_id
GROUP BY m.musician_id
ORDER BY item_price_total DESC;

-- Q3
SELECT m.email_address, COUNT(o.order_id) AS order_count, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
FROM  musicians m
	JOIN orders o ON m.musician_id = o.musician_id
    JOIN order_instruments oi ON o.order_id = oi.order_id 
GROUP BY m.email_address
HAVING order_count > 1
ORDER BY order_total DESC;

-- Q4
SELECT m.email_address, COUNT(o.order_id) AS order_count, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total
FROM  musicians m
	JOIN orders o ON m.musician_id = o.musician_id
    JOIN order_instruments oi ON o.order_id = oi.order_id 
WHERE oi.item_price > 400
GROUP BY m.email_address
HAVING order_count > 1 
ORDER BY order_total DESC;

-- Q5
SELECT i.instrument_name, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS instrument_total
FROM  instruments i
    JOIN order_instruments oi ON i.instrument_id  = oi.instrument_id 
GROUP BY i.instrument_name WITH ROLLUP;

-- Q6
SELECT m.email_address, COUNT(DISTINCT oi.instrument_id) AS number_of_instruments
FROM  musicians m
	JOIN orders o ON m.musician_id = o.musician_id
    JOIN order_instruments oi ON o.order_id = oi.order_id 
GROUP BY m.email_address
HAVING COUNT(DISTINCT oi.instrument_id) > 1
ORDER BY m.email_address;
 
-- Q7
SELECT 
IF(GROUPING(c.category_name), 'Grand Total', c.category_name) AS category_name, 
IF(GROUPING(i.instrument_name), 'Category Total', i.instrument_name) AS instrument_name,
SUM(oi.quantity) AS qty_purchased 
FROM categories c
	JOIN instruments i ON c.category_id = i.category_id
    JOIN order_instruments oi ON i.instrument_id = oi.instrument_id
GROUP BY c.category_name, i.instrument_name WITH ROLLUP;

-- Q8	
SELECT oi.order_id, 
	(oi.item_price - oi.discount_amount)*quantity
		AS item_amount,
	SUM((oi.item_price - oi.discount_amount)*quantity) 
		OVER(PARTITION BY oi.order_id) AS order_amount
FROM order_instruments oi;

-- Q9
SELECT oi.order_id, 
	(oi.item_price - oi.discount_amount)*quantity
		AS item_amount,
	SUM((oi.item_price - oi.discount_amount)*quantity) 
		OVER(my_window ORDER BY oi.item_price) AS order_amount,
	ROUND(AVG((oi.item_price - oi.discount_amount)*quantity)
		OVER(my_window), 2) AS avg_order_amount
FROM order_instruments oi
WINDOW my_window AS (PARTITION BY oi.order_id);

-- Q10
SELECT o.musician_id, o.order_date, 
	(oi.item_price - oi.discount_amount)*quantity AS item_total, 
	SUM((oi.item_price - oi.discount_amount)*quantity) 
		OVER(PARTITION BY o.musician_id) AS musician_total,
    SUM((oi.item_price - oi.discount_amount)*quantity) 
		OVER(PARTITION BY o.musician_id ORDER BY o.order_date
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)  AS musician_total_by_date
FROM orders o JOIN order_instruments oi ON o.order_id = oi.order_id;




