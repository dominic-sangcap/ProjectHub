-- 1.
-- The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal 
  WHERE teamid LIKE 'Ger%';

-- 2.
-- From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.
-- 
-- Notice that the matchid column in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
-- 
-- Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game
Where id = 1012;

-- 3.
-- Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
where teamid = 'Ger';

-- 4.
-- Use the same JOIN as in the previous question.
-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
where player like 'Mario%';

-- 5.
-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid,coach, gtime
  FROM goal join eteam ON teamid=id
 WHERE gtime<=10;

-- 6.
-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

Select mdate, teamname
from game JOIN eteam on (team1 = eteam.id)
Where coach = 'Fernando Santos';

-- 7.
-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player 
from game join goal on matchid = id
where stadium = 'National Stadium, Warsaw';

-- 8.
-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.

SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' or team2='GER') and teamid <> 'GER';

-- 9.
-- Show teamname and the total number of goals scored.

SELECT teamname, Count(teamid)
  FROM eteam JOIN goal ON id=teamid
Group by teamname;

-- 10.
-- Show the stadium and the number of goals scored in each stadium.

SELECT stadium, Count(stadium)
  FROM game JOIN goal ON id=matchid
Group by stadium;

-- 11.
-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid,mdate, count(matchid)
  FROM game JOIN goal ON matchid = id 
  WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid, mdate;

-- 12.
-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid,mdate, count(teamid)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'GER' OR team2 = 'GER')
  and teamid = 'GER'
group by matchid, mdate;

-- 13.
-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.

SELECT mdate, 
	    team1, 
	    SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1, 
	    team2, 
	    SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 
  FROM game 
  left JOIN goal ON (id = matchid)
	GROUP BY id, mdate, matchid, team1, team2;
