SecretLabScript:
	call EnableAutoTextBoxDrawing
	ld hl, MewTrainerHeader
	ld de, .ScriptPointers
	ld a, [wSecretLabCurScript]
	call ExecuteCurMapScriptInTable
	ld [wSecretLabCurScript], a
	ret

.ScriptPointers
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SecretLabTextPointers:
	dw MewText
	dw PickUpItemText
	dw PickUpItemText

MewTrainerHeader:
	dbEventFlagBit EVENT_BEAT_MEW
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MEW
	dw MewBattleText ; TextBeforeBattle
	dw MewBattleText ; TextAfterBattle
	dw MewBattleText ; TextEndBattle
	dw MewBattleText ; TextEndBattle

	db $ff

MewText:
	TX_ASM
	ld hl, MewTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MewBattleText:
	TX_FAR _MewtwoBattleText
	TX_ASM
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd