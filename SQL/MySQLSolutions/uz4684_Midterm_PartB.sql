-- using cs431_midterm_database as default schema

-- Q1
SELECT customer_last_name, customer_first_name, customer_zip -- , customer_state
FROM customers
WHERE customer_state = 'IL'
ORDER BY customer_last_name DESC;

-- Q2
SELECT CONCAT(rep_last_name, ", ", rep_first_name) AS "Representative Full Name"
FROM sales_reps
WHERE rep_last_name REGEXP '^Mar';

-- Q3
SELECT sr.rep_last_name, st.sales_year, st.sales_total
FROM sales_reps sr JOIN sales_totals st
	ON sr.rep_id = st.rep_id;

-- Q4
SELECT rep_id AS "Representative ID", MAX(sales_total) AS "Highest sales of representative"
FROM sales_totals
GROUP BY rep_id
HAVING MAX(sales_total) > 900000;

-- Q5
-- not sure if I was supposed to make a copy of the table, or just update the existing one
-- i chose to only update the existing table
/*
-- return table back to normal
UPDATE sales_totals st
SET sales_total = 655786.9200
WHERE st.rep_id = 4 AND st.sales_year = "2017";
*/

UPDATE sales_totals st
SET sales_total = 2345.56
WHERE st.rep_id = 4 AND st.sales_year = "2017";
-- view updated table
-- SELECT * FROM sales_totals;

-- Q6
SELECT rep_id AS "Representative ID", sales_year AS "Year of Sales", sales_total AS "Total sales"
FROM sales_totals
WHERE sales_total = (SELECT MIN(sales_total) FROM sales_totals);

