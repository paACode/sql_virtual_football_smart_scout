USE football_smart_scout;

SET @athleteId = 158626;

SELECT 
	actionId, 
    fieldpositionX,
    fieldPositionY,
    fieldPosition2X,
    fieldPosition2Y,
    updateDateTime
FROM player_action_coordinates
WHERE athleteId = @athleteId;