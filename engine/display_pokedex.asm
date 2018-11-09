_DisplayPokedex:
	ld hl, wd730
	set 6, [hl]
	predef ShowPokedexData
	ld hl, wd730
	res 6, [hl]
	call ReloadMapData
	ld c, 10
	call DelayFrames
	predef IndexToPokedex
	predef SetPokedexSeen
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret
