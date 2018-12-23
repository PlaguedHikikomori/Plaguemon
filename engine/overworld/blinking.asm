Blink:

	INCBIN "gfx/red/redblink.2bpp"
	
Blinking:
   ld a, [hJoyHeld]
   and D_DOWN | D_UP | D_LEFT | D_RIGHT
   ret nz ; return if a directional button is being pressed
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
 




	

