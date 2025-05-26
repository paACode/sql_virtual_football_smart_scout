-- See distrubution of players
USE palest_dbm_project;



-- Shows a list of how many stats are available per player
SELECT 
    ps.athleteId,
    COUNT(*) as nr_stats_available
FROM player_stats as ps
GROUP BY ps.athleteId
ORDER BY nr_stats_available DESC;

-- Look at a specific player without preselection
SELECT *
 FROM player_stats as ps
WHERE athleteId = 236321;

-- Look at a specific player with preselection
SELECT 
	ps.playerStatsID,
	ps.SeasonType,
	ps.year, 
	ps.league,
	ps.athleteID,
	ps.appearances_value,
	ps.yellowCards_value,
	ps.timestamp
 FROM player_stats as ps
WHERE athleteId = 236321;

-- There are many stats which cannot be assigned to a player 
SELECT * FROM player_stats
WHERE athleteId IS NULL
LIMIT 100;
    







DROP VIEW IF EXISTS ViewPlayersOverview;
CREATE VIEW ViewPlayersOverview
AS
	SELECT
		p.athleteId,
        p.firstName,
        p.lastName,
        p.positionName
	FROM base_data_players AS p;

SELECT * FROM ViewPlayersOverview;
