LavenderHouse2Object:
	db $a ; border block

	db $2 ; warps
	db $7, $2, $4, $ff
	db $7, $3, $4, $ff

	db $0 ; signs

	db $0 ; objects
	

	; warp-to
	EVENT_DISP LAVENDER_HOUSE_2_WIDTH, $7, $2
	EVENT_DISP LAVENDER_HOUSE_2_WIDTH, $7, $3
