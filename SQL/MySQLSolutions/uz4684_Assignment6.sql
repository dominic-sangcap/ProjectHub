-- uz4684
-- Assignment 6

-- Q1
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    START TRANSACTION;
    DELETE FROM addresses
		WHERE musician_id = 8;
	IF sql_error = FALSE THEN
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
    
    START TRANSACTION;
    DELETE FROM musicians
		WHERE musician_id = 8;
	IF sql_error = FALSE THEN
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
END//
DELIMITER ;
CALL test();

-- Q2
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test()
BEGIN
	DECLARE order_id INT;
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
	
    START TRANSACTION;
    INSERT INTO orders
    (order_id, musician_id, order_date, ship_amount, tax_amount, ship_date, ship_address_id,
    card_type, card_number, card_expires, billing_address_id)
    VALUES(DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4, 
    'American Express', '3782246310005', '04/2016', 4);
    
    SELECT LAST_INSERT_ID()
    INTO order_id;
    
    INSERT INTO order_instruments
    (item_id, order_id, instrument_id, item_price, discount_amount, quantity)
    VALUES(DEFAULT, order_id, 6, '415.00', '161.85', 1);
    
    INSERT INTO order_instruments
    (item_id, order_id, instrument_id, item_price, discount_amount, quantity)
	 VALUES(DEFAULT, order_id, 1, '699.00', '209.70', 1); 

	IF sql_error = FALSE THEN
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
END//
DELIMITER ;
CALL test();

-- Q3
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test()
BEGIN
	DECLARE sql_error TINYINT DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
        
    START TRANSACTION;
    SELECT * FROM musicians 
		WHERE musician_id = 6 FOR UPDATE;
    UPDATE orders
		SET musician_id = 3
		WHERE musician_id = 6;
    UPDATE addresses
		SET musician_id = 3
		WHERE musician_id = 6;
    
	IF sql_error = FALSE THEN
		COMMIT;
	ELSE 
		ROLLBACK;
	END IF;
END//
DELIMITER ;
CALL test();


