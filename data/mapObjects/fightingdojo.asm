FightingDojoObject:
	db $3 ; border block

	db $2 ; warps
	db $b, $4, $1, $ff
	db $b, $5, $1, $ff

	db $0 ; signs

	db $2; objects
	object SPRITE_BALL, $4, $1, STAY, NONE, $6 ; person
	object SPRITE_BALL, $5, $1, STAY, NONE, $7 ; person

	; warp-to
	EVENT_DISP FIGHTING_DOJO_WIDTH, $b, $4
	EVENT_DISP FIGHTING_DOJO_WIDTH, $b, $5
