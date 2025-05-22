USE palest_dbm_project;
DROP VIEW IF EXISTS view_unique_player_stat_values;

CREATE VIEW view_unique_player_stat_values AS
SELECT 
    playerStatsId, seasonType, year, league, athleteId,
    appearances_value, subIns_value, foulsCommitted_value,
    foulsSuffered_value, yellowCards_value, redCards_value,
    ownGoals_value, goalAssists_value, offsides_value,
    shotsOnTarget_value, totalShots_value, totalGoals_value,
    shotsFaced_value, saves_value, goalsConceded_value,
    timestamp
FROM (
    SELECT 
        ps.*,
        ROW_NUMBER() OVER (
            PARTITION BY ps.athleteID, ps.league , ps.year
            ORDER BY ps.timestamp DESC
        ) AS rank_within_group
    FROM player_stats as ps
) AS ranked_stats
WHERE rank_within_group = 1; -- Take the upper most in group, if identified by max(date) the issue is that there can still be duplicate entries

-- Failed Approach: Returned still duplicates because there are duplicate timestamps
/*
DROP VIEW IF EXISTS view_unique_player_stat_values;
CREATE VIEW view_unique_player_stat_values AS
SELECT 
    ps.playerStatsId, ps.seasonType, ps.year, ps.league, ps.athleteId,
    ps.appearances_value, ps.subIns_value, ps.foulsCommitted_value,
    ps.foulsSuffered_value, ps.yellowCards_value, ps.redCards_value,
    ps.ownGoals_value, ps.goalAssists_value, ps.offsides_value,
    ps.shotsOnTarget_value, ps.totalShots_value, ps.totalGoals_value,
    ps.shotsFaced_value, ps.saves_value, ps.goalsConceded_value,
    ps.timestamp
FROM player_stats ps
WHERE ps.timestamp = (
    SELECT MAX(ps2.timestamp)
    FROM player_stats ps2
    WHERE ps2.athleteID = ps.athleteID
      AND ps2.league = ps.league
);
*/

-- Failed Approach trying to identify unique stats and then group them --> because if a player plays in half final and then in final the stats change , but the older stats should not count anymore
/*
DROP VIEW IF EXISTS view_unique_player_stat_values;
CREATE VIEW view_unique_player_stat_values AS
    WITH RankedStats AS (
        SELECT 
            ps.athleteID, ps.year, ps.seasonType, ps.league, 
            ps.appearances_value, ps.subIns_value, ps.foulsCommitted_value,
            ps.foulsSuffered_value, ps.yellowCards_value, ps.redCards_value,
            ps.ownGoals_value, ps.goalAssists_value, ps.offsides_value,
            ps.shotsOnTarget_value, ps.totalShots_value, ps.totalGoals_value,
            ps.shotsFaced_value, ps.saves_value, ps.goalsConceded_value,
            ps.playerStatsId,
            ROW_NUMBER() OVER (PARTITION BY 
                ps.athleteID, ps.year, ps.seasonType, ps.league, 
                ps.appearances_value, ps.subIns_value, ps.foulsCommitted_value,
                ps.foulsSuffered_value, ps.yellowCards_value, ps.redCards_value,
                ps.ownGoals_value, ps.goalAssists_value, ps.offsides_value,
                ps.shotsOnTarget_value, ps.totalShots_value, ps.totalGoals_value,
                ps.shotsFaced_value, ps.saves_value, ps.goalsConceded_value
            ORDER BY ps.playerStatsId DESC) AS row_num
        FROM player_stats AS ps
        WHERE ps.athleteID = 236321
    )
    SELECT 
        athleteID, year, seasonType, league, 
        appearances_value, subIns_value, foulsCommitted_value,
        foulsSuffered_value, yellowCards_value, redCards_value,
        ownGoals_value, goalAssists_value, offsides_value,
        shotsOnTarget_value, totalShots_value, totalGoals_value,
        shotsFaced_value, saves_value, goalsConceded_value,
        playerStatsId
    FROM RankedStats
    WHERE row_num = 1;

SELECT * FROM view_unique_player_stat_values;
*/