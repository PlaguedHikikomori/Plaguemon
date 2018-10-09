SeafoamIslands1Script:
	ld a, [wSimulatedJoypadStatesIndex]
	ld b, a
	cp $1
	call z, SeaFoamIslands1Script_46872
	ld a, b
	and a
	ret nz
	ld a, $0
	ld [wSeafoamIslands5CurScript], a
	ret

SeaFoamIslands1Script_46872:
	xor a
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	jp ForceBikeOrSurf

SeafoamIslands1TextPointers:
	dw ArticunoText2
	dw SeafoamIslands1Text4
	dw SeafoamIslands1Text5

ArticunoTrainerHeader2:
	dbEventFlagBit EVENT_BEAT_ARTICUNO
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_ARTICUNO
	dw ArticunoBattleText2 ; TextBeforeBattle
	dw ArticunoBattleText2 ; TextAfterBattle
	dw ArticunoBattleText2 ; TextEndBattle
	dw ArticunoBattleText2 ; TextEndBattle

	db $ff

ArticunoText2:
	TX_ASM
	ld hl, ArticunoTrainerHeader2
	call TalkToTrainer
	ld a, $4
	ld [wSeafoamIslands5CurScript], a
	jp TextScriptEnd

ArticunoBattleText2:
	TX_FAR _ArticunoBattleText
	TX_ASM
	ld a, ARTICUNO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

SeafoamIslands1Text4:
	TX_FAR _SeafoamIslands5Text4
	db "@"

SeafoamIslands1Text5:
	TX_FAR _SeafoamIslands5Text5
	db "@"
