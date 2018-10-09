Mansion4Object:
	db $1 ; border block

	db $1 ; warps
	db $16, $17, $5, MANSION_1

	db $0 ; signs

	db $2 ; objects
	object SPRITE_BOOK_MAP_DEX, $10, $14, STAY, NONE, $7 ; person
	object SPRITE_BALL, $5, $d, STAY, NONE, $8, SECRET_KEY

	; warp-to
	EVENT_DISP MANSION_4_WIDTH, $16, $17 ; MANSION_1
