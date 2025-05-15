USE palest_dbm_project;

-- Player positions ordered by count
SELECT 
    tf.position,
    COUNT(tf.position) as pos_count
FROM transfer_value as tf
GROUP BY tf.position
ORDER BY pos_count DESC;

-- Most Players were born in 2000 --> are 25 years old
-- The oldes player was born 1976
SELECT 
	YEAR(tf.birth_clean) as birth_year,
    COUNT(*) as count_players
FROM transfer_value as tf
GROUP BY birth_year
ORDER BY count_players DESC;

-- Only get counts before the year 2000
SELECT 
	YEAR(tf.birth_clean) as birth_year,
    COUNT(*) as count_players
FROM transfer_value as tf
GROUP BY birth_year
HAVING birth_year < 2000;
