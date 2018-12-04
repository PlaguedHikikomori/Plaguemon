KnifeRoomObject:
	db $d ; border block

	db $2 ; warps
	db $7, $2, $1, POKEMONTOWER_1
	db $7, $3, $1, POKEMONTOWER_1
	
	db $0 ; signs

	db $1 ; objects
	object SPRITE_BLUE, $1, $3, FIGHT, $1, $1
	
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $2
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $3
	
	
	

	