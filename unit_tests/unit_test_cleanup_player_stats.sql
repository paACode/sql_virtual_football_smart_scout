-- First load the sql script cleanup_player_stats.sql to load the test view 
-- Select any player which has 20 stats available, can be checked easily
SELECT 
    ps.athleteId,
    COUNT(*) as nr_stats_available
FROM player_stats as ps
GROUP BY ps.athleteId
HAVING COUNT(*) = 20;

-- So we go for athlete 6327
SELECT * FROM player_stats
WHERE athleteID = 6327;

-- Looking at the table we expect 8 player stats data
-- Timestamps expected:
-- ENG 1 = '2025-04-26 04:52:50'
-- Fifa Word Q = 2025-04-24 11:57:47 --> this one in 2025
-- UEFA-EUROPA = '2025-01-31 14:47:50'
-- UEFA Nations = '2024-11-21 05:49:03'
-- Eng league cup =  '2024-10-13 05:07:32'
-- jpn world  = '2024-10-13 04:52:58'
--  Fifa friendly =  '2024-01-05 04:05:11'

-- Validate with Players --it works !!!
SELECT * FROM view_unique_player_stat_values
WHERE athleteID = 6327;



