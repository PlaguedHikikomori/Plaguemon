PokemonTower3Object:
	db $1 ; border block

	db $2 ; warps
	db $9, $3, $0, POKEMONTOWER_2
	db $9, $12, $1, POKEMONTOWER_4

	db $0 ; signs

	db $0 ; objects

	; warp-to
	EVENT_DISP POKEMONTOWER_3_WIDTH, $9, $3 ; POKEMONTOWER_2
	EVENT_DISP POKEMONTOWER_3_WIDTH, $9, $12 ; POKEMONTOWER_4
