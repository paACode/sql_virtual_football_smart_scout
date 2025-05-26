USE football_smart_scout;
SELECT
    n.athleteId,
    p.firstName, 
    p.lastName, 
    p.positionId,
    pd.positionName,
    tv.value_clean,
    (n.normalized_appearances * 20) + 
    (n.normalized_shotsOnTarget * 20) + 
    (n.normalized_totalGoals * 60) AS player_score,
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
FROM mat_view_normalized_player_stat_values AS n
INNER JOIN base_data_players AS p
    ON n.athleteID = p.athleteID
INNER JOIN mat_view_summed_player_stat_values AS s
    ON n.athleteID = s.athleteID
LEFT JOIN transfer AS t
    ON n.athleteID = t.athleteID
LEFT JOIN transfer_value AS tv 
    ON t.transferId = tv.transferId
LEFT JOIN position_data AS pd
    ON p.positionId = pd.positionId
WHERE (tv.value_clean < 1000000)
  AND (pd.positionName = 'Forward')
ORDER BY player_score DESC
LIMIT 20;