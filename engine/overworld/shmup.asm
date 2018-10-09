Shmup:
    call GBPalWhiteOutWithDelay3
	call ClearScreen
	ld c,10
	call DelayFrames
	ld a, SPACE_WORLD
	ld [wDestinationMap],a
	ld hl,wd732
	set 2,[hl] ; fly warp or dungeon warp
	callab SpecialWarpIn
	callab SpecialEnterMap
	
Scrolling:	
    ld a, [wCurMap]
	cp SPACE_WORLD
	ret nz
	
	ld hl, vChars2 
	ld c, $10

	ld a, [wMovingBGTilesCounter2]
	inc a
	and 7
	ld [wMovingBGTilesCounter2], a
	
.left
	ld a, [hl]
	rlca
	ld [hli], a
	dec c
	jr nz, .left
.done
	ld a, [hTilesetType]
	rrca
	ret nc
	
Blink:

	INCBIN "gfx/red/redblink.2bpp"
	
Blinking:
   ld a, [wAnimCounter]
   cp $40
   jp nz, .goOn
   ld a, [wWalkBikeSurfState]
   cp $0
   ret nz
   ld a, [wCurMap]
   cp SPACE_WORLD
   ret z
   ld a, $ff
   ld [wUpdateSpritesEnabled], a
   ld hl, vChars0 + $10
   ld de, Blink + $10
   lb bc, BANK(Blink), $01
   call CopyVideoData
   ld hl, vChars0 
   ld de, Blink 
   lb bc, BANK(Blink), $01
   call CopyVideoData
   ld hl, vChars0 + $20
   ld de, Blink + $20
   lb bc, BANK(Blink), $01
   call CopyVideoData
   ld hl, vChars0 + $30
   ld de, Blink + $30
   lb bc, BANK(Blink), $01
   call CopyVideoData
   ld a, $01
   ld [wUpdateSpritesEnabled], a
   call UpdateSprites
   ld c, 20
   call DelayFrames
   ld a, $ff
   ld [wUpdateSpritesEnabled], a
   ld hl, vChars0 + $10
   ld de, RedSprite + $10
   lb bc, BANK(RedSprite), $01
   call CopyVideoData
   ld hl, vChars0 
   ld de, RedSprite
   lb bc, BANK(RedSprite), $01
   call CopyVideoData
   ld hl, vChars0 + $20
   ld de, RedSprite + $20
   lb bc, BANK(RedSprite), $01
   call CopyVideoData
   ld hl, vChars0 + $30
   ld de, RedSprite + $30
   lb bc, BANK(RedSprite), $01
   call CopyVideoData
   ld a, $01
   ld [wUpdateSpritesEnabled], a
   ld a, [wAnimCounter]
   cp $0
   jr nz, .goOn
   ld a, $40
   ld [wAnimCounter], a
   ret
.goOn
   dec a
   ld [wAnimCounter], a
   ret
 

LoadCopyrightAndTextBoxTiles2:    ;BETA EXPLAIN
	xor a
	ld [hWY], a
	call ClearScreen
	call LoadTextBoxTilePatterns

LoadCopyrightTiles2:
	call LoadFontTilePatterns
	coord hl, 0, 1
	ld de, BetaExplain
	jp PlaceString

BetaExplain:
	db   "This version is the 0.666. "
    db   "It's been madethrought 365 days of"
	db   "pure madness and    agony.            "
	db   "  From 30/9/17 to     30/9/18         "
	db   "    Lots of glitch and  bugs can happen. "
	db   "   However it's the     first release of    this"
	db   " art project, soi hope you'll enjoy  it as much as i did."
	db   "                            -Hikikomori     "
	db   " "
	db   "@"
   


	

