PlayPorn:
	call StopAllSounds
	call ClearScreen
	xor a
	ld [hWY], a
	xor a
	ld [wUpdateSpritesEnabled], a
	ld [hTilesetType], a
	ld [wSpriteFlipped], a
	ld [wLetterPrintingDelayFlags], a 
	ld [wHoFMonOrPlayer], a ; 
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld c, 20
	call DelayFrames
    call Frame1	
	call Frame2
	call Frame3
	ldpikacry e, PikachuCry3
	callab PlayPikachuSoundClip2
	call Frame2
	call Frame1	
	call Frame2
	call Frame3	
	call Frame2
	call Frame1	
	call Frame2
	call Frame3
	ldpikacry e, PikachuCry3
	callab PlayPikachuSoundClip2
	call Frame2	
	call Frame1	
	call Frame2
	call Frame3	
	call Frame2
	call Frame1	
	call Frame2
	call Frame3
	ldpikacry e, PikachuCry3
	callab PlayPikachuSoundClip2	
	call Frame2
	call Frame1	
	call Frame2
	call Frame3	
	call Frame4
	
	call Frame5
	ldpikacry e, PikachuCry3
	callab PlayPikachuSoundClip2
	ld c, 50
	call DelayFrames
	ld a, [hJoyPressed]
	cp A_BUTTON
	jr z, .reloadMap
	ret
.reloadMap
	callab InitMapSprites 
	call ReloadMapData
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	call UpdateSprites
	ret
	

	
CopyrightTextString99:
	db   $7F,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$7F,$7F
	db   $7F,$7F,$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$7F,$7F    
	db   $7F,$7F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$7F,$7F 
    db   $7F,$7F,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$7F,$7F    
	db   $7F,$7F,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$7F,$7F    
	db   $7F,$7F,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$7F,$7F
	db   $7F,$7F,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$7F,$7F
	db   "@"



Frame1:
	coord hl, 0, 0
	lb bc, 12, 20
	ld de, SCOPARE
	ld hl, vChars1
	lb bc, BANK(SCOPARE), $A0
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 5
	ld de, CopyrightTextString99
	call PlaceString
	call EnableLCD
	ld c, 2
	call DelayFrames
	ret
	
Frame2:
	coord hl, 0, 0
	lb bc, 12, 20
	ld de, SCOPARE2
	ld hl, vChars1
	lb bc, BANK(SCOPARE2), $A0
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 5
	ld de, CopyrightTextString99
	call PlaceString
	call EnableLCD
	ld c, 2
	call DelayFrames
	ret
	
Frame3:
	coord hl, 0, 0
	lb bc, 12, 20
	ld de, SCOPARE3
	ld hl, vChars1
	lb bc, BANK(SCOPARE3), $A0
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 5
	ld de, CopyrightTextString99
	call PlaceString
	call EnableLCD
	ld c, 2
	call DelayFrames
	ret 
	
Frame4:
	coord hl, 0, 0
	lb bc, 12, 20
	ld de, SCOPARE4
	ld hl, vChars1
	lb bc, BANK(SCOPARE4), $A0
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 5
	ld de, CopyrightTextString99
	call PlaceString
	call EnableLCD
	ld c, 20
	call DelayFrames
	ret 
	
Frame5:
	coord hl, 0, 0
	lb bc, 12, 20
	ld de, SCOPARE5
	ld hl, vChars1
	lb bc, BANK(SCOPARE5), $A0
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 5
	ld de, CopyrightTextString99
	call PlaceString
	call EnableLCD
	ld c, 50
	call DelayFrames
	ret 