VictoryRoad1Object:
	db $7d ; border block

	db $3 ; warps
	db $11, $8, $2, $ff
	db $11, $9, $2, $ff
	db $1, $1, $0, VICTORY_ROAD_2

	db $0 ; signs

	db $0 ; objects
	

	; warp-to
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $11, $8
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $11, $9
	EVENT_DISP VICTORY_ROAD_1_WIDTH, $1, $1 ; VICTORY_ROAD_2
