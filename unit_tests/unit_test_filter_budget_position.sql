USE palest_dbm_project;

-- Min Value is 10k, Max Value is 200Mio
SELECT 
    MAX(value_clean) AS max_value,
    MIN(value_clean) AS min_value
FROM transfer_value;


-- Filter Athlete Ids by Budget
SELECT 
	t.athleteId
FROM transfer as t
	INNER JOIN transfer_value AS tv
		ON t.transferId = tv.transferId
WHERE  tv.value_clean < 100000;


-- Quick Sanity Check : We apply the same filter as in unit_test_centr_norm_player_stats.sql and expect the same Results with both filters set to Null
-- 1st position Viktor Gyökeres, 9th position is Cristiano Ronaldo, 17th Position Mohammed Sallah

-- Again set the filter for a offensive player 
SET @stat1 = 'normalized_appearances';
SET @weight_stat1 = 20;
SET @stat2 = 'normalized_shotsOnTarget';
SET @weight_stat2 = 20;
SET @stat3 = 'normalized_totalGoals';
SET @weight_stat3 = 60;
SET @budget = NULL;
SET @position = NULL;

-- Build the dynamic SQL query string
SET @sql = CONCAT('
SELECT 
    n.athleteId,
    p.firstName, 
    p.lastName, 
    p.positionId,
    pd.positionName,
    tv.value_clean,
    (n.', @stat1, ' * ', @weight_stat1, ') + 
    (n.', @stat2, ' * ', @weight_stat2, ') + 
    (n.', @stat3, ' * ', @weight_stat3, ') AS player_score,
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
    s.total_goalsConceded,
    tv.value_clean
FROM view_normalized_player_stat_values AS n
INNER JOIN base_data_players AS p
    ON n.athleteID = p.athleteID
INNER JOIN view_summed_player_stat_values AS s
    ON n.athleteID = s.athleteID
LEFT JOIN transfer AS t
    ON n.athleteID = t.athleteID
LEFT JOIN transfer_value AS tv 
    ON t.transferId = tv.transferId
LEFT JOIN position_data AS pd
	ON p.positionId = pd.positionId
WHERE (', 
	 -- Budget filter: if @budget is NULL, accept all players;
    -- If @budget is set, include only players with a value_clean less than the budget,
    -- or those with no value_clean (could be transfer candidates with unknown value)
    IF(@budget IS NULL, '1=1', CONCAT('(tv.value_clean < ', @budget, ' OR tv.value_clean IS NULL)')), ')
AND (',
	-- Position filter: if @position is NULL, accept all positions;
    -- else filter only players with the exact position name matching @position
    IF(@position IS NULL , '1=1', CONCAT('pd.positionName = \'', @position, '\'')), ')
ORDER BY player_score DESC
LIMIT 20;
');

-- Prepare and execute
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Filter by Budget and Position, So the Midfielder Kelior Dunn should disappear  and we want players below 100 Mio
-- Eric Haaland : 200 Mio
-- So Eric Haaland  should disappear

-- Works : Eric Haaland is not in the list anymre, there is also no midfielder anymore , Christiano Ronaldo is still in there because we do not know how much he costs
SET @stat1 = 'normalized_appearances';
SET @weight_stat1 = 20;
SET @stat2 = 'normalized_shotsOnTarget';
SET @weight_stat2 = 20;
SET @stat3 = 'normalized_totalGoals';
SET @weight_stat3 = 60;
SET @budget = 100000000;
SET @position = 'Forward';


-- Build the dynamic SQL query string
SET @sql = CONCAT('
SELECT 
    n.athleteId,
    p.firstName, 
    p.lastName, 
    p.positionId,
    pd.positionName,
    tv.value_clean,
    (n.', @stat1, ' * ', @weight_stat1, ') + 
    (n.', @stat2, ' * ', @weight_stat2, ') + 
    (n.', @stat3, ' * ', @weight_stat3, ') AS player_score,
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
    s.total_goalsConceded,
    tv.value_clean
FROM view_normalized_player_stat_values AS n
INNER JOIN base_data_players AS p
    ON n.athleteID = p.athleteID
INNER JOIN view_summed_player_stat_values AS s
    ON n.athleteID = s.athleteID
LEFT JOIN transfer AS t
    ON n.athleteID = t.athleteID
LEFT JOIN transfer_value AS tv 
    ON t.transferId = tv.transferId
LEFT JOIN position_data AS pd
	ON p.positionId = pd.positionId
WHERE (', 
	 -- Budget filter: if @budget is NULL, accept all players;
    -- If @budget is set, include only players with a value_clean less than the budget,
    -- or those with no value_clean (could be transfer candidates with unknown value)
    IF(@budget IS NULL, '1=1', CONCAT('(tv.value_clean < ', @budget, ' OR tv.value_clean IS NULL)')), ')
AND (',
	-- Position filter: if @position is NULL, accept all positions;
    -- else filter only players with the exact position name matching @position
    IF(@position IS NULL , '1=1', CONCAT('pd.positionName = \'', @position, '\'')), ')
ORDER BY player_score DESC
LIMIT 20;
');

-- Prepare and execute
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
