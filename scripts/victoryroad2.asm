VictoryRoad2Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, VictoryRoad2Script_517c4
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, VictoryRoad2Script_517c9
	call EnableAutoTextBoxDrawing
	ld hl, MoltresTrainerHeader
	ld de, VictoryRoad2ScriptPointers
	ld a, [wVictoryRoad2CurScript]
	call ExecuteCurMapScriptInTable
	ld [wVictoryRoad2CurScript], a
	ret

VictoryRoad2Script_517c4:
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH

VictoryRoad2Script_517c9:
	CheckEvent EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	jr z, .asm_517da
	push af
	ld a, $15
	lb bc, 4, 3
	call VictoryRoad2Script_517e2
	pop af
.asm_517da
	bit 7, a
	ret z
	ld a, $1d
	lb bc, 7, 11

VictoryRoad2Script_517e2:
	ld [wNewTileBlockID], a
	predef ReplaceTileBlock
	ret

VictoryRoad2ScriptPointers:
	dw VictoryRoad2Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

VictoryRoad2Script0:
	ld hl, CoordsData_51816
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	EventFlagAddress hl, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ld a, [wCoordIndex]
	cp $2
	jr z, .asm_5180b
	CheckEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ret nz
	jr .asm_51810
.asm_5180b
	CheckEventAfterBranchReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2
	ret nz
.asm_51810
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ret

CoordsData_51816:
	db $10,$01
	db $10,$09
	db $FF

VictoryRoad2TextPointers:
	dw MoltresText

MoltresTrainerHeader:
	dbEventFlagBit EVENT_BEAT_MOLTRES
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MOLTRES
	dw MoltresBattleText ; TextBeforeBattle
	dw MoltresBattleText ; TextAfterBattle
	dw MoltresBattleText ; TextEndBattle
	dw MoltresBattleText ; TextEndBattle

	db $ff

MoltresText:
	TX_ASM
	ld hl, MoltresTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MoltresBattleText:
	TX_FAR _MoltresBattleText
	TX_ASM
	ld a, MOLTRES
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
