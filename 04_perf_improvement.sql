USE football_smart_scout;

DELETE FROM mat_view_normalized_player_stat_values
WHERE athleteId IS NULL;

DELETE FROM mat_view_summed_player_stat_values
WHERE athleteId IS NULL;

ALTER TABLE mat_view_normalized_player_stat_values
ADD PRIMARY KEY (athleteId);

ALTER TABLE mat_view_summed_player_stat_values
ADD PRIMARY KEY (athleteId);

CREATE INDEX idx_transfer_value_value_clean ON transfer_value(value_clean);
CREATE INDEX idx_position_data_positionName ON position_data(positionName);