-- Assignment3 uz4684, default scehma cs431_movie_database
-- Q1
SELECT 
-- DISTINCT 
CONCAT(first_name, " ", last_name) AS "Full Name", 
	YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date) AS Age, 
    address AS Address, 
    contact_no AS "Contact Number"
FROM artists
ORDER BY Age DESC
LIMIT 5;

-- Q2
SELECT CONCAT(first_name, " ", last_name) AS "Actors in Star Wars"
FROM artists a JOIN movie_cast mc ON a.artist_id = mc.person_id
	JOIN movies m ON mc.movie_id = m.movie_id
WHERE m.title = 'Star Wars' AND a.Profession = 'Actor';

-- Q3
SELECT DISTINCT m.title AS "Lowest Rating Titles"
FROM movies m 
	JOIN movie_cast mc ON m.movie_id = mc.movie_id
    JOIN awards a ON a.person_id = mc.person_id AND a.category = 'Actor'
	JOIN movies_ratings mr ON mr.movie_id = m.movie_id
WHERE mr.number_of_stars = 
	(SELECT MIN(number_of_stars)
	FROM movies_ratings);


-- Q4
SELECT genre AS Genre, COUNT(*) AS "Number of Movies", YEAR(release_date) AS "Release Year" 
FROM movies
GROUP BY genre, YEAR(release_date);

-- Q5
SELECT title AS "Movies with 3 Awards"
FROM movies m JOIN awards a ON m.movie_id = a.movie_id 
GROUP BY m.title
HAVING COUNT(*) = 3;

-- Q6
SELECT title AS "Title", YEAR(release_date) AS "Year", Distributor
FROM movies m
WHERE m.movie_id IN (
	SELECT mr.movie_id
	FROM movies_ratings mr
	WHERE ISNULL(mr.number_of_stars) 
	)
ORDER BY YEAR(release_date);

-- Q7
SELECT DISTINCT title, category
FROM movies m JOIN awards a ON m.movie_id = a.movie_id
WHERE Distributor = 'Disney';

-- Q8
SELECT Profession AS "Professions in Music Industry"
FROM artists
GROUP BY Profession
HAVING Profession NOT REGEXP '^R';

