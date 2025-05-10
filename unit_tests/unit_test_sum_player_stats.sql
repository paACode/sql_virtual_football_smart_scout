-- Expect Sums 31, 2, 26, 18
SELECT * FROM view_unique_player_stat_values
WHERE athleteID = 6327;

SELECT * FROM view_summed_player_stat_values
WHERE athleteID = 6327;



-- Query the athletes with the most safes
-- epxectation: they are goalies
-- expectation: neuer , schärt and other top goalies shoul be there

-- Resuls are different then expected chat gpt is used :
-- Sergio Remoero is well known
-- Franco Armani as well
-- No Top tier: Marcos Ledesma, Santiago Mele, Alejandro Rodríguez, Sebastián Moyano, César, John, Marcos Miranda, Andrés Mosquera, Michael Cooper, Juan Pablo Cozzani, Salvador Ichazo


SELECT
	s.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionName,
    CAST(s.total_goalsConceded AS FLOAT) / NULLIF(s.total_shotsFaced, 0) AS goal_received_ratio,
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
FROM view_summed_player_stat_values as s -- alias s for stats
	INNER JOIN base_data_players as p
    ON s.athleteID = p.athleteID
WHERE s.total_appearances > 20 -- Top players have for sure 20 players per season, unfort
	AND s.total_shotsFaced > 0 -- Otherwise ratio would be infinite
ORDER BY goal_received_ratio ASC
LIMIT 20;

-- Now do the same in desending order and see if the goalies are bad accoridng to chat gpt:
/*CHAT GPT: Answer
The first list of goalkeepers is generally better overall because it includes goalkeepers with higher-level experience, international recognition, and club success in top leagues like La Liga, Premier League, and Copa Libertadores.
The second list includes some promising players and those who have played in lower-tier leagues or backup roles, but they haven't reached the level of the goalkeepers in the first list.
If you're looking for top-tier, established goalkeepers, the first list is definitely stronger. The second list may feature some solid goalkeepers, but they have not achieved the same level of recognition and consistency in top-tier leagues and international tournaments.
*/
SELECT
	s.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionName,
    CAST(s.total_goalsConceded AS FLOAT) / NULLIF(s.total_shotsFaced, 0) AS goal_received_ratio,
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
FROM view_summed_player_stat_values as s -- alias s for stats
	INNER JOIN base_data_players as p
    ON s.athleteID = p.athleteID
WHERE s.total_appearances > 20 -- Top players have for sure 20 players per season, unfort
	AND s.total_shotsFaced > 0 -- Otherwise ratio would be infinite
ORDER BY goal_received_ratio DESC
LIMIT 20;


-- Reference Manuel Neuer
SELECT
	s.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionName,
    CAST(s.total_goalsConceded AS FLOAT) / NULLIF(s.total_shotsFaced, 0) AS goal_received_ratio,
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
FROM view_summed_player_stat_values as s -- alias s for stats
	INNER JOIN base_data_players as p
    ON s.athleteID = p.athleteID
WHERE
	p.lastName = 'Neuer';







-- Does not give good results because players with low appearance have high value
SELECT
	s.athleteId,
    p.firstName , 
    p.lastName, 
    p.positionName,
    CAST(s.total_goalsConceded AS FLOAT) / NULLIF(s.total_appearances, 0) AS goals_conceded_per_game,
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
FROM view_summed_player_stat_values as s -- alias s for stats
	INNER JOIN base_data_players as p
    ON s.athleteID = p.athleteID
ORDER BY goals_conceded_per_game DESC
LIMIT 20;