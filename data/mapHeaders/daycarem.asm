DayCareM_h:
	db HOUSE ; tileset
	db DAYCAREM_HEIGHT, DAYCAREM_WIDTH ; dimensions (y, x)
	dw DayCareMBlocks, DayCareMTextPointers, DayCareMScript ; blocks, texts, scripts
	db $00 ; connections
	dw DayCareMObject ; objects
