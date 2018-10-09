Route10Object:
	db $2c ; border block

	db $4 ; warps
	db $13, $b, $0, ROCK_TUNNEL_POKECENTER
	db $11, $8, $0, ROCK_TUNNEL_1
	db $35, $8, $2, ROCK_TUNNEL_1
	db $27, $6, $0, POWER_PLANT

	db $4 ; signs
	db $13, $7, $7 ; Route10Text7
	db $13, $c, $8 ; PokeCenterSignText
	db $37, $9, $9 ; Route10Text9
	db $29, $5, $a ; Route10Text10

	db $0 ; objects


	; warp-to
	EVENT_DISP ROUTE_10_WIDTH, $13, $b ; ROCK_TUNNEL_POKECENTER
	EVENT_DISP ROUTE_10_WIDTH, $11, $8 ; ROCK_TUNNEL_1
	EVENT_DISP ROUTE_10_WIDTH, $35, $8 ; ROCK_TUNNEL_1
	EVENT_DISP ROUTE_10_WIDTH, $27, $6 ; POWER_PLANT
