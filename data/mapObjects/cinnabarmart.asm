CinnabarMartObject:
	db $0 ; border block

	db $2 ; warps
	db $7, $3, $4, $ff
	db $7, $4, $4, $ff

	db $0 ; signs

	db $3 ; objects
	object SPRITE_MART_GUY, $0, $5, STAY, RIGHT, $1 ; person
	object SPRITE_ERIKA, $6, $2, STAY, NONE, $2 ; person
	object SPRITE_OAK_AIDE, $3, $4, STAY, NONE, $3 ; person

	; warp-to
	EVENT_DISP CINNABAR_MART_WIDTH, $7, $3
	EVENT_DISP CINNABAR_MART_WIDTH, $7, $4
