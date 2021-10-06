-- 1.
-- Show the total population of the world.

SELECT SUM(population)
FROM world;

-- 2.
-- List all the continents - just once each.

Select DISTINCT continent 
from world;

-- 3.
-- Give the total GDP of Africa

SELECT SUM(gdp)
from world
where continent = 'Africa';

-- 4.
-- How many countries have an area of at least 1000000

SELECT COUNT(name)
from world 
where area >= 1000000;

-- 5.
-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')

SELECT SUM(population)
from world
where name = 'Estonia'
or name = 'Latvia'
or name = 'Lithuania';

-- 6.
-- For each continent show the continent and number of countries.

SELECT continent, COUNT(name)
from world
GROUP By continent;

-- 7.
-- For each continent show the continent and number of countries with populations of at least 10 million.

SELECT continent, COUNT(name)
from world
where population >= 10000000
GROUP By continent;

-- 8.
-- List the continents that have a total population of at least 100 million.

SELECT continent
from world
GROUP By continent
HAVING SUM(population) >= 100000000;