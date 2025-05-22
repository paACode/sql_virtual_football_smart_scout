USE palest_dbm_project;
DROP VIEW IF EXISTS view_normalized_player_stat_values;
CREATE VIEW view_normalized_player_stat_values AS
WITH stat_keyfigures AS (
    SELECT
		AVG(total_appearances) AS avg_appearances,
        STDDEV(total_appearances) AS stddev_appearances,
        AVG(total_subIns) AS avg_subIns,
        STDDEV(total_subIns) AS stddev_subIns,
        AVG(total_foulsCommitted) AS avg_foulsCommitted,
        STDDEV(total_foulsCommitted) AS stddev_foulsCommitted,
        AVG(total_foulsSuffered) AS avg_foulsSuffered,
        STDDEV(total_foulsSuffered) AS stddev_foulsSuffered,
        AVG(total_yellowCards) AS avg_yellowCards,
        STDDEV(total_yellowCards) AS stddev_yellowCards,
        AVG(total_redCards) AS avg_redCards,
        STDDEV(total_redCards) AS stddev_redCards,
        AVG(total_ownGoals) AS avg_ownGoals,
        STDDEV(total_ownGoals) AS stddev_ownGoals,
        AVG(total_goalAssists) AS avg_goalAssists,
        STDDEV(total_goalAssists) AS stddev_goalAssists,
        AVG(total_offsides) AS avg_offsides,
        STDDEV(total_offsides) AS stddev_offsides,
        AVG(total_shotsOnTarget) AS avg_shotsOnTarget,
        STDDEV(total_shotsOnTarget) AS stddev_shotsOnTarget,
        AVG(total_totalShots) AS avg_totalShots,
        STDDEV(total_totalShots) AS stddev_totalShots,
        AVG(total_totalGoals) AS avg_totalGoals,
        STDDEV(total_totalGoals) AS stddev_totalGoals,
        AVG(total_shotsFaced) AS avg_shotsFaced,
        STDDEV(total_shotsFaced) AS stddev_shotsFaced,
        AVG(total_saves) AS avg_saves,
        STDDEV(total_saves) AS stddev_saves,
        AVG(total_goalsConceded) AS avg_goalsConceded,
        STDDEV(total_goalsConceded) AS stddev_goalsConceded
	FROM view_summed_player_stat_values
    )
    SELECT
		athleteId,
		(total_appearances - stat_keyfigures.avg_appearances) / stat_keyfigures.stddev_appearances AS normalized_appearances,
		(total_subIns - stat_keyfigures.avg_subIns) / stat_keyfigures.stddev_subIns AS normalized_subIns,
		(total_foulsCommitted - stat_keyfigures.avg_foulsCommitted) / stat_keyfigures.stddev_foulsCommitted AS normalized_foulsCommitted,
		(total_foulsSuffered - stat_keyfigures.avg_foulsSuffered) / stat_keyfigures.stddev_foulsSuffered AS normalized_foulsSuffered,
		(total_yellowCards - stat_keyfigures.avg_yellowCards) / stat_keyfigures.stddev_yellowCards AS normalized_yellowCards,
		(total_redCards - stat_keyfigures.avg_redCards) / stat_keyfigures.stddev_redCards AS normalized_redCards,
		(total_ownGoals - stat_keyfigures.avg_ownGoals) / stat_keyfigures.stddev_ownGoals AS normalized_ownGoals,
		(total_goalAssists - stat_keyfigures.avg_goalAssists) / stat_keyfigures.stddev_goalAssists AS normalized_goalAssists,
		(total_offsides - stat_keyfigures.avg_offsides) / stat_keyfigures.stddev_offsides AS normalized_offsides,
		(total_shotsOnTarget - stat_keyfigures.avg_shotsOnTarget) / stat_keyfigures.stddev_shotsOnTarget AS normalized_shotsOnTarget,
		(total_totalShots - stat_keyfigures.avg_totalShots) / stat_keyfigures.stddev_totalShots AS normalized_totalShots,
		(total_totalGoals - stat_keyfigures.avg_totalGoals) / stat_keyfigures.stddev_totalGoals AS normalized_totalGoals,
		(total_shotsFaced - stat_keyfigures.avg_shotsFaced) / stat_keyfigures.stddev_shotsFaced AS normalized_shotsFaced,
		(total_saves - stat_keyfigures.avg_saves) / stat_keyfigures.stddev_saves AS normalized_saves,
		(total_goalsConceded - stat_keyfigures.avg_goalsConceded) / stat_keyfigures.stddev_goalsConceded AS normalized_goalsConceded
	FROM view_summed_player_stat_values
JOIN stat_keyfigures ON 1=1; -- Make sure stat keyfigure are available for each athlete

SELECT * FROM view_normalized_player_stat_values;