KnifeRoomObject:
	db $d ; border block

	db $2 ; warps
	db $7, $2, $1, POKEMONTOWER_1
	db $7, $3, $1, POKEMONTOWER_1
	
	db $1 ; signs
	db $0, $0, $5 ; CeladonMart5Text5

	db $6 ; objects
	object SPRITE_BLUE, $1, $3, WALK, $3, $1
	object SPRITE_BLUE, $2, $3, WALK, $3, $1
	object SPRITE_BLUE, $4, $3, WALK, $3, $1
	object SPRITE_BLUE, $3, $3, WALK, $3, $1
	object SPRITE_BLUE, $5, $4, WALK, $3, $1
	object SPRITE_BLUE, $4, $4, WALK, $3, $1
	
	
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $2
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $3
	
	
	

	