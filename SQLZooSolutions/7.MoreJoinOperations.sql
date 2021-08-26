1.
List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962;

2.
Give year of 'Citizen Kane'.

SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane';

3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

Select id, title, yr
From movie
Where title like 'Star Trek%'
order by yr;

4.
What id number does the actor 'Glenn Close' have?

Select id
From actor
Where name = 'Glenn Close';

5.
What is the id of the film 'Casablanca'

Select id 
From movie
Where title =  'Casablanca';

6.
Obtain the cast list for 'Casablanca'.
Use movieid=11768, (or whatever value you got from the previous question)

SELECT name
FROM actor 
JOIN casting 
ON casting.actorid = actor.id
WHERE casting.movieid = 11768;

7.
Obtain the cast list for the film 'Alien'

SELECT name
FROM actor 
JOIN casting 
ON casting.actorid = actor.id
JOIN movie 
ON movie.id = casting.movieid
WHERE title = 'Alien';

8.
List the films in which 'Harrison Ford' has appeared

Select title
from movie
join casting on movie.id = casting.movieid
join actor on actor.id = casting.actorid
Where actor.name = 'Harrison Ford';

9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

Select title
from movie
join casting on movie.id = casting.movieid
join actor on actor.id = casting.actorid
Where actor.name = 'Harrison Ford'
and ord <> 1;

10.
List the films together with the leading star for all 1962 films.

Select title, name
from movie
join casting on movie.id = casting.movieid
join actor on actor.id = casting.actorid
Where ord = 1 and yr = 1962;

11.
Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT movie.yr, COUNT(movie.title) 
FROM movie
JOIN casting ON movie.id = casting.movieid 
JOIN actor ON actor.id = casting.actorid 
WHERE actor.name = 'Rock Hudson' 
GROUP BY movie.yr 
HAVING COUNT(movie.title) > 2;

12.
List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name FROM movie
JOIN casting  ON movie.id = movieid
JOIN actor ON actor.id =actorid
WHERE ord=1 AND movieid IN
(SELECT movieid FROM casting 
JOIN actor ON actor.id=actorid
WHERE name='Julie Andrews');

-- 13.
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT name 
FROM actor 
JOIN casting ON actor.id = actorid 
WHERE ord = 1 
GROUP BY name
HAVING COUNT(movieid) >= 15;

14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

Select title, count(actorid)
from movie
join casting on id = movieid
where yr = 1978
group by title
Order by count(actorid) DESC, title;

15.
List all the people who have worked with 'Art Garfunkel'.

Select name 
from actor
join casting on actor.id = actorid
where movieid in
(SELECT id FROM movie WHERE title IN
    (SELECT title FROM movie JOIN casting ON movie.id = movieid WHERE actorid IN
        (SELECT id FROM actor WHERE name = 'Art Garfunkel')))
    AND name != 'Art Garfunkel';