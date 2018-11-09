Mansion4Script:
	call Mansion4Script_523cf
	call EnableAutoTextBoxDrawing
	ld hl, Mansion4TrainerHeader0
	ld de, Mansion4ScriptPointers
	ld a, [wMansion4CurScript]
	call ExecuteCurMapScriptInTable
	ld [wMansion4CurScript], a
	ret

Mansion4Script_523cf:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jr nz, .asm_523ff
	ld a, $e
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $54
	ld bc, $808
	call Mansion2Script_5202f
	ret
.asm_523ff
	ld a, $2d
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $808
	call Mansion2Script_5202f
	ret

Mansion4Script_Switches:
	ld a, [wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ld [hJoyHeld], a
	ld a, $9
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

Mansion4ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Mansion4TextPointers:
	dw Mansion4Text1
	dw Mansion4Text2
	dw Mansion4Text3
	dw Mansion4Text4
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw Mansion3Text6      ;switch
	dw PickUpItemText
	dw Mansion4Text7      ;diario
	dw BibrodoText

Mansion4TrainerHeader0:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_0
	db ($1 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_0
	dw Mansion4BattleText1 ; TextBeforeBattle
	dw Mansion4AfterBattleText1 ; TextAfterBattle
	dw Mansion4EndBattleText1 ; TextEndBattle
	dw Mansion4EndBattleText1 ; TextEndBattle

Mansion4TrainerHeader1:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_1
	db ($1 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_1
	dw Mansion4BattleText2 ; TextBeforeBattle
	dw Mansion4AfterBattleText2 ; TextAfterBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	
Mansion4TrainerHeader2:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_2
	db ($1 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_2
	dw Mansion4BattleText2 ; TextBeforeBattle
	dw Mansion4AfterBattleText2 ; TextAfterBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	dw Mansion4EndBattleText2 ; TextEndBattle

	
Mansion4TrainerHeader3:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_3
	db ($3 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_3
	dw Mansion4BattleText2 ; TextBeforeBattle
	dw Mansion4AfterBattleText2 ; TextAfterBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	
BibrodoTrainerHeader:
	dbEventFlagBit EVENT_BEAT_BIBRODO, 1
	db 0 ; view range
	dwEventFlagAddress EVENT_BEAT_BIBRODO, 1
	dw BibrodoBattleText ; TextBeforeBattle
	dw BibrodoBattleText ; TextAfterBattle
	dw BibrodoBattleText ; TextEndBattle
	dw BibrodoBattleText ; TextEndBattle

	db $ff

Mansion4Text1:
	TX_ASM
	ld hl, Mansion4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Mansion4Text2:
	TX_ASM
	ld hl, Mansion4TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd
	
Mansion4Text3:
	TX_ASM
	ld hl, Mansion4TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Mansion4Text4:
	TX_ASM
	ld hl, Mansion4TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Mansion4BattleText1:
	TX_FAR _Mansion4BattleText1
	db "@"

Mansion4EndBattleText1:
	TX_FAR _Mansion4EndBattleText1
	db "@"

Mansion4AfterBattleText1:
	TX_FAR _Mansion4AfterBattleText1
	db "@"

Mansion4BattleText2:
	TX_FAR _Mansion4BattleText2
	db "@"

Mansion4EndBattleText2:
	TX_FAR _Mansion4EndBattleText2
	db "@"

Mansion4AfterBattleText2:
	TX_FAR _Mansion4AfterBattleText2
	db "@"
	
Mansion4BattleText3:
	TX_FAR _Mansion4BattleText3
	db "@"

Mansion4EndBattleText3:
	TX_FAR _Mansion4EndBattleText3
	db "@"

Mansion4AfterBattleText3:
	TX_FAR _Mansion4AfterBattleText3
	db "@"

Mansion4BattleText4:
	TX_FAR _Mansion4BattleText4
	db "@"

Mansion4EndBattleText4:
	TX_FAR _Mansion4EndBattleText4
	db "@"

Mansion4AfterBattleText4:
	TX_FAR _Mansion4AfterBattleText4
	db "@"

Mansion4Text7:
	TX_FAR _Mansion4Text7
	db "@"
	
BibrodoText:
	TX_ASM
	ld hl, BibrodoTrainerHeader
	call TalkToTrainer
	ld a, [wCurMapScript]
	ld [wMansion4CurScript], a
	jp TextScriptEnd

BibrodoBattleText:
	TX_FAR _BibrodoBattleText
	TX_ASM
	ld a, BIBRODO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

_BibrodoBattleText::
	text "OBEY TO ME!"
	done
