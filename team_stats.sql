SELECT 
	ts.gameID,
    ts.season, 
    l.name as leagueName,
	t.name as teamName,
	CASE
		WHEN g.homeTeamID = ts.teamID AND g.gameID = ts.gameID THEN 'home'
        ELSE 'away'
	END AS home_away,
	ts.result,
	CASE
		WHEN ts.result = 'W' THEN 3
        WHEN ts.result = 'L' THEN 0
        WHEN ts.result = 'D' THEN 1
    END AS points,
	CASE
		WHEN ts.result = 'W' THEN 1
        ELSE 0
	END AS win_loss,
    ts.goals AS ft_goals,
    CASE
		WHEN ts.gameID = g.gameID AND ts.teamID = g.homeTeamID THEN g.homeGoalsHalfTime
        WHEN ts.gameID = g.gameID AND ts.teamID = g.awayTeamID THEN g.awayGoalsHalfTime
    END AS ht_goals,
    CASE 
		WHEN ts.gameID = g.gameID AND ts.teamID = g.homeTeamID THEN g.awayGoals
        WHEN ts.gameID = g.gameID AND ts.teamID = g.awayTeamID THEN g.homeGoals
	END AS ft_goals_owned,
   CASE 
		WHEN ts.gameID = g.gameID AND ts.teamID = g.homeTeamID THEN g.awayGoalsHalfTime
        WHEN ts.gameID = g.gameID AND ts.teamID = g.awayTeamID THEN g.homeGoalsHalfTime
    END AS ht_goals_owned,
	ts.xGoals, 
    ts.shots, 
    ts.shotsOnTarget, 
    ts.fouls, 
    ts.corners, 
    ts.yellowCards, 
    ts.redCards
    
FROM teamstats AS ts

## join teams table
JOIN teams AS t
	ON t.teamID = ts.teamID
## join games table 
JOIN games AS g
	ON g.gameID = ts.gameID
## join leagues table
JOIN leagues as l
	ON l.leagueID = g.leagueID
ORDER BY RAND()
LIMIT 10;
