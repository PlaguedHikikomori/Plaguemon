SecretLabObject:
	db $3 ; border block

	db $2 ; warps
	db $b, $4, $2, $ff
	db $b, $5, $2, $ff
	
	db $0 ; signs

	db $1 ; objects
	object SPRITE_BIRD, $4, $3, STAY, DOWN, $1, MEW, 50
	
	; warp-to
	EVENT_DISP OAKS_LAB_WIDTH, $b, $4
	EVENT_DISP OAKS_LAB_WIDTH, $b, $5
	
