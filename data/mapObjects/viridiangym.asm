ViridianGymObject:
	db $3 ; border block

	db $2 ; warps
	db $11, $10, $4, $ff
	db $11, $11, $4, $ff

	db $0 ; signs

	db $1 ; objects
	object SPRITE_GIOVANNI, $2, $1, STAY, DOWN, $1, OPP_GIOVANNI, $3
	
	; warp-to
	EVENT_DISP VIRIDIAN_GYM_WIDTH, $11, $10
	EVENT_DISP VIRIDIAN_GYM_WIDTH, $11, $11
