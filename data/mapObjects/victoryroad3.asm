VictoryRoad3Object:
	db $7d ; border block

	db $4 ; warps
	db $7, $17, $3, VICTORY_ROAD_2
	db $8, $1a, $5, VICTORY_ROAD_2
	db $f, $1b, $4, VICTORY_ROAD_2
	db $0, $2, $6, VICTORY_ROAD_2

	db $0 ; signs

	db $0 ; objects
	
	; warp-to
	EVENT_DISP VICTORY_ROAD_3_WIDTH, $7, $17 ; VICTORY_ROAD_2
	EVENT_DISP VICTORY_ROAD_3_WIDTH, $8, $1a ; VICTORY_ROAD_2
	EVENT_DISP VICTORY_ROAD_3_WIDTH, $f, $1b ; VICTORY_ROAD_2
	EVENT_DISP VICTORY_ROAD_3_WIDTH, $0, $2 ; VICTORY_ROAD_2
