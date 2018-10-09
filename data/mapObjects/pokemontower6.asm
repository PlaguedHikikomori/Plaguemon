PokemonTower6Object:
	db $1 ; border block

	db $2 ; warps
	db $9, $12, $1, POKEMONTOWER_5
	db $10, $9, $0, POKEMONTOWER_7

	db $0 ; signs

	db $0 ; objects


	; warp-to
	EVENT_DISP POKEMONTOWER_6_WIDTH, $9, $12 ; POKEMONTOWER_5
	EVENT_DISP POKEMONTOWER_6_WIDTH, $10, $9 ; POKEMONTOWER_7
