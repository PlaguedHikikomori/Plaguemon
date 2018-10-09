MOVE_GENGAR_RIGHT   EQU $00
MOVE_GENGAR_LEFT    EQU $01
MOVE_NIDORINO_RIGHT EQU $ff

PlayIntro:
	xor a
	ld [hJoyHeld], a
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	call PlayShootingStar
	call CityExplosion
	call EnableLCD
	;call Monster
	call CityExplosion
	ld a, SFX_INTRO_RAISE
	call PlaySound
	call PreBlackBomb
	ld a, SFX_INTRO_HOP
	call PlaySound
	call BlackBomb
	;call Monster2
	;call PlayIntroScene
	call GBFadeOutToWhite
	xor a
	ld [hSCX], a
	ld [H_AUTOBGTRANSFERENABLED], a
	call ClearSprites
	call DelayFrame
	ret

PlayIntroScene:
	ld b, SET_PAL_NIDORINO_INTRO
	call RunPaletteCommand
	ld a, %11100100
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	xor a
	ld [hSCX], a
	ld b, $3 ; Gengar tiles
	call IntroCopyTiles
	ld a, 0
	ld [wBaseCoordX], a
	ld a, 60
	ld [wBaseCoordY], a
	lb bc, 6, 6
	call InitIntroNidorinoOAM
	lb de, 80 / 2, MOVE_NIDORINO_RIGHT
	call IntroMoveMon
	ret c

; hip
	ld a, SFX_INTRO_HIP
	call PlaySound
	xor a
	ld [wIntroNidorinoBaseTile], a
	ld de, IntroNidorinoAnimation1
	call AnimateIntroNidorino
; hop
	ld a, SFX_INTRO_HOP
	call PlaySound
	ld de, IntroNidorinoAnimation2
	call AnimateIntroNidorino
	ld c, $a
	call CheckForUserInterruption
	ret c

; hip
	ld a, SFX_INTRO_HIP
	call PlaySound
	ld de, IntroNidorinoAnimation1
	call AnimateIntroNidorino
; hop
	ld a, SFX_INTRO_HOP
	call PlaySound
	ld de, IntroNidorinoAnimation2
	call AnimateIntroNidorino
	ld c, $1e
	call CheckForUserInterruption
	ret c

; raise
	ld b, $4
	call IntroCopyTiles
	ld a, SFX_INTRO_RAISE
	call PlaySound
	lb de, 8 / 2, MOVE_GENGAR_LEFT
	call IntroMoveMon
	ld c, $1e
	call CheckForUserInterruption
	ret c

; slash
	ld b, $5
	call IntroCopyTiles
	ld a, SFX_INTRO_CRASH
	call PlaySound
	lb de, 16 / 2, MOVE_GENGAR_RIGHT
	call IntroMoveMon
; hip
	ld a, SFX_INTRO_HIP
	call PlaySound
	ld a, $24
	ld [wIntroNidorinoBaseTile], a
	ld de, IntroNidorinoAnimation3
	call AnimateIntroNidorino
	ld c, $1e
	call CheckForUserInterruption
	ret c

	lb de, 8 / 2, MOVE_GENGAR_LEFT
	call IntroMoveMon
	ld b, $3
	call IntroCopyTiles
	ld c, $3c
	call CheckForUserInterruption
	ret c

; hip
	ld a, SFX_INTRO_HIP
	call PlaySound
	xor a
	ld [wIntroNidorinoBaseTile], a
	ld de, IntroNidorinoAnimation4
	call AnimateIntroNidorino
; hop
	ld a, SFX_INTRO_HOP
	call PlaySound
	ld de, IntroNidorinoAnimation5
	call AnimateIntroNidorino
	ld c, $14
	call CheckForUserInterruption
	ret c

	ld a, $24
	ld [wIntroNidorinoBaseTile], a
	ld de, IntroNidorinoAnimation6
	call AnimateIntroNidorino
	ld c, $1e
	call CheckForUserInterruption
	ret c

; lunge
	ld a, SFX_INTRO_LUNGE
	call PlaySound
	ld a, $48
	ld [wIntroNidorinoBaseTile], a
	ld de, IntroNidorinoAnimation7
	jp AnimateIntroNidorino

AnimateIntroNidorino:
	ld a, [de]
	cp $50
	ret z
	ld [wBaseCoordY], a
	inc de
	ld a, [de]
	ld [wBaseCoordX], a
	push de
	ld c, 6 * 6
	call UpdateIntroNidorinoOAM
	ld c, 5
	call DelayFrames
	pop de
	inc de
	jr AnimateIntroNidorino

UpdateIntroNidorinoOAM:
	ld hl, wOAMBuffer
	ld a, [wIntroNidorinoBaseTile]
	ld d, a
.loop
	ld a, [wBaseCoordY]
	add [hl]
	ld [hli], a ; Y
	ld a, [wBaseCoordX]
	add [hl]
	ld [hli], a ; X
	ld a, d
	ld [hli], a ; tile
	inc hl
	inc d
	dec c
	jr nz, .loop
	ret

InitIntroNidorinoOAM:
	ld hl, wOAMBuffer
	ld d, 0
.loop
	push bc
	ld a, [wBaseCoordY]
	ld e, a
.innerLoop
	ld a, e
	add 8
	ld e, a
	ld [hli], a ; Y
	ld a, [wBaseCoordX]
	ld [hli], a ; X
	ld a, d
	ld [hli], a ; tile
	ld a, $80
	ld [hli], a ; attributes
	inc d
	dec c
	jr nz, .innerLoop
	ld a, [wBaseCoordX]
	add 8
	ld [wBaseCoordX], a
	pop bc
	dec b
	jr nz, .loop
	ret

IntroClearScreen:
	ld hl, vBGMap1
	ld bc, $240
	jr IntroClearCommon

IntroClearMiddleOfScreen:
; clear the area of the tile map between the black bars on the top and bottom
	coord hl, 0, 4
	ld bc, SCREEN_WIDTH * 10

IntroClearCommon:
	ld [hl], $0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, IntroClearCommon
	ret

IntroPlaceBlackTiles:
	ld a, $E ; nero da fungo atomico..
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

IntroMoveMon:
; d = number of times to move the mon (2 pixels each time)
; e: $00 = move Gengar right, $01 = move Gengar left, $ff = move Nidorino right
	ld a, e
	cp $ff
	jr z, .moveNidorinoRight
	cp $1
	jr z, .moveGengarLeft
; move Gengar right
	ld a, [hSCX]
	dec a
	dec a
	jr .next
.moveNidorinoRight
	push de
	ld a, 2
	ld [wBaseCoordX], a
	xor a
	ld [wBaseCoordY], a
	ld c, 6 * 6
	call UpdateIntroNidorinoOAM
	pop de
.moveGengarLeft
	ld a, [hSCX]
	inc a
	inc a
.next
	ld [hSCX], a
	push de
	ld c, 2
	call CheckForUserInterruption
	pop de
	ret c
	dec d
	jr nz, IntroMoveMon
	ret

IntroCopyTiles:
	coord hl, 13, 7

CopyTileIDsFromList_ZeroBaseTileID:
	ld c, 0
	predef_jump CopyTileIDsFromList

PlayMoveSoundB:
; unused
	predef GetMoveSoundB
	ld a, b
	jp PlaySound

LoadIntroGraphics:
	ld hl, FightIntroBackMon
	ld de, vChars2
	ld bc, FightIntroBackMonEnd - FightIntroBackMon
	ld a, BANK(FightIntroBackMon)
	call FarCopyData2
	ld hl, GameFreakIntro
	ld de, vChars2 + $600
	ld bc, GameFreakIntroEnd - GameFreakIntro
	ld a, BANK(GameFreakIntro)
	call FarCopyData2
	ld hl, GameFreakIntro
	ld de, vChars1
	ld bc, GameFreakIntroEnd - GameFreakIntro
	ld a, BANK(GameFreakIntro)
	call FarCopyData2
	ld hl, FightIntroFrontMon
	ld de, vChars0
	ld bc, $600
	ld a, BANK(FightIntroFrontMon)
	jp FarCopyData2

PlayShootingStar:
	ld b, SET_PAL_GAME_FREAK_INTRO
	call RunPaletteCommand
	callba LoadCopyrightAndTextBoxTiles2  ;Beta explain
	ld a, %00011011
	ld [rBGP], a
	ld c, 255
	call DelayFrames
	call DelayFrames
	call ClearScreen
	call DisableLCD
	xor a
	ld [wCurOpponent], a
	;call IntroDrawBlackBars
	call LoadIntroGraphics
	call EnableLCD
	ld hl, rLCDC
	res 5, [hl]
	set 3, [hl]
	ld c, 64
	call DelayFrames
	callba LoadCopyrightAndTextBoxTiles
	ld a, %00011011
	ld [rBGP], a
	ld c, 180
	call DelayFrames
	call ClearScreen
	call DisableLCD
	xor a
	ld [wCurOpponent], a
	ld a, %11100100
	ld [rBGP], a
	call IntroDrawBlackBars
	call LoadIntroGraphics
	call EnableLCD
	ld hl, rLCDC
	res 5, [hl]
	set 3, [hl]
	ld c, 64
	call DelayFrames
	callba AnimateShootingStar
	push af
	pop af
	jr c, .next ; skip the delay if the user interrupted the animation
	ld c, 40
	call DelayFrames
.next
	ld a, BANK(Music_IntroBattle)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	ld a, MUSIC_INTRO_BATTLE
	ld [wNewSoundID], a
	call PlaySound
	call IntroClearMiddleOfScreen
	call ClearSprites
	jp Delay3

IntroDrawBlackBars:
; clear the screen and draw black bars on the top and bottom
	call IntroClearScreen
	coord hl, 0, 0
	ld c, SCREEN_WIDTH * 4
	call IntroPlaceBlackTiles
	coord hl, 0, 14
	ld c, SCREEN_WIDTH * 4
	call IntroPlaceBlackTiles
	ld hl, vBGMap1
	ld c, $80
	call IntroPlaceBlackTiles
	ld hl, vBGMap1 + $1c0
	ld c, $80
	jp IntroPlaceBlackTiles

EmptyFunc4:
	ret

IntroNidorinoAnimation0:
	db 0, 0
	db $50

IntroNidorinoAnimation1:
; This is a sequence of pixel movements for part of the Nidorino animation. This
; list describes how Nidorino should hop.
; First byte is y movement, second byte is x movement
	db  0, 0
	db -2, 2
	db -1, 2
	db  1, 2
	db  2, 2
	db $50 ; list terminator

IntroNidorinoAnimation2:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db  0,  0
	db -2, -2
	db -1, -2
	db  1, -2
	db  2, -2
	db $50 ; list terminator

IntroNidorinoAnimation3:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db   0, 0
	db -12, 6
	db  -8, 6
	db   8, 6
	db  12, 6
	db $50 ; list terminator

IntroNidorinoAnimation4:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db  0,  0
	db -8, -4
	db -4, -4
	db  4, -4
	db  8, -4
	db $50 ; list terminator

IntroNidorinoAnimation5:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db  0, 0
	db -8, 4
	db -4, 4
	db  4, 4
	db  8, 4
	db $50 ; list terminator

IntroNidorinoAnimation6:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db 0, 0
	db 2, 0
	db 2, 0
	db 0, 0
	db $50 ; list terminator

IntroNidorinoAnimation7:
; This is a sequence of pixel movements for part of the Nidorino animation.
; First byte is y movement, second byte is x movement
	db -8, -16
	db -7, -14
	db -6, -12
	db -4, -10
	db $50 ; list terminator

GameFreakIntro:
	INCBIN "gfx/gamefreak_intro.2bpp"
	INCBIN "gfx/gamefreak_logo.2bpp"
	ds $10 ; blank tile
GameFreakIntroEnd:

FightIntroBackMon:
	INCBIN "gfx/red/explosion2.2bpp"
FightIntroBackMonEnd:

PreExplosion:
	INCBIN "gfx/red/explosion3.2bpp"
PreExplosionEnd:

MonsterPic:
	INCBIN "gfx/red/monster.2bpp"
MonsterPicEnd:

Monster2Pic:
	INCBIN "gfx/red/monsterdead.2bpp"
Monster2PicEnd:

FightIntroFrontMon:

IF DEF(_RED)
	INCBIN "gfx/red/city.2bpp"
ENDC
IF DEF(_BLUE)
	INCBIN "gfx/blue/intro_purin_1.6x6.2bpp"
	INCBIN "gfx/blue/intro_purin_2.6x6.2bpp"
	INCBIN "gfx/blue/intro_purin_3.6x6.2bpp"
ENDC

FightIntroFrontMonEnd:

	ds $10 ; blank tile
	
CityExplosion:
	ld de, FightIntroFrontMon
	ld hl, vChars1
	lb bc, BANK(FightIntroFrontMon), $70
	call CopyVideoData
	coord hl, 0, 6
	ld de, CopyrightTextString2
	call PlaceString
	call DelayFrames
	ret

CopyrightTextString2:
	db   $7F,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$7F,$7F    
	db   $7F,$7F,$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$7F,$7F    
	db   $7F,$7F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$7F,$7F 
    db   $7F,$7F,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$7F,$7F    
	db   $7F,$7F,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$7F,$7F    
	db   $7F,$7F,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$7F,$7F	
	db   "@"

PreBlackBomb:
	ld de, PreExplosion
	ld hl, vChars2 + $20
	lb bc, BANK(PreExplosion), $2E
	call CopyVideoData
	coord hl, 0, 5
	ld de, CopyrightTextString3
	call PlaceString
    call BombFlash
    call BombFlash
    call BombFlash
    call BombFlash
	ret
	
CopyrightTextString3:
	db   $7F,$7F,$7F,$7F,$7F,$7F,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$7F,$7F,$7F,$7F,$7F   
	db   $7F,$7F,$7F,$7F,$7F,$7F,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$7F,$7F,$7F,$7F,$7F     
	db   $7F,$7F,$90,$91,$92,$93,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$7F,$7F,$7F,$7F,$7F
    db   $7F,$7F,$A0,$A1,$A2,$A3,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$7F,$7F,$7F,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E    
	db   "@"


	

	
	
BlackBomb:
	ld de, FightIntroBackMon
	ld hl, vChars2 + $20
	lb bc, BANK(FightIntroBackMon), $2E
	call CopyVideoData
	coord hl, 0, 5
	ld de, CopyrightTextString4
	call PlaceString
	call BombFlash
	call BombFlash
	call BombFlash
	call BombFlash
	ret
	
CopyrightTextString4:
	db   $7F,$7F,$7F,$7F,$7F,$7F,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$7F,$7F,$7F,$7F,$7F   
	db   $7F,$7F,$7F,$7F,$7F,$7F,$0B,$0C,$0D,$0E,$0F,$10,$11,$12,$13,$7F,$7F,$7F,$7F,$7F     
	db   $7F,$7F,$90,$91,$92,$93,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$7F,$7F,$7F,$7F,$7F
    db   $7F,$7F,$A0,$A1,$A2,$A3,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$7F,$7F,$7F,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E    
	db   "@"

BombFlash:
    ld a,[rBGP]
	push af ; save initial palette
	ld a,%00011011 ; 0, 1, 2, 3 (inverted colors)
	ld [rBGP],a
	ld c,8
	call DelayFrames
	xor a ; white out background
	ld [rBGP],a
	ld c,8
	call DelayFrames
	pop af
	ld [rBGP],a ; restore initial palette
	;call DelayFrames
	ret
	
Monster:
	ld de, MonsterPic
	ld hl, vChars1
	lb bc, BANK(MonsterPic), $70
	call CopyVideoData
	coord hl, 0, 6
	ld de, CopyrightTextString5
	call PlaceString
	call DelayFrames
	ret

CopyrightTextString5:
	db   $7F,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$7F,$7F    
	db   $7F,$7F,$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$7F,$7F    
	db   $7F,$7F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$7F,$7F 
    db   $7F,$7F,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$7F,$7F    
	db   $7F,$7F,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$7F,$7F    
	db   $7F,$7F,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$7F,$7F	
	db   "@"
	
Monster2:
	ld de, Monster2Pic
	ld hl, vChars1
	lb bc, BANK(Monster2Pic), $70
	call CopyVideoData
	coord hl, 0, 6
	ld de, CopyrightTextString6
	call PlaceString
	call DelayFrames
	ret

CopyrightTextString6:
	db   $7F,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$7F,$7F    
	db   $7F,$7F,$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$7F,$7F    
	db   $7F,$7F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$7F,$7F 
    db   $7F,$7F,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$7F,$7F    
	db   $7F,$7F,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$7F,$7F    
	db   $7F,$7F,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$7F,$7F	
	db   "@"