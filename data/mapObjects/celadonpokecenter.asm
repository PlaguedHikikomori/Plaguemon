CeladonPokecenterObject:
	db $0 ; border block

	db $2 ; warps
	db $7, $3, $5, $ff
	db $7, $4, $5, $ff

	db $0 ; signs

	db $1 ; objects
	object SPRITE_NURSE, $3, $1, STAY, DOWN, $1 ; person
	
	; warp-to
	EVENT_DISP CELADON_POKECENTER_WIDTH, $7, $3
	EVENT_DISP CELADON_POKECENTER_WIDTH, $7, $4
