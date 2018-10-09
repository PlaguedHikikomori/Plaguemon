CeruleanPokecenterObject:
	db $0 ; border block

	db $2 ; warps
	db $7, $3, $2, $ff
	db $7, $4, $2, $ff

	db $0 ; signs

	db $4 ; objects
	object SPRITE_NURSE, $3, $1, STAY, DOWN, $1 ; person
	object SPRITE_BLACK_HAIR_BOY_2, $a, $5, WALK, $0, $2 ; person
	object SPRITE_GENTLEMAN, $4, $3, STAY, DOWN, $3 ; person
	object SPRITE_CABLE_CLUB_WOMAN, $b, $2, STAY, DOWN, $4 ; person

	; warp-to
	EVENT_DISP CERULEAN_POKECENTER_WIDTH, $7, $3
	EVENT_DISP CERULEAN_POKECENTER_WIDTH, $7, $4
