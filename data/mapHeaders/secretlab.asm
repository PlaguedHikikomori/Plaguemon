SecretLab_h:
	db GYM ; tileset
	db SECRET_LAB_HEIGHT, SECRET_LAB_WIDTH ; dimensions
	dw SecretLabBlocks, SecretLabTextPointers, SecretLabScript
	db $00 ; no connections
	dw SecretLabObject
