SaffronPokecenterObject:
	db $0 ; border block

	db $2 ; warps
	db $7, $3, $6, $ff
	db $7, $4, $6, $ff

	db $0 ; signs

	db $4 ; objects
	object SPRITE_NURSE, $3, $1, STAY, DOWN, $1 ; person
	object SPRITE_FOULARD_WOMAN, $5, $5, STAY, NONE, $2 ; person
	object SPRITE_GENTLEMAN, $8, $3, STAY, DOWN, $3 ; person
	object SPRITE_CABLE_CLUB_WOMAN, $b, $2, STAY, DOWN, $4 ; person

	; warp-to
	EVENT_DISP SAFFRON_POKECENTER_WIDTH, $7, $3
	EVENT_DISP SAFFRON_POKECENTER_WIDTH, $7, $4
