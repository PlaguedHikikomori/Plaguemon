PokemonTower5Object:
	db $1 ; border block

	db $2 ; warps
	db $9, $3, $0, POKEMONTOWER_4
	db $9, $12, $0, POKEMONTOWER_6

	db $0 ; signs

	db $0 ; objects


	; warp-to
	EVENT_DISP POKEMONTOWER_5_WIDTH, $9, $3 ; POKEMONTOWER_4
	EVENT_DISP POKEMONTOWER_5_WIDTH, $9, $12 ; POKEMONTOWER_6
