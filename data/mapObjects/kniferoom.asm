KnifeRoomObject:
	db $d ; border block

	db $2 ; warps
	db $7, $2, $1, $ff
	db $7, $3, $1, $ff
	
	db $0 ; signs

	db $0 ; objects
	
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $2
	EVENT_DISP KNIFE_ROOM_WIDTH, $7, $3
	
	
	

	