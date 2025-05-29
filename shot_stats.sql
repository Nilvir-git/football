USE football;

SELECT *
from shots;

SELECT *
from appearances;

SELECT COUNT(*)
from appearances;

SELECT *
from games;

SELECT *
from players;

## APPEARANCES IS THE KEY TO CALCULATE PLAYER STATS, by game ID, and player ID we can know the team and the season..., we have leagueID here. and we can extract key stats goals, goal/shots, assists
#we don't need shots unless we want to include shotType and or shotResult (this one already included in appearances).

## we should join appearances with players and 

#THIS SHOW TOTAL GOALS & ASSISTS BY PLAYER AND GOAL CONVERSION RATE

SELECT 
	a.playerID, 
    p.name, 
    SUM(a.goals) AS goals_scored, 
    SUM(a.shots) AS shots,
    ROUND(SUM(a.goals)*100.0 / NULLIF(SUM(a.shots), 0), 2) AS goal_conversion_percent, 		#division by null returns null.. while if it's divided by 0 cause an error.
    SUM(a.assists) AS assists
	FROM appearances AS a
	JOIN players AS p
	ON a.playerID = p.playerID
	GROUP BY p.playerID, p.name
	ORDER BY goals_scored DESC;
    
#TRY TO INCLUDE SEASON AND LEAGUE TO THE TOP SCORER..

CREATE VIEW playersScorers AS 
	SELECT 
		ROW_NUMBER() OVER (ORDER BY SUM(a.goals) DESC) AS position,
		g.season AS season,
		a.leagueID,
		l.name AS leagueName,
		a.playerID,
		p.name AS playerName,
		SUM(a.goals) AS goals_scored, 
		SUM(a.shots) AS shots,
		ROUND(SUM(a.goals)*100.0 / NULLIF(SUM(a.shots), 0), 2) AS goal_conversion_percent, 		#division by null returns null.. while if it's divided by 0 cause an error.
		SUM(a.assists) AS assists,
		SUM(a.yellowCard) AS yellowCard,
		SUM(a.redCard) AS redCard

	FROM appearances as a

	JOIN games as g
		ON g.gameID = a.gameID

	JOIN leagues as l
		ON l.leagueID = a.leagueID
		
	JOIN players as p
		ON a.playerID = p.playerID
		
	GROUP BY 
		a.playerID, 
		p.name,
		g.season, 
		a.leagueID,
		l.name
	ORDER BY 
		goals_scored DESC,
		assists DESC;


#2014 TOP SCORERS OF THE 5 LEAGUES
SELECT *
FROM playersScorers
WHERE season = 2014
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
#2015 TOP SCORERS OF THE 5 LEAGUES

SELECT *
FROM playersScorers
WHERE season = 2015
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
#2016 TOP SCORERS OF THE 5 LEAGUES

SELECT *
FROM playersScorers
WHERE season = 2016
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
#2017 TOP SCORERS OF THE 5 LEAGUES

SELECT *
FROM playersScorers
WHERE season = 2017
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
#2018 TOP SCORERS OF THE 5 LEAGUES

SELECT *
FROM playersScorers
WHERE season = 2018
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
#2019 TOP SCORERS OF THE 5 LEAGUES

SELECT *
FROM playersScorers
WHERE season = 2019
ORDER BY 
	goals_scored DESC
    LIMIT 5;

#2020 TOP SCORERS OF THE 5 LEAGUES
    
SELECT *
FROM playersScorers
WHERE season = 2020
ORDER BY 
	goals_scored DESC
    LIMIT 5;
    
SELECT *
FROM (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY g.season ORDER BY SUM(a.goals) DESC) AS position,
        g.season AS season,
        l.name AS leagueName,
        p.name AS playerName,
        SUM(a.goals) AS goals_scored, 
        SUM(a.shots) AS shots,
        ROUND(SUM(a.goals)*100.0 / NULLIF(SUM(a.shots), 0), 2) AS goal_conversion_percent,
        SUM(a.assists) AS assists,
        SUM(a.yellowCard) AS yellowCard,
        SUM(a.redCard) AS redCard
    FROM appearances AS a
    JOIN games AS g ON g.gameID = a.gameID
    JOIN leagues AS l ON l.leagueID = a.leagueID
    JOIN players AS p ON a.playerID = p.playerID
    WHERE g.season BETWEEN 2014 AND 2020
    GROUP BY 
        a.playerID, 
        p.name,
        g.season, 
        a.leagueID,
        l.name
) ranked
WHERE position <= 5
ORDER BY season, position;