-- Q1
SELECT instrument_name, list_price, date_added
FROM instruments
WHERE list_price > 500 and list_price < 2000
ORDER BY date_added DESC;


-- Q2
SELECT item_id, item_price, discount_amount, quantity, 
item_price * quantity AS price_total, 
discount_amount * quantity AS discount_total, 
(item_price - discount_amount) * quantity AS item_total 
FROM order_instruments
HAVING item_total > 500 
ORDER BY item_total DESC;


-- Q3
SELECT NOW() AS Date, 
DATE_FORMAT(NOW(), '%e-%b-%Y') AS 'DD-Mon-YYYY',
DATE_FORMAT(NOW(), '%m/%y') AS 'mm/yyyy',
DATE_FORMAT(NOW(), '%d/%m/%y') AS 'dd/mm/yyyy',
DATE_FORMAT(NOW(), '%D %M %Y') AS 'doth month yyyy';

-- Q4
SELECT first_name, last_name, line1, city, state, zip_code -- , email_address
FROM addresses a JOIN musicians m
	ON a.musician_id = m.musician_id
    -- WHERE m.email_address = 'david.goldstein@hotmail.com' 
ORDER BY first_name;

-- Q5
SELECT  first_name , last_name, line1, city, state, zip_code
FROM addresses a JOIN musicians m
	ON a.address_id = m.billing_address_id -- AND a.musician_id = m.musician_id
ORDER BY first_name;

-- Q6
SELECT   last_name, first_name, order_date, instrument_name, 
item_price, discount_amount, quantity
FROM  musicians m
	JOIN orders o ON m.musician_id = o.musician_id
	JOIN order_instruments oi ON o.order_id = oi.order_id 
	JOIN instruments ins ON  oi.instrument_id = ins.instrument_id AND
		oi.item_price AND
        oi.discount_amount AND
        oi.quantity
ORDER BY  last_name, order_date, instrument_name;

-- Q6 second method?
/*
SELECT   last_name, first_name, order_date, instrument_name, 
item_price, discount_amount, quantity
FROM  musicians m, orders o, order_instruments oi, instruments ins
WHERE m.musician_id = o.musician_id
	AND o.order_id = oi.order_id 
	AND oi.instrument_id = ins.instrument_id
	AND oi.item_price 
    AND oi.discount_amount 
	AND oi.quantity
ORDER BY  last_name, order_date, instrument_name;
*/
-- Q7
SELECT /*DISTINCT*/ i1.instrument_name, i1.list_price
FROM instruments i1 JOIN instruments i2
	ON i1.instrument_id <> i2.instrument_id 
    AND i1.list_price = i2.list_price
ORDER BY instrument_name;

-- Q8
	SELECT 'SHIPPED' AS ship_status, order_id, order_date
    FROM orders 
    WHERE ship_date IS NOT NULL 
UNION
	SELECT 'NOT SHIPPED' AS ship_status, order_id, order_date
    FROM orders 
    WHERE ship_date IS NULL
ORDER BY order_date;


