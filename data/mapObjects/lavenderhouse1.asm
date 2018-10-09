LavenderHouse1Object:
	db $a ; border block

	db $2 ; warps
	db $7, $2, $2, $ff
	db $7, $3, $2, $ff

	db $0 ; signs

	db $1 ; objects
	object SPRITE_MR_FUJI, $3, $1, STAY, NONE, $5 ; person
	
	; warp-to
	EVENT_DISP LAVENDER_HOUSE_1_WIDTH, $7, $2
	EVENT_DISP LAVENDER_HOUSE_1_WIDTH, $7, $3
