PokemonTower1Object:
	db $1 ; border block

	db $5 ; warps
	db $11, $a, $1, $ff
	db $11, $b, $1, $ff
	db $9, $12, $1, POKEMONTOWER_2
	db $0,  $a, $1, KNIFE_ROOM
	db $0,  $b, $1, KNIFE_ROOM

	db $0 ; signs

	db $0 ; objects
	
	
	; warp-to
	EVENT_DISP POKEMONTOWER_1_WIDTH, $11, $a
	EVENT_DISP POKEMONTOWER_1_WIDTH, $11, $b
	EVENT_DISP POKEMONTOWER_1_WIDTH, $9, $12 ; POKEMONTOWER_2
	EVENT_DISP POKEMONTOWER_1_WIDTH, $0,  $a
	EVENT_DISP POKEMONTOWER_1_WIDTH, $0,  $b
	