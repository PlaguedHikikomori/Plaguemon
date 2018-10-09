CopycatsHouse2FObject:
	db $a ; border block

	db $1 ; warps
	db $1, $7, $2, COPYCATS_HOUSE_1F

	db $2 ; signs
	db $5, $3, $6 ; CopycatsHouse2FText6
	db $1, $0, $7 ; CopycatsHouse2FText7

	db $5 ; objects
	object SPRITE_BRUNETTE_GIRL, $4, $3, WALK, $0, $1 ; person
	object SPRITE_BIRD, $4, $6, WALK, $2, $2 ; person
	object SPRITE_SLOWBRO, $5, $1, STAY, DOWN, $3 ; person
	object SPRITE_BIRD, $2, $0, STAY, DOWN, $4 ; person
	object SPRITE_CLEFAIRY, $1, $6, STAY, RIGHT, $5 ; person

	; warp-to
	EVENT_DISP COPYCATS_HOUSE_2F_WIDTH, $1, $7 ; COPYCATS_HOUSE_1F
