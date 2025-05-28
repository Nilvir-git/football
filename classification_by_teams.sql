-- CLASSIFICATION BY SEASON / LEAGUE
SELECT 
	ROW_NUMBER() OVER (ORDER BY SUM(points)/COUNT(gameID) DESC) AS position,
    teamName,
    SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END) AS won,
	SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END) AS drawn,
	SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END) AS lost,
	SUM(CASE WHEN ht_goals - ht_goals_owned > 0 THEN 1 ELSE 0 END) AS ht_won,
	SUM(CASE WHEN ht_goals - ht_goals_owned = 0  THEN 1 ELSE 0 END) AS ht_drawn,
	SUM(CASE WHEN ht_goals - ht_goals_owned < 0  THEN 1 ELSE 0 END) AS ht_lost,
    SUM(CASE WHEN ht_goals - ht_goals_owned > 0 AND result = 'W' THEN 1 ELSE 0 END) AS ht_ft_won,
    SUM(ft_goals) AS GF,
    SUM(ft_goals_owned) AS GA,
    SUM(ft_goals) - SUM(ft_goals_owned) AS GD,
    ROUND(SUM(points)/COUNT(gameID),2) AS points_per_game,
    ROUND(SUM(ft_goals)/COUNT(gameID),2) AS GF_per_game,
    ROUND(SUM(xGoals)/COUNT(gameID),2) AS xG_per_game,
    ROUND(SUM(ft_goals_owned)/COUNT(gameID),2) AS GA_per_game,
    ROUND(SUM(ft_goals) - SUM(ft_goals_owned),2)/COUNT(gameID) AS GD_per_game,
    ROUND(SUM(shots)/COUNT(gameID),2) AS shots_per_game,
    ROUND(SUM(shotsOnTarget)/COUNT(gameID),2) AS shotsOnTarget_per_game,
    ROUND(SUM(corners)/COUNT(gameID),2) AS corners_per_game,
    ROUND(SUM(CASE WHEN result = 'W' THEN 1 ELSE 0 END),2) /COUNT(gameID) AS win_ratio,
    ROUND(SUM(CASE WHEN result = 'D' THEN 1 ELSE 0 END),2) /COUNT(gameID) AS drawn_ratio,
    ROUND(SUM(CASE WHEN result = 'L' THEN 1 ELSE 0 END),2) /COUNT(gameID) AS loss_ratio,
    ROUND(SUM(CASE WHEN ht_goals - ht_goals_owned > 0 THEN 1 ELSE 0 END)/COUNT(gameID),2) AS ht_win_ratio,
	ROUND(SUM(CASE WHEN ht_goals - ht_goals_owned = 0  THEN 1 ELSE 0 END)/COUNT(gameID),2) AS ht_drawn_ratio,
	ROUND(SUM(CASE WHEN ht_goals - ht_goals_owned < 0  THEN 1 ELSE 0 END)/COUNT(gameID),2) AS ht_lost_ratio,
    ROUND(SUM(CASE WHEN ht_goals - ht_goals_owned > 0 AND result = 'W' THEN 1 ELSE 0 END)/COUNT(gameID),2) AS ht_ft_win_ratio
    
        
FROM SeasonLeagueResults
GROUP BY teamName
ORDER BY points_per_game DESC; 
