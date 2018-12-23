SpaceWorldObject:
	db $1 ; border block

	db $0 ; warps
	
	db $0 ; signs

	db $3 ; objects
	object SPRITE_WARDEN, $7, $4, WALK, LEFT, $1
	object SPRITE_WARDEN, $6, $7, WALK, LEFT, $1
	object SPRITE_WARDEN, $6, $6, WALK, LEFT, $1
	
	

	