MainMenu:
; Check save file
    call InitOptions
	xor a
	ld [wOptionsInitialized],a
	inc a
	ld [wSaveFileStatus],a
	call CheckForPlayerNameInSRAM
	jr nc,.mainMenuLoop

	predef LoadSAV
	callba DeleteAllWrongEntries ; delete al wrong entries on the pokédex

.mainMenuLoop
	ld c,20
	call DelayFrames
	xor a ; LINK_STATE_NONE
	ld [wLinkState],a
	ld hl,wPartyAndBillsPCSavedMenuItem
	ld [hli],a
	ld [hli],a
	ld [hli],a
	ld [hl],a
	ld [wDefaultMap],a
	ld hl,wd72e
	res 6,[hl]
	call ClearScreen
	call RunDefaultPaletteCommand
	ld a, %00010011
	ld [rBGP], a
	call LoadTextBoxTilePatterns
	call LoadFontTilePatterns
	ld hl,wd730
	set 6,[hl]
	ld a,[wSaveFileStatus]
	cp a,1
	jr z,.noSaveFile
; there's a save file
	coord hl, 3, 0
	ld b,6
	ld c,13
	call TextBoxBorder
	coord hl, 5, 2
	ld de,ContinueText
	call PlaceString
	coord hl, 11, 8  ;version
	ld de,VersionText
	call PlaceString
	coord hl, 9, 9  ;build
	ld de,BuildText
	call PlaceString
	jr .next2
.noSaveFile
	coord hl, 3, 0
	ld b,4
	ld c,13
	call TextBoxBorder
	coord hl, 5, 2
	ld de,NewGameText
	call PlaceString
	coord hl, 11, 6     ;version
	ld de,VersionText
	call PlaceString 
	coord hl, 9, 7  ;build
	ld de,BuildText
	call PlaceString
.next2
	ld hl,wd730
	res 6,[hl]
	call UpdateSprites
	xor a
	ld [wCurrentMenuItem],a
	ld [wLastMenuItem],a
	ld [wMenuJoypadPollCount],a
	inc a
	ld [wTopMenuItemX],a
	inc a
	ld [wTopMenuItemY],a
	ld a,A_BUTTON | B_BUTTON | START
	ld [wMenuWatchedKeys],a
	ld a,[wSaveFileStatus]
	ld [wMaxMenuItem],a
	call HandleMenuInput
	bit 1,a ; pressed B?
	jp nz,DisplayTitleScreen ; if so, go back to the title screen
	ld c,20
	call DelayFrames
	ld a,[wCurrentMenuItem]
	ld b,a
	ld a,[wSaveFileStatus]
	cp a,2
	jp z,.skipInc
; If there's no save file, increment the current menu item so that the numbers
; are the same whether or not there's a save file.
	inc b
.skipInc
	ld a,b
	and a
	jr z,.choseContinue
	;call ClearSprites
	cp a,1
	jp z,StartNewGame
	call DisplayOptionMenu
	ld a,1
	ld [wOptionsInitialized],a
	jp .mainMenuLoop
.choseContinue
    call ClearSprites
	call DisplayContinueGameInfo
	ld hl,wCurrentMapScriptFlags
	set 5,[hl]
.inputLoop
	xor a
	ld [hJoyPressed],a
	ld [hJoyReleased],a
	ld [hJoyHeld],a
	call Joypad
	ld a,[hJoyHeld]
	bit 0,a
	jr nz,.pressedA
	bit 1,a
	jp nz,.mainMenuLoop ; pressed B
	jr .inputLoop
.pressedA
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	ld a,PLAYER_DIR_DOWN
	ld [wPlayerDirection],a
	ld c,10
	call DelayFrames
	ld a,[wNumHoFTeams]
	and a
	jp z,SpecialEnterMap
	ld a,[wCurMap] ; map ID
	cp a,HALL_OF_FAME
	jp nz,SpecialEnterMap
	xor a
	ld [wDestinationMap],a
	ld hl,wd732
	set 2,[hl] ; fly warp or dungeon warp
	call SpecialWarpIn
	jp SpecialEnterMap

InitOptions:
	ld a,1 ; no delay
	ld [wLetterPrintingDelayFlags],a
	ld a,3 ; medium speed
	ld [wOptions],a
	ret

LinkMenu:
	xor a
	ld [wLetterPrintingDelayFlags], a
	ld hl, wd72e
	set 6, [hl]
	ld hl, TextTerminator_6b20
	call PrintText
	call SaveScreenTilesToBuffer1
	ld hl, WhereWouldYouLikeText
	call PrintText
	coord hl, 5, 5
	ld b, $6
	ld c, $d
	call TextBoxBorder
	call UpdateSprites
	coord hl, 7, 7
	ld de, CableClubOptionsText
	call PlaceString
	xor a
	ld [wUnusedCD37], a
	ld [wd72d], a
	ld hl, wTopMenuItemY
	ld a, $7
	ld [hli], a
	ld a, $6
	ld [hli], a
	xor a
	ld [hli], a
	inc hl
	ld a, $2
	ld [hli], a
	inc a
	; ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a
.waitForInputLoop
	call HandleMenuInput
	and A_BUTTON | B_BUTTON
	add a
	add a
	ld b, a
	ld a, [wCurrentMenuItem]
	add b
	add $d0
	ld [wLinkMenuSelectionSendBuffer], a
	ld [wLinkMenuSelectionSendBuffer + 1], a
.exchangeMenuSelectionLoop
	call Serial_ExchangeLinkMenuSelection
	ld a, [wLinkMenuSelectionReceiveBuffer]
	ld b, a
	and $f0
	cp $d0
	jr z, .asm_5c7d
	ld a, [wLinkMenuSelectionReceiveBuffer + 1]
	ld b, a
	and $f0
	cp $d0
	jr nz, .exchangeMenuSelectionLoop
.asm_5c7d
	ld a, b
	and $c ; did the enemy press A or B?
	jr nz, .enemyPressedAOrB
; the enemy didn't press A or B
	ld a, [wLinkMenuSelectionSendBuffer]
	and $c ; did the player press A or B?
	jr z, .waitForInputLoop ; if neither the player nor the enemy pressed A or B, try again
	jr .doneChoosingMenuSelection ; if the player pressed A or B but the enemy didn't, use the player's selection
.enemyPressedAOrB
	ld a, [wLinkMenuSelectionSendBuffer]
	and $c ; did the player press A or B?
	jr z, .useEnemyMenuSelection ; if the enemy pressed A or B but the player didn't, use the enemy's selection
; the enemy and the player both pressed A or B
; The gameboy that is clocking the connection wins.
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .doneChoosingMenuSelection
.useEnemyMenuSelection
	ld a, b
	ld [wLinkMenuSelectionSendBuffer], a
	and $3
	ld [wCurrentMenuItem], a
.doneChoosingMenuSelection
	ld a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .skipStartingTransfer
	call DelayFrame
	call DelayFrame
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
.skipStartingTransfer
	ld b, $7f
	ld c, $7f
	ld d, $ec
	ld a, [wLinkMenuSelectionSendBuffer]
	and (B_BUTTON << 2) ; was B button pressed?
	jr nz, .updateCursorPosition
; A button was pressed
	ld a, [wCurrentMenuItem]
	cp $2
	jr z, .updateCursorPosition
	ld c, d
	ld d, b
	dec a
	jr z, .updateCursorPosition
	ld b, c
	ld c, d
.updateCursorPosition
	ld a, b
	Coorda 6, 7
	ld a, c
	Coorda 6, 9
	ld a, d
	Coorda 6, 11
	ld c, 40
	call DelayFrames
	call LoadScreenTilesFromBuffer1
	ld a, [wLinkMenuSelectionSendBuffer]
	and (B_BUTTON << 2) ; was B button pressed?
	jr nz, .choseCancel ; cancel if B pressed
	ld a, [wCurrentMenuItem]
	cp $2
	jr z, .choseCancel
	xor a
	ld [wWalkBikeSurfState], a ; start walking
	ld a, [wCurrentMenuItem]
	and a
	ld a, COLOSSEUM
	jr nz, .next
	ld a, TRADE_CENTER
.next
	ld [wd72d], a
	ld hl, PleaseWaitText
	call PrintText
	ld c, 50
	call DelayFrames
	ld hl, wd732
	res 1, [hl]
	ld a, [wDefaultMap]
	ld [wDestinationMap], a
	call SpecialWarpIn
	ld c, 20
	call DelayFrames
	xor a
	ld [wMenuJoypadPollCount], a
	ld [wSerialExchangeNybbleSendData], a
	inc a ; LINK_STATE_IN_CABLE_CLUB
	ld [wLinkState], a
	ld [wEnteringCableClub], a
	jr SpecialEnterMap
.choseCancel
	xor a
	ld [wMenuJoypadPollCount], a
	call Delay3
	call CloseLinkConnection
	ld hl, LinkCanceledText
	call PrintText
	ld hl, wd72e
	res 6, [hl]
	ret

WhereWouldYouLikeText:
	TX_FAR _WhereWouldYouLikeText
	db "@"

PleaseWaitText:
	TX_FAR _PleaseWaitText
	db "@"

LinkCanceledText:
	TX_FAR _LinkCanceledText
	db "@"

StartNewGame:
   	ld hl, wd732
	res 1, [hl]
	call ClearSprites
	call OakSpeech
	ld c, 20
	call DelayFrames

; enter map after using a special warp or loading the game from the main menu
SpecialEnterMap:
	xor a
	ld [hJoyPressed], a
	ld [hJoyHeld], a
	ld [hJoy5], a
	ld [wd72d], a
	ld hl, wd732
	set 0, [hl] ; count play time
	call ResetPlayerSpriteData
	ld c, 20
	call DelayFrames
	ld a, [wEnteringCableClub]
	and a
	ret nz
	jp EnterMap

ContinueText:
	db "CONTINUE", $4e

NewGameText:
	db   "NEW GAME"
	next "OPTION@"

CableClubOptionsText:
	db   "TRADE CENTER"
	next "COLOSSEUM"
	next "CANCEL@"
	
VersionText:
	db "v 0.666"
	db "@"
	
BuildText:
	db "build 3.2"
	db "@"

DisplayContinueGameInfo:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 4, 7
	ld b, 8
	ld c, 14
	call TextBoxBorder
	coord hl, 5, 9
	ld de, SaveScreenInfoText
	call PlaceString
	coord hl, 12, 9
	ld de, wPlayerName
	call PlaceString
	coord hl, 17, 11
	call PrintNumBadges
	coord hl, 16, 13
	call PrintNumOwnedMons
	coord hl, 13, 15
	call PrintPlayTime
	ld a, 1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld c, 30
	jp DelayFrames

PrintSaveScreenText:
	xor a
	ld [H_AUTOBGTRANSFERENABLED], a
	coord hl, 4, 0
	ld b, $8
	ld c, $e
	call TextBoxBorder
	call LoadTextBoxTilePatterns
	call UpdateSprites
	coord hl, 5, 2
	ld de, SaveScreenInfoText
	call PlaceString
	coord hl, 12, 2
	ld de, wPlayerName
	call PlaceString
	coord hl, 17, 4
	call PrintNumBadges
	coord hl, 16, 6
	call PrintNumOwnedMons
	coord hl, 13, 8
	call PrintPlayTime
	ld a, $1
	ld [H_AUTOBGTRANSFERENABLED], a
	ld c, 30
	jp DelayFrames

PrintNumBadges:
	push hl
	ld hl, wObtainedBadges
	ld b, $1
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 2
	jp PrintNumber

PrintNumOwnedMons:
	push hl
	callba CountTotalCaughtPokemons
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 3
	jp PrintNumber

PrintPlayTime:
	ld de, wPlayTimeHours
	lb bc, 1, 3
	call PrintNumber
	ld [hl], $6d
	inc hl
	ld de, wPlayTimeMinutes
	lb bc, LEADING_ZEROES | 1, 2
	jp PrintNumber

SaveScreenInfoText:
	db   "PLAYER"
	next "BADGES    "
	next "#DEX    "
	next "TIME@"

DisplayOptionMenu:
	coord hl, 0, 0
	ld b,3
	ld c,18
	call TextBoxBorder
	coord hl, 0, 5
	ld b,3
	ld c,18
	call TextBoxBorder
	coord hl, 0, 10
	ld b,3
	ld c,18
	call TextBoxBorder
	coord hl, 1, 1
	ld de,TextSpeedOptionText
	call PlaceString
	coord hl, 1, 6
	ld de,BattleAnimationOptionText
	call PlaceString
	coord hl, 1, 11
	ld de,BattleStyleOptionText
	call PlaceString
	coord hl, 2, 16
	ld de,OptionMenuCancelText
	call PlaceString
	xor a
	ld [wCurrentMenuItem],a
	ld [wLastMenuItem],a
	inc a
	ld [wLetterPrintingDelayFlags],a
	ld [wUnusedCD40],a
	ld a,3 ; text speed cursor Y coordinate
	ld [wTopMenuItemY],a
	call SetCursorPositionsFromOptions
	ld a,[wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld [wTopMenuItemX],a
	ld a,$01
	ld [H_AUTOBGTRANSFERENABLED],a ; enable auto background transfer
	call Delay3
.loop
	call PlaceMenuCursor
	call SetOptionsFromCursorPositions
.getJoypadStateLoop
	call JoypadLowSensitivity
	ld a,[hJoy5]
	ld b,a
	and a,A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT | D_UP | D_DOWN ; any key besides select pressed?
	jr z,.getJoypadStateLoop
	bit 1,b ; B button pressed?
	jr nz,.exitMenu
	bit 3,b ; Start button pressed?
	jr nz,.exitMenu
	bit 0,b ; A button pressed?
	jr z,.checkDirectionKeys
	ld a,[wTopMenuItemY]
	cp a,16 ; is the cursor on Cancel?
	jr nz,.loop
.exitMenu
	ld a,SFX_PRESS_AB
	call PlaySound
	ret
.eraseOldMenuCursor
	ld [wTopMenuItemX],a
	call EraseMenuCursor
	jp .loop
.checkDirectionKeys
	ld a,[wTopMenuItemY]
	bit 7,b ; Down pressed?
	jr nz,.downPressed
	bit 6,b ; Up pressed?
	jr nz,.upPressed
	cp a,8 ; cursor in Battle Animation section?
	jr z,.cursorInBattleAnimation
	cp a,13 ; cursor in Battle Style section?
	jr z,.cursorInBattleStyle
	cp a,16 ; cursor on Cancel?
	jr z,.loop
.cursorInTextSpeed
	bit 5,b ; Left pressed?
	jp nz,.pressedLeftInTextSpeed
	jp .pressedRightInTextSpeed
.downPressed
	cp a,16
	ld b,-13
	ld hl,wOptionsTextSpeedCursorX
	jr z,.updateMenuVariables
	ld b,5
	cp a,3
	inc hl
	jr z,.updateMenuVariables
	cp a,8
	inc hl
	jr z,.updateMenuVariables
	ld b,3
	inc hl
	jr .updateMenuVariables
.upPressed
	cp a,8
	ld b,-5
	ld hl,wOptionsTextSpeedCursorX
	jr z,.updateMenuVariables
	cp a,13
	inc hl
	jr z,.updateMenuVariables
	cp a,16
	ld b,-3
	inc hl
	jr z,.updateMenuVariables
	ld b,13
	inc hl
.updateMenuVariables
	add b
	ld [wTopMenuItemY],a
	ld a,[hl]
	ld [wTopMenuItemX],a
	call PlaceUnfilledArrowMenuCursor
	jp .loop
.cursorInBattleAnimation
	ld a,[wOptionsBattleAnimCursorX] ; battle animation cursor X coordinate
	xor a,$0b ; toggle between 1 and 10
	ld [wOptionsBattleAnimCursorX],a
	jp .eraseOldMenuCursor
.cursorInBattleStyle
	ld a,[wOptionsBattleStyleCursorX] ; battle style cursor X coordinate
	xor a,$0b ; toggle between 1 and 10
	ld [wOptionsBattleStyleCursorX],a
	jp .eraseOldMenuCursor
.pressedLeftInTextSpeed
	ld a,[wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	cp a,1
	jr z,.updateTextSpeedXCoord
	cp a,7
	jr nz,.fromSlowToMedium
	sub a,6
	jr .updateTextSpeedXCoord
.fromSlowToMedium
	sub a,7
	jr .updateTextSpeedXCoord
.pressedRightInTextSpeed
	ld a,[wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	cp a,14
	jr z,.updateTextSpeedXCoord
	cp a,7
	jr nz,.fromFastToMedium
	add a,7
	jr .updateTextSpeedXCoord
.fromFastToMedium
	add a,6
.updateTextSpeedXCoord
	ld [wOptionsTextSpeedCursorX],a ; text speed cursor X coordinate
	jp .eraseOldMenuCursor

TextSpeedOptionText:
	db   "TEXT SPEED"
	next " FAST  MEDIUM SLOW@"

BattleAnimationOptionText:
	db   "BATTLE ANIMATION"
	next " ON       OFF@"

BattleStyleOptionText:
	db   "BATTLE STYLE"
	next " SHIFT    SET@"

OptionMenuCancelText:
	db "CANCEL@"

; sets the options variable according to the current placement of the menu cursors in the options menu
SetOptionsFromCursorPositions:
	ld hl,TextSpeedOptionData
	ld a,[wOptionsTextSpeedCursorX] ; text speed cursor X coordinate
	ld c,a
.loop
	ld a,[hli]
	cp c
	jr z,.textSpeedMatchFound
	inc hl
	jr .loop
.textSpeedMatchFound
	ld a,[hl]
	ld d,a
	ld a,[wOptionsBattleAnimCursorX] ; battle animation cursor X coordinate
	dec a
	jr z,.battleAnimationOn
.battleAnimationOff
	set 7,d
	jr .checkBattleStyle
.battleAnimationOn
	res 7,d
.checkBattleStyle
	ld a,[wOptionsBattleStyleCursorX] ; battle style cursor X coordinate
	dec a
	jr z,.battleStyleShift
.battleStyleSet
	set 6,d
	jr .storeOptions
.battleStyleShift
	res 6,d
.storeOptions
	ld a,d
	ld [wOptions],a
	ret

; reads the options variable and places menu cursors in the correct positions within the options menu
SetCursorPositionsFromOptions:
	ld hl,TextSpeedOptionData + 1
	ld a,[wOptions]
	ld c,a
	and a,$3f
	push bc
	ld de,2
	call IsInArray
	pop bc
	dec hl
	ld a,[hl]
	ld [wOptionsTextSpeedCursorX],a ; text speed cursor X coordinate
	coord hl, 0, 3
	call .placeUnfilledRightArrow
	sla c
	ld a,1 ; On
	jr nc,.storeBattleAnimationCursorX
	ld a,10 ; Off
.storeBattleAnimationCursorX
	ld [wOptionsBattleAnimCursorX],a ; battle animation cursor X coordinate
	coord hl, 0, 8
	call .placeUnfilledRightArrow
	sla c
	ld a,1
	jr nc,.storeBattleStyleCursorX
	ld a,10
.storeBattleStyleCursorX
	ld [wOptionsBattleStyleCursorX],a ; battle style cursor X coordinate
	coord hl, 0, 13
	call .placeUnfilledRightArrow
; cursor in front of Cancel
	coord hl, 0, 16
	ld a,1
.placeUnfilledRightArrow
	ld e,a
	ld d,0
	add hl,de
	ld [hl],$ec ; unfilled right arrow menu cursor
	ret

; table that indicates how the 3 text speed options affect frame delays
; Format:
; 00: X coordinate of menu cursor
; 01: delay after printing a letter (in frames)
TextSpeedOptionData:
	db 14,5 ; Slow
	db  7,3 ; Medium
	db  1,1 ; Fast
	db 7 ; default X coordinate (Medium)
	db $ff ; terminator

CheckForPlayerNameInSRAM:
; Check if the player name data in SRAM has a string terminator character
; (indicating that a name may have been saved there) and return whether it does
; in carry.
	ld a, SRAM_ENABLE
	ld [MBC1SRamEnable], a
	ld a, $1
	ld [MBC1SRamBankingMode], a
	ld [MBC1SRamBank], a
	ld b, NAME_LENGTH
	ld hl, sPlayerName
.loop
	ld a, [hli]
	cp "@"
	jr z, .found
	dec b
	jr nz, .loop
; not found
	xor a
	ld [MBC1SRamEnable], a
	ld [MBC1SRamBankingMode], a
	and a
	ret
.found
	xor a
	ld [MBC1SRamEnable], a
	ld [MBC1SRamBankingMode], a
	scf
	ret
