USE palest_dbm_project;
-- Search for top strikers,
-- Expect Cristiano Ronaldo, Harry Kane, Erling Haaland and othe top strikes amongst the players
-- -> Result looks good, it also includes players from lower leagues but as a scout you also want to see those players
SELECT 
	n.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionId,
    (n.normalized_appearances * 20) + (n.normalized_shotsOnTarget* 20) + (n.normalized_totalGoals * 60) AS player_score,
    s.total_appearances,
	s.total_subIns,
	s.total_foulsCommitted,
	s.total_foulsSuffered,
	s.total_yellowCards,
	s.total_redCards,
	s.total_ownGoals,
	s.total_goalAssists,
	s.total_offsides,
	s.total_shotsOnTarget,
	s.total_totalShots,
	s.total_totalGoals,
	s.total_shotsFaced,
	s.total_saves,
	s.total_goalsConceded
FROM view_normalized_player_stat_values as n
	INNER JOIN base_data_players as p
		ON n.athleteID = p.athleteID
	INNER JOIN view_summed_player_stat_values as s
		ON n.athleteID = s.athleteID
ORDER BY player_score DESC
LIMIT 20;


-- Search for top goalies
-- For goalies it does not yet work so good
SELECT 
	n.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionId,
    (n.normalized_saves * 33) + (n.normalized_goalsConceded * -34) + (n.normalized_appearances * 33) AS player_score,
    s.total_appearances,
	s.total_subIns,
	s.total_foulsCommitted,
	s.total_foulsSuffered,
	s.total_yellowCards,
	s.total_redCards,
	s.total_ownGoals,
	s.total_goalAssists,
	s.total_offsides,
	s.total_shotsOnTarget,
	s.total_totalShots,
	s.total_totalGoals,
	s.total_shotsFaced,
	s.total_saves,
	s.total_goalsConceded
FROM view_normalized_player_stat_values as n
	INNER JOIN base_data_players as p
		ON n.athleteID = p.athleteID
	INNER JOIN view_summed_player_stat_values as s
		ON n.athleteID = s.athleteID
ORDER BY player_score DESC
LIMIT 20;