SaffronCityObject:
	db $f ; border block

	db $8 ; warps
	db $5, $7, $0, COPYCATS_HOUSE_1F
	db $3, $1a, $0, FIGHTING_DOJO
	db $3, $22, $0, SAFFRON_GYM
	db $b, $d, $0, SAFFRON_HOUSE_1
	db $b, $19, $0, SAFFRON_MART
	db $15, $12, $0, SILPH_CO_1F
	db $1d, $9, $0, SAFFRON_POKECENTER
	db $1d, $1d, $0, SAFFRON_HOUSE_2

	db $a ; signs
	db $5, $11, $10 ; SaffronCityText16
	db $5, $1b, $11 ; SaffronCityText17
	db $5, $23, $12 ; SaffronCityText18
	db $b, $1a, $13 ; MartSignText
	db $13, $27, $14 ; SaffronCityText20
	db $15, $5, $15 ; SaffronCityText21
	db $15, $f, $16 ; SaffronCityText22
	db $1d, $a, $17 ; PokeCenterSignText
	db $1d, $1b, $18 ; SaffronCityText24
	db $13, $1, $19 ; SaffronCityText25

	db $1 ; objects
	object SPRITE_LAPRAS_GIVER, $22, $17, STAY, NONE, $9 ; person
	

	; warp-to
	EVENT_DISP SAFFRON_CITY_WIDTH, $5, $7 ; COPYCATS_HOUSE_1F
	EVENT_DISP SAFFRON_CITY_WIDTH, $3, $1a ; FIGHTING_DOJO
	EVENT_DISP SAFFRON_CITY_WIDTH, $3, $22 ; SAFFRON_GYM
	EVENT_DISP SAFFRON_CITY_WIDTH, $b, $d ; SAFFRON_HOUSE_1
	EVENT_DISP SAFFRON_CITY_WIDTH, $b, $19 ; SAFFRON_MART
	EVENT_DISP SAFFRON_CITY_WIDTH, $15, $12 ; SILPH_CO_1F
	EVENT_DISP SAFFRON_CITY_WIDTH, $1d, $9 ; SAFFRON_POKECENTER
	EVENT_DISP SAFFRON_CITY_WIDTH, $1d, $1d ; SAFFRON_HOUSE_2
