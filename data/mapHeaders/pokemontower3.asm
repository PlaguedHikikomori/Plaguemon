PokemonTower3_h:
	db CEMETERY ; tileset
	db POKEMONTOWER_3_HEIGHT, POKEMONTOWER_3_WIDTH ; dimensions (y, x)
	dw PokemonTower3Blocks, PokemonTower3TextPointers, PokemonTower3Script ; blocks, texts, scripts
	db $00 ; connections
	dw PokemonTower3Object ; objects
