BorderPalettes:
IF DEF(_RED)
	INCBIN "gfx/red/sgbborder.map"
ENDC
IF DEF(_BLUE)
	INCBIN "gfx/blue/sgbborder.map"
ENDC

	ds $100

IF DEF(_RED)
	RGB 31,31,31 ; PAL_ROUTE
	RGB 20,20,20
	RGB 10,10,10
	RGB 1,1,1
ENDC
IF DEF(_BLUE)
	RGB 0,0,0 ; PAL_SGB1 (the first color is not defined, but if used, turns up as 30,29,29... o_O)
	RGB 10,17,26
	RGB 5,9,20
	RGB 16,20,27
ENDC

	ds $18

IF DEF(_RED)
	RGB 31,31,31 ; PAL_ROUTE
	RGB 20,20,20
	RGB 10,10,10
	RGB 1,1,1
ENDC
IF DEF(_BLUE)
	RGB 30,29,29 ; PAL_SGB2
	RGB 27,11,6
	RGB 5,9,20
	RGB 28,25,15
ENDC

	ds $18

IF DEF(_RED)
	RGB 31,31,31 ; PAL_ROUTE
	RGB 20,20,20
	RGB 10,10,10
	RGB 1,1,1
ENDC
IF DEF(_BLUE)
	RGB 30,29,29 ; PAL_SGB3
	RGB 12,15,11
	RGB 5,9,20
	RGB 14,22,17
ENDC

	ds $18

SGBBorderGraphics:
IF DEF(_RED)
	INCBIN "gfx/red/sgbborder.2bpp"
ENDC
IF DEF(_BLUE)
	INCBIN "gfx/blue/sgbborder.2bpp"
ENDC
