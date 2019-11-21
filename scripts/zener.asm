INCLUDE "scripts/hikinumbers.asm"
INCLUDE "engine/battle/secretcard.asm"

PlayZener:
	call CardsAvailable
	call SetCardsNumber
	call StopAllSounds
	call ClearScreen
	xor a
	ld [hWY], a
	xor a
	ld [wGuessed], a
	ld [wUpdateSpritesEnabled], a
	ld [hTilesetType], a
	ld [wSpriteFlipped], a
	ld [wLetterPrintingDelayFlags], a 
	ld [wHoFMonOrPlayer], a ; 
	inc a
	ld [wPlayerCard], a
	ld [H_AUTOBGTRANSFERENABLED], a
	ld c, 20
	call DelayFrames
	call ZenerTable
	call GuessedPrint
MathLoop:
	ld c, 50
	call DelayFrames
	call CompareCards
	call GuessedPrint
	call EndGame
	call SecretCard
CardsLoop:
	call ChooseCard
	ld de, wZenerCardsDeck
	coord hl, 0, 0
	lb bc, 1, 2
	call PrintNumberHiki
	jp CardsLoop
MegaRitorno:
	callab InitMapSprites 
	call ReloadMapData
	call LoadFontTilePatterns
	call LoadTextBoxTilePatterns
	call EnoughCards
	callab InitMapSprites 
	call ReloadMapData
	call LoadFontTilePatterns
	call LoadTextBoxTilePatterns
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	call UpdateSprites
	ld a, [wCurMapScript]
	inc a
	ld [wCurMapScript], a
	jp OverworldLoop
	
	
	
	

ZenerFrame:
	db   $7F,$7F,$80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$7F,$7F
	db   $7F,$7F,$90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$7F,$7F    
	db   $7F,$7F,$A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$7F,$7F
    db   $7F,$7F,$B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$7F,$7F 
    db   $7F,$7F,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$7F,$7F    
	db   $7F,$7F,$D0,$D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$7F,$7F    
	db   $7F,$7F,$E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$7F,$7F
	db   $7F,$7F,$F0,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$7F,$7F
	db   "@"

CarteFrame:
	db   $7F,$7F,$60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$7F,$7F
	db   $7F,$7F,$70,$71,$72,$73,$74,$75,$76,$77,$78,$7C,$7A,$7B,$7C,$7D,$7E,$79,$7F,$7F
	db   "@"

ZenerTable:
	ld de, ZENER
	ld hl, vChars1
	lb bc, BANK(ZENER), $80
	call CopyVideoData
	ld de, CARTE
	ld hl, vChars2
	lb bc, BANK(CARTE), $80
	call CopyVideoData
	ld de, NUMBERS
	ld hl, vChars2
	lb bc, BANK(NUMBERS), $10
	call CopyVideoData
	call DisableLCD
	coord hl, 0, 3
	ld de, ZenerFrame
	call PlaceString
	coord hl, 0, 12
	ld de, CarteFrame
	call PlaceString
	call EnableLCD
	ret
	

SetCardsNumber:
	ld a, $1A
	ld [wZenerCardsDeck], a
	ret


	
ChooseCard:

	ld a, [hJoyInput]
	cp D_UP
	jr nz, .notUP
	ld a, $10
	ld [wPlayerCard], a
	ld a, [wZenerCardsDeck]
	dec a
	ld [wZenerCardsDeck], a
	jp MathLoop
	
.notUP
	cp D_LEFT
	jr nz, .notLEFT
	ld a, $20
	ld [wPlayerCard], a
	ld a, [wZenerCardsDeck]
	dec a
	ld [wZenerCardsDeck], a
	jp MathLoop
.notLEFT
	cp D_DOWN
	jr nz, .notDOWN
	ld a, $30
	ld [wPlayerCard], a
	ld a, [wZenerCardsDeck]
	dec a
	ld [wZenerCardsDeck], a
	jp MathLoop
.notDOWN
	cp D_RIGHT
	jr nz, .notRIGHT
	ld a, $40
	ld [wPlayerCard], a
	ld a, [wZenerCardsDeck]
	dec a
	ld [wZenerCardsDeck], a
	jp MathLoop
.notRIGHT
	cp B_BUTTON
	jr nz, .notBBUTTON
	ld a, $50
	ld [wPlayerCard], a
	ld a, [wZenerCardsDeck]
	dec a
	ld [wZenerCardsDeck], a
	jp MathLoop
.notBBUTTON
	ret
	
	
	
CompareCards:
	ld a, [wWhichCard]
	ld b, a
	ld a, [wPlayerCard]
	cp b
	jr nz, .denied
	ld a, SFX_SWAP
	call PlaySound
	ld a, [wGuessed]
	inc a
	ld [wGuessed], a
	ret
.denied
	ld a, SFX_DENIED
	call PlaySound
	ret
	
	
	
	
EndGame:
	ld a, [wZenerCardsDeck]
	cp $01
	ret nz
	jp MegaRitorno
	
	
	
	
EnoughCards:
	ld a, [wGuessed]
	sub $A   
	ret c         ;OK TO CALL
	ld a, $00
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $01
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $02
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $03
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $04
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $05
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ret	
	
	
	
	
	
	
	
	
	
	
	
