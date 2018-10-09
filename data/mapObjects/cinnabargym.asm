CinnabarGymObject:
	db $2e ; border block

	db $2 ; warps
	db $11, $10, $1, $ff
	db $11, $11, $1, $ff

	db $0 ; signs

	db $1 ; objects
	object SPRITE_FAT_BALD_GUY, $3, $3, STAY, DOWN, $1, OPP_BLAINE, $1
	

	; warp-to
	EVENT_DISP CINNABAR_GYM_WIDTH, $11, $10
	EVENT_DISP CINNABAR_GYM_WIDTH, $11, $11
