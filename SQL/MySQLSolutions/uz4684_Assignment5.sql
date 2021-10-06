-- uz4684 Assignment 5

-- Q1
DROP VIEW IF EXISTS movies_legendary_technicians;
CREATE VIEW movies_legendary_technicians AS

-- 
SELECT DISTINCT m.title, CONCAT(first_name, " ", last_name) AS Technicians, YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date) AS Age
FROM  movies m
	JOIN movie_cast mc ON m.movie_id = mc.movie_id 
	JOIN artists a ON a.artist_id = mc.person_id 
--
WHERE YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date) > 40
ORDER BY Age;

-- Check Output of View
SELECT * FROM movies_legendary_technicians;

-- Q2
DROP PROCEDURE IF EXISTS must_watch_movies;
DELIMITER //
CREATE PROCEDURE must_watch_movies()
BEGIN
	DECLARE title_var VARCHAR(50);
    DECLARE dist_var VARCHAR(50);
    DECLARE year_var YEAR;
    DECLARE watch_movies VARCHAR(1000) DEFAULT "";
    DECLARE no_records INT DEFAULT FALSE;
    
	DECLARE cursor_var CURSOR FOR 
	SELECT title, Distributor, YEAR(release_date)
	FROM movies WHERE gross > 2.00
	ORDER BY title;

	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET no_records = TRUE;
        
	OPEN cursor_var;
    
    WHILE no_records=FALSE DO
		FETCH cursor_var INTO title_var, dist_var, year_var;
        SET watch_movies=CONCAT(watch_movies, 
        QUOTE(title_var), ',', QUOTE(dist_var), ',', QUOTE(year_var),"|");
    END WHILE;
    
	CLOSE cursor_var;
    
    SELECT watch_movies AS "Answer";
END//
DELIMITER ;

CALL must_watch_movies();





