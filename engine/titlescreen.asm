; copy text of fixed length NAME_LENGTH (like player name, rival name, mon names, ...)
CopyFixedLengthText:
	ld bc, NAME_LENGTH
	jp CopyData

	
SetDefaultNamesBeforeTitlescreen:
	ld hl, NintenText
	ld de, wPlayerName
	call CopyFixedLengthText
	ld hl, SonyText
	ld de, wRivalName
	call CopyFixedLengthText
	xor a
	ld [hWY], a
	ld [wLetterPrintingDelayFlags], a
	ld hl, wd732
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, BANK(Music_TitleScreen)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a

DisplayTitleScreen:
	call GBPalWhiteOut
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	xor a
	ld [hTilesetType], a
	ld [hSCX], a
	ld a, $40
	ld [hSCY], a
	ld a, $90
	ld [hWY], a
	call ClearScreen
	call DisableLCD
	call LoadFontTilePatterns
	ld hl, NintendoCopyrightLogoGraphics
	ld de, vTitleLogo2 + $100
	ld bc, $50
	ld a, BANK(NintendoCopyrightLogoGraphics)
	call FarCopyData2
	ld hl, GamefreakLogoGraphics
	ld de, vTitleLogo2 + $100 + $50
	ld bc, $90
	ld a, BANK(GamefreakLogoGraphics)
	call FarCopyData2
	ld hl, PokemonLogoGraphics
	ld de, vTitleLogo  
	ld bc, $600
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData2          ;- first chunk
	ld hl, PokemonLogoGraphics+$600
	ld de, vTitleLogo2
	ld bc, $100
	ld a, BANK(PokemonLogoGraphics)
	call FarCopyData2          ; second chunk
	ld hl, Version_GFX
	ld de,vChars2 + $600 - (Version_GFXEnd - Version_GFX - $50)
	ld bc, Version_GFXEnd - Version_GFX
	ld a, BANK(Version_GFX)
	call FarCopyDataDouble
	call ClearBothBGMaps
	
    
	
; place tiles for pokemon logo (except for the last row)
	coord hl, 2, 4
	ld a, $80
	ld de, SCREEN_WIDTH
	ld c, 6
.pokemonLogoTileLoop
	ld b, $10
	push hl
.pokemonLogoTileRowLoop ; place tiles for one row
	ld [hli], a
	inc a
	dec b
	jr nz, .pokemonLogoTileRowLoop
	pop hl
	add hl, de
	dec c
	jr nz, .pokemonLogoTileLoop

; place tiles for the last row of the pokemon logo
	coord hl, 2, 10
	ld a, $31
	ld b, $10
.pokemonLogoLastTileRowLoop
	ld [hli], a
	inc a
	dec b
	jr nz, .pokemonLogoLastTileRowLoop



; put a pokeball in the player's hand
	ld hl, wOAMBuffer + $28
	ld a, $74
	ld [hl], a

; place tiles for title screen copyright
	coord hl, 5, 17
	ld de, .tileScreenCopyrightTiles
	ld b, $0A
.tileScreenCopyrightTilesLoop
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .tileScreenCopyrightTilesLoop

	jr .next

.tileScreenCopyrightTiles
	db $46,$47,$48,$49,$4a,$7f,$4b,$4c,$4d,$4e	
.tileScreenCopyrightTiles2
	db $41

.next
    coord hl, 9, 2
	ld de, .tileScreenCopyrightTiles2
	ld b, $0A
	ld a, [de]
	ld [hli], a
	call SaveScreenTilesToBuffer2
	call LoadScreenTilesFromBuffer2
	call EnableLCD
	ld a,BLASTOISE ; which Pokemon to show first on the title screen
	ld [wTitleMonSpecies], a
	ld a, (vBGMap0 + $300) / $100
	call TitleScreenCopyTileMapToVRAM
	call SaveScreenTilesToBuffer1
	ld a, $90
	ld [hWY], a
	call LoadScreenTilesFromBuffer2
	ld a, vBGMap0 / $100
	call TitleScreenCopyTileMapToVRAM
	ld b, SET_PAL_TITLE_SCREEN
	call RunPaletteCommand
	ld a, %00111111 ;  Hiki, Palette schermata titolo
	ld [rBGP], a
	ld a, %01111111
	ld [rOBP0], a
	ld [rOBP1], a
	xor a
	ld [hSCX], a
	

; make pokemon logo bounce up and down
	ld bc, hSCY ; background scroll Y
	ld hl, .TitleScreenPokemonLogoYScrolls
.bouncePokemonLogoLoop
	ld a, [hli]
	and a
	jr z, .finishedBouncingPokemonLogo
	ld d, a
	cp -3
	jr nz, .skipPlayingSound
	ld a, SFX_INTRO_CRASH
	call PlaySound
.skipPlayingSound
	ld a, [hli]
	ld e, a
	call .ScrollTitleScreenPokemonLogo
	jr .bouncePokemonLogoLoop

.TitleScreenPokemonLogoYScrolls:
; Controls the bouncing effect of the Pokemon logo on the title screen
	db -4,16  ; y scroll amount, number of times to scroll
	db 3,4
	db -3,4
	db 2,2
	db -2,2
	db 1,2
	db -1,2
	db 0      ; terminate list with 0

.ScrollTitleScreenPokemonLogo:
; Scrolls the Pokemon logo on the title screen to create the bouncing effect
; Scrolls d pixels e times
    call DelayFrame
	ld a, [bc] ; background scroll Y
	add d
	ld [bc], a
	dec e
	jr nz, .ScrollTitleScreenPokemonLogo
	ret

.finishedBouncingPokemonLogo
    call LoadScreenTilesFromBuffer1
	ld c, 36
	call DelayFrames
	ld a, SFX_INTRO_WHOOSH
	call PlaySound

; scroll game version in from the right
	call PrintGameVersionOnTitleScreen ; Hiki --- lost diaries
	ld a, SCREEN_WIDTH_PIXELS
	ld [hWY], a
	ld d, 144
.scrollTitleScreenGameVersionLoop
	ld h, d
	ld l, 8
	call ScrollTitleScreenGameVersion
	ld h, 0
	ld l, 90
	call ScrollTitleScreenGameVersion
	ld a, d
	add 1
	ld d, a
	and a
	jr nz, .scrollTitleScreenGameVersionLoop
	
	ld a, vBGMap1 / $100
	call TitleScreenCopyTileMapToVRAM
	call LoadScreenTilesFromBuffer2
	call PrintGameVersionOnTitleScreen
	;call DrawPlagueLabsLogo
    call Delay3
	call WaitForSoundToFinish
	ld a, MUSIC_TITLE_SCREEN
	ld [wNewSoundID], a
	call PlaySound
	xor a
	ld [wUnusedCC5B], a

; Keep scrolling in new mons indefinitely until the user performs input.
.awaitUserInterruptionLoop
    ;ld c, 200
	;call CheckForUserInterruption
	;jr c, .finishedWaiting
	call TitleScreenScrollInMon
	ld c, 1
	call CheckForUserInterruption
	jr c, .finishedWaiting
	callba TitleScreenAnimateBallIfStarterOut
	jr .awaitUserInterruptionLoop

.finishedWaiting
    call FlashScreen2
	ld a, %00111111   ;Hiki, Palette schermata titolo
	ld [rBGP], a
	call DrawPlayerCharacter
	ld a, $19
	call PlayCry
	call WaitForSoundToFinish
	;call ClearSprites
	;call DrawPlayerCharacter 
	xor a
	ld [hWY], a
	inc a
	ld [H_AUTOBGTRANSFERENABLED], a
	;call ClearScreen
	predef PredefShakeScreenVertically
	ld a, vBGMap0 / $100
	call TitleScreenCopyTileMapToVRAM
	ld a, vBGMap1 / $100
	call TitleScreenCopyTileMapToVRAM
	call Delay3
	;call LoadGBPal
	ld a, %00100111 ;  Hiki, Palette schermata titolo
	ld [rOBP0], a
	ld a, [hJoyHeld]
	ld b, a
	and D_UP | SELECT | B_BUTTON
	cp D_UP | SELECT | B_BUTTON
	jp z, .doClearSaveDialogue
	jp MainMenu

.doClearSaveDialogue
	jpba DoClearSaveDialogue

TitleScreenPickNewMon:
	ld a, vBGMap0 / $100
	call TitleScreenCopyTileMapToVRAM

.loop
; Keep looping until a mon different from the current one is picked.
	call Random
	and $f
	ld c, a
	ld b, 0
	ld hl, TitleMons
	add hl, bc
	ld a, [hl]
	ld hl, wTitleMonSpecies

; Can't be the same as before.
	cp [hl]
	jr z, .loop

	ld [hl], a
	call LoadTitleMonSprite

	ld a, $90
	ld [hWY], a
	ld d, 1 ; scroll out
	callba TitleScroll
	ret

TitleScreenScrollInMon:
	ld d, 0 ; scroll in
	;callba TitleScroll --- scroll dei mostri
	xor a
	ld [hWY], a
	ret

ScrollTitleScreenGameVersion:
.wait
	ld a, [rLY]
	cp l
	jr nz, .wait

	ld a, h
	ld [rSCY], a

.wait2
	ld a, [rLY]
	cp h
	jr z, .wait2
	ret


DrawPlayerCharacter:
   	ld de,Eye
	ld hl,vSprites
	lb bc, BANK(Eye), $14
	call CopyVideoData
    call ClearSprites
	xor a
	ld [wPlayerCharacterOAMTile], a
	ld hl, wOAMBuffer
	ld de, $7942
	ld b, 7
.loop
	push de
	ld c, 5
.innerLoop
	ld a, d
	ld [hli], a ; Y
	ld a, e
	ld [hli], a ; X
	add 8
	ld e, a
	ld a, [wPlayerCharacterOAMTile]
	ld [hli], a ; tile
	inc a
	ld [wPlayerCharacterOAMTile], a
	inc hl
	dec c
	jr nz, .innerLoop
	pop de
	ld a, 8
	add d
	ld d, a
	dec b
	jr nz, .loop
	ret
	
DrawPlagueLabsLogo:
	ld hl, GamefreakLogoGraphics
	ld de, vSprites - $50
	ld bc, GamefreakLogoGraphicsEnd - GamefreakLogoGraphics
	ld a, BANK(GamefreakLogoGraphics)
	call FarCopyData2
	ret

ClearBothBGMaps:
	ld hl, vBGMap0
	ld bc, $400 * 2
	ld a, " "
	jp FillMemory

LoadTitleMonSprite:
	ld [wcf91], a
	ld [wd0b5], a
	coord hl, 5, 10
	call GetMonHeader
	jp LoadFrontSpriteByMonIndex

TitleScreenCopyTileMapToVRAM:
	ld [H_AUTOBGTRANSFERDEST + 1], a
	jp Delay3

LoadCopyrightAndTextBoxTiles:
	xor a
	ld [hWY], a
	call ClearScreen
	call LoadTextBoxTilePatterns

LoadCopyrightTiles:
	ld de, NintendoCopyrightLogoGraphics
	ld hl, vChars2 + $600
	lb bc, BANK(NintendoCopyrightLogoGraphics), (GamefreakLogoGraphicsEnd - NintendoCopyrightLogoGraphics) / $10
	call CopyVideoData
	coord hl, 6, 6
	ld de, CopyrightTextString
	jp PlaceString

CopyrightTextString:
	db   $73,$74,$75,$76,$77,$78,$79,$7A,$7B             ; PLAGUE LABS
	db   "@"

INCLUDE "data/title_mons.asm"

; prints version text (red, blue)
PrintGameVersionOnTitleScreen:
	coord hl, 6, 12
	ld de, VersionOnTitleScreenText
	jp PlaceString

; these point to special tiles specifically loaded for that purpose and are not usual text
VersionOnTitleScreenText:
	db $60,$61,$7F,$65,$66,$67,$68,$69,"@" ; "Red Version"



NintenText: db "ME@"
SonyText:   db "EVILIO@"

FlashScreen2:
.dog
	ld hl, BattleTransition_FlashScreenPalettes2
.loop
	ld a, [hli]
	cp $1
	jr z, .done
	ld [rBGP], a
	ld c, 1
	call DelayFrames
	jr .loop
.done
	dec b
	jr nz, .dog
	ret

BattleTransition_FlashScreenPalettes2:
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $F9,$FE,$FF,$FE,$F9,$E4,$90,$40,$00,$40,$90,$E4
	db $01 ; terminator
	

	
