PokemonTower7Object:
	db $1 ; border block

	db $3 ; warps
	db $10, $9, $1, POKEMONTOWER_6
    db $0, $A, $1, SECRET_LAB
	db $0, $B, $1, SECRET_LAB
	
	db $0 ; signs

	db 4 ; objects
	object SPRITE_MEDIUM, $9, $b, STAY, RIGHT, $1, OPP_CHANNELER, $13
	object SPRITE_MEDIUM, $c, $9, STAY, LEFT, $2, OPP_CHANNELER, $14
	object SPRITE_MEDIUM, $9, $7, STAY, RIGHT, $3, OPP_CHANNELER, $15
	object SPRITE_MR_FUJI, $a, $3, STAY, DOWN, $4 ; person

	; warp-to
	EVENT_DISP POKEMONTOWER_7_WIDTH, $10, $9 ; POKEMONTOWER_6
    EVENT_DISP POKEMONTOWER_7_WIDTH, $0, $A
	EVENT_DISP POKEMONTOWER_7_WIDTH, $0, $B
	