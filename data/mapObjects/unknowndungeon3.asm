UnknownDungeon3Object:
	db $7d ; border block

	db $1 ; warps
	db $6, $3, $8, UNKNOWN_DUNGEON_1

	db $0 ; signs

	db $3 ; objects
	object SPRITE_SLOWBRO, $1b, $d, STAY, DOWN, $1, MEWTWO, 90
	object SPRITE_BALL, $10, $9, STAY, NONE, $2, ULTRA_BALL
	object SPRITE_BALL, $12, $1, STAY, NONE, $3, MAX_REVIVE

	; warp-to
	EVENT_DISP UNKNOWN_DUNGEON_3_WIDTH, $6, $3 ; UNKNOWN_DUNGEON_1
