/* 3 - Correlated Queries, Nested Queries, and Common Table Expressions */
/* Exercises */

/* Correlated subqueries */
SELECT 
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE 
	(home_goal + away_goal) > 
        (SELECT AVG((sub.home_goal + sub.away_goal) * 3)
         FROM match AS sub
         WHERE main.country_id = sub.country_id);
         
SELECT 
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE 
	(SELECT MAX(sub.home_goal + sub.away_goal)
         FROM match AS sub
         WHERE main.country_id = sub.country_id
               AND main.season = sub.season);

/* Nested subqueries */
SELECT 
	season,
    MAX(home_goal + away_goal) AS max_goals,
    (SELECT MAX(home_goal + away_goal) FROM match) AS overall_max_goals,
    (SELECT MAX(home_goal + away_goal) 
        FROM match
        WHERE id IN (
              SELECT id FROM match WHERE EXTRACT(MONTH FROM date) = 07)) AS july_max_goals
FROM match
GROUP BY season;

SELECT
	country_id,
    season,
	id
FROM match
WHERE home_goal >= 5 OR away_goal >= 5;

SELECT
    country_id,
    season,
    COUNT(id) AS matches
FROM (
	SELECT
    	country_id,
    	season,
    	id
	FROM match
	WHERE home_goal >= 5 OR away_goal >= 5) 
    AS subquery
GROUP BY country_id, season;

SELECT
	c.name AS country,
    AVG(outer_s.matches) AS avg_seasonal_high_scores
FROM country AS c
LEFT JOIN (
  SELECT country_id, season,
         COUNT(id) AS matches
  FROM (
    SELECT country_id, season, id
	FROM match
	WHERE home_goal >= 5 OR away_goal >= 5) AS inner_s
  GROUP BY country_id, season) AS outer_s
ON c.id = outer_s.country_id
GROUP BY country; 

/* Common Table Expressions */
WITH match_list AS (
    SELECT 
  		country_id, 
  		id
    FROM match
    WHERE (home_goal + away_goal) >= 10)
SELECT
    l.name AS league,
    COUNT(match_list.id) AS matches
FROM league AS l
LEFT JOIN match_list 
ON l.id = match_list.country_id
GROUP BY l.name;

WITH match_list AS (
  SELECT 
  		l.name AS league, 
     	m.date, 
  		m.home_goal, 
  		m.away_goal,
       (m.home_goal + m.away_goal) AS total_goals
    FROM match AS m
    LEFT JOIN league as l ON m.country_id = l.id)
SELECT league, date, home_goal, away_goal
FROM match_list
WHERE total_goals >= 10;

WITH match_list AS (
    SELECT 
  		country_id, 
  	   (home_goal + away_goal) AS goals
    FROM match
    WHERE id IN (
       SELECT id
       FROM match
       WHERE season = '2013/2014' AND EXTRACT(MONTH FROM date) = 08))
SELECT
	l.name,
    AVG(match_list.goals)
FROM league AS l
LEFT JOIN match_list ON l.id = match_list.country_id
GROUP BY l.name;

/* Deciding on techniques to use */
SELECT 
	m.id, 
    t.team_long_name AS hometeam
FROM match AS m
LEFT JOIN team as t
ON m.hometeam_id = team_api_id;

SELECT
	m.date,
    hometeam,
    awayteam,
    m.home_goal,
    m.away_goal
FROM match AS m
LEFT JOIN (
  SELECT match.id, team.team_long_name AS hometeam
  FROM match
  LEFT JOIN team
  ON match.hometeam_id = team.team_api_id) AS home
ON home.id = m.id
LEFT JOIN (
  SELECT match.id, team.team_long_name AS awayteam
  FROM match
  LEFT JOIN team
  ON match.awayteam_id = team.team_api_id) AS away
ON away.id = m.id;

SELECT
    m.date,
   (SELECT team_long_name
    FROM team AS t
    WHERE t.team_api_id = m.hometeam_id) AS hometeam
FROM match AS m;

SELECT
    m.date,
   (SELECT team_long_name
    FROM team AS t
    WHERE t.team_api_id = m.hometeam_id) AS hometeam,
    (SELECT team_long_name
    FROM team AS t
    WHERE t.team_api_id = m.awayteam_id) AS awayteam,
    m.home_goal,
    m.away_goal
FROM match AS m;

SELECT 
	m.id, 
    t.team_long_name AS hometeam
FROM match AS m
LEFT JOIN team AS t 
ON m.hometeam_id = t.team_api_id;

WITH home AS (
  SELECT m.id, t.team_long_name AS hometeam
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.hometeam_id = t.team_api_id)
SELECT *
FROM home;

WITH home AS (
  SELECT m.id, m.date, 
  		 t.team_long_name AS hometeam, m.home_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.hometeam_id = t.team_api_id),
away AS (
  SELECT m.id, m.date, 
  		 t.team_long_name AS awayteam, m.away_goal
  FROM match AS m
  LEFT JOIN team AS t 
  ON m.awayteam_id = t.team_api_id)
SELECT 
	home.date,
    home.hometeam,
    away.awayteam,
    home.home_goal,
    away.away_goal
FROM home
INNER JOIN away
ON home.id = away.id;

