Route15Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route15TrainerHeader0
	ld de, Route15ScriptPointers
	ld a, [wRoute15CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute15CurScript], a
	ret

Route15ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route15TextPointers:
	dw Route15Text1
	dw Route15Text2

Route15TrainerHeader0:
	dbEventFlagBit EVENT_BEAT_ROUTE_15_TRAINER_0
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_ROUTE_15_TRAINER_0
	dw Route15BattleText1 ; TextBeforeBattle
	dw Route15AfterBattleText1 ; TextAfterBattle
	dw Route15EndBattleText1 ; TextEndBattle
	dw Route15EndBattleText1 ; TextEndBattle

	db $ff

Route15BattleText1:
	TX_FAR _Route15BattleText1
	db "@"

Route15EndBattleText1:
	TX_FAR _Route15EndBattleText1
	db "@"

Route15AfterBattleText1:
	TX_FAR _Route15AfterBattleText1
	db "@"

Route15Text1:
	TX_ASM
	ld hl, Route15TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route15Text2:
	TX_FAR _Route15Text2
	db "@"
