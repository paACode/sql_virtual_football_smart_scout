SELECT 
    counts.positionId,
    pd.positionName,
    counts.occurrences
FROM (
    SELECT 
        positionId,
        COUNT(*) AS occurrences
    FROM base_data_players
    GROUP BY positionId
) AS counts
LEFT JOIN position_data AS pd
    ON counts.positionId = pd.positionId
ORDER BY counts.occurrences DESC;