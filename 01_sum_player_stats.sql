USE palest_dbm_project;
DROP VIEW IF EXISTS view_summed_player_stat_values;
CREATE VIEW view_summed_player_stat_values AS
SELECT
    athleteId,
    SUM(appearances_value) AS total_appearances,
    SUM(subIns_value) AS total_subIns,
    SUM(foulsCommitted_value) AS total_foulsCommitted,
    SUM(foulsSuffered_value) AS total_foulsSuffered,
    SUM(yellowCards_value) AS total_yellowCards,
    SUM(redCards_value) AS total_redCards,
    SUM(ownGoals_value) AS total_ownGoals,
    SUM(goalAssists_value) AS total_goalAssists,
    SUM(offsides_value) AS total_offsides,
    SUM(shotsOnTarget_value) AS total_shotsOnTarget,
    SUM(totalShots_value) AS total_totalShots,
    SUM(totalGoals_value) AS total_totalGoals,
    SUM(shotsFaced_value) AS total_shotsFaced,
    SUM(saves_value) AS total_saves,
    SUM(goalsConceded_value) AS total_goalsConceded
FROM view_unique_player_stat_values
GROUP BY athleteId;

