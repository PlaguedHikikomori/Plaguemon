PalletTown_h:
	db OVERWORLD ; tileset
	db PALLET_TOWN_HEIGHT, PALLET_TOWN_WIDTH ; dimensions
	dw PalletTownBlocks, PalletTownTextPointers, PalletTownScript
	db NORTH | SOUTH ; connections
	NORTH_MAP_CONNECTION PALLET_TOWN, ROUTE_1, 0, 0, Route1Blocks
	SOUTH_MAP_CONNECTION PALLET_TOWN, ROUTE_21, 0, 0, Route21Blocks, 1
	dw PalletTownObject
