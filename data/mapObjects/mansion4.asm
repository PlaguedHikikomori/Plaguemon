Mansion4Object:
	db $1 ; border block

	db $1 ; warps
	db $16, $17, $5, MANSION_1

	db $0 ; signs

	db $8 ; objects
	object SPRITE_CABLE_CLUB_WOMAN, $15, $3, STAY, DOWN, $1, OPP_SUPER_NERD, $9   ;sprite, x, y, movimento, facing, script, nemico/pokemon/oggetto, party
	object SPRITE_CABLE_CLUB_WOMAN, $11, $7, STAY, UP, $2, OPP_SUPER_NERD, $a
	object SPRITE_CABLE_CLUB_WOMAN, $e, $6, STAY, DOWN, $3, OPP_SUPER_NERD, $b
	object SPRITE_CABLE_CLUB_WOMAN, $8, $6, STAY, DOWN, $4, OPP_SUPER_NERD, $c
	object SPRITE_DISK, $5, $d, STAY, NONE, $5, X_DEFEND
	object SPRITE_DISK, $5, $4, STAY, NONE, $6, TM_22
	object SPRITE_DISK, $10, $14, STAY, NONE, $b
	object SPRITE_BIBRODO, $5, $d, STAY, NONE, $c, BIBRODO, 50

	; warp-to
	EVENT_DISP MANSION_4_WIDTH, $16, $17 ; MANSION_1
