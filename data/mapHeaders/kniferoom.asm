KnifeRoom_h:
	db INTERIOR ; tileset
	db KNIFE_ROOM_HEIGHT, KNIFE_ROOM_WIDTH ; dimensions
	dw KnifeRoomBlocks, KnifeRoomTextPointers, KnifeRoomScript
	db $00 ; no connections
	dw KnifeRoomObject
