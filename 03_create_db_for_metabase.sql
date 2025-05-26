-- This DB is used for Metabase Visualizations
USE football_smart_scout;

/* For Top List the following Views are needed:
1. view_normalized_player_stat_values --> For Calc of Playerscore 
2. view:summed_player_stat_values --> To join absolute stats of player
3. */


-- Create materialized Views , like this player_stats table and view_unique_player_stat_values is not needed in this DB

CREATE TABLE mat_view_normalized_player_stat_values AS 
SELECT * FROM palest_dbm_project.view_normalized_player_stat_values;

CREATE TABLE mat_view_summed_player_stat_values AS 
SELECT * FROM palest_dbm_project.view_summed_player_stat_values;
    

/* For Top List the following Tables are needed:
1. transfer--> to filter by budget and join values in top list
2. tranfer_value --> to filter by budget and join values in top list
3. base_data_player --> to join base information about player$
4. position_data --> to join positionname*/

CREATE TABLE transfer AS SELECT * FROM palest_dbm_project.transfer;
CREATE TABLE transfer_value AS SELECT * FROM palest_dbm_project.transfer_value;
CREATE TABLE base_data_players AS SELECT * FROM palest_dbm_project.base_data_players;
CREATE TABLE position_data AS SELECT * FROM palest_dbm_project.position_data;

-- For the heatmap the player_action_coordinates table is needed

CREATE TABLE player_action_coordinates AS SELECT * FROM palest_dbm_project.player_action_coordinates;

