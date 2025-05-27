USE palest_dbm_project;

SET @athleteId = 198849;

SELECT 
	actionId, 
    fieldpositionX,
    fieldPositionY,
    fieldPosition2X,
    fieldPosition2Y,
    updateDateTime
FROM player_action_coordinates
WHERE athleteId = @athleteId;