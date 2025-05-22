-- Set Filters here
SET @stat1 = 'normalized_appearances';
SET @weight_stat1 = 20;
SET @stat2 = 'normalized_shotsOnTarget';
SET @weight_stat2 = 20;
SET @stat3 = 'normalized_totalGoals';
SET @weight_stat3 = 60;
SET @budget = 1000000;
SET @position = 'Forward';
SET @table_length = 20;


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
    -- else filter only player which have a value below budget
    IF(@budget IS NULL, '1=1', CONCAT('tv.value_clean < ', @budget)), ')
AND (',
	-- Position filter: if @position is NULL, accept all positions;
    -- else filter only players with the exact position name matching @position
    IF(@position IS NULL , '1=1', CONCAT('pd.positionName = \'', @position, '\'')), ')
ORDER BY player_score DESC
LIMIT ', @table_length, ';
');

-- Prepare and execute
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
