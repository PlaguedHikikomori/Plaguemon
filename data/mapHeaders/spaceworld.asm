SpaceWorld_h:
	db SPACE ; tileset
	db SPACE_WORLD_HEIGHT, SPACE_WORLD_WIDTH ; dimensions
	dw SpaceWorldBlocks, SpaceWorldTextPointers, SpaceWorldScript
	db $00 ; no connections
	dw SpaceWorldObject
