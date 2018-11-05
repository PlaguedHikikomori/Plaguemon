Route16Script:
	call EnableAutoTextBoxDrawing
	ld hl, $0000
	ld de, Route16ScriptPointers
	ld a, [wRoute16CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute16CurScript], a
	ret

Route16Script_59946:
	xor a
	ld [wJoyIgnore], a
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16ScriptPointers:
	dw Route16Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route16Script3

Route16Script0:
	CheckEventHL EVENT_BEAT_ROUTE16_SNORLAX
	jp nz, CheckFightingMapTrainers
	CheckEventReuseHL EVENT_FIGHT_ROUTE16_SNORLAX
	ResetEventReuseHL EVENT_FIGHT_ROUTE16_SNORLAX
	jp z, CheckFightingMapTrainers
	ld a, $2
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SNORLAX
	ld [wCurOpponent], a
	ld a, 30
	ld [wCurEnemyLVL], a
	ld a, HS_ROUTE_16_SNORLAX
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	ld a, $3
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route16Script_59946
	call UpdateSprites
	ld a, [wBattleResult]
	cp $2
	jr z, .asm_599a8
	ld a, $3
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
.asm_599a8
	SetEvent EVENT_BEAT_ROUTE16_SNORLAX
	call Delay3
	ld a, $0
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16TextPointers:
	dw Route16Text1
	dw Route16Text2
	dw Route16Text3
	dw Route16Text4
	dw Route16Text5

Route16Text1:
	TX_FAR _Route16Text1
	db "@"
	
Route16Text2:
	TX_FAR _Route16Text2
	db "@"

Route16Text3:
	TX_FAR _Route16Text3
	db "@"
	
Route16Text4:
	TX_FAR _Route16Text4
	db "@"

Route16Text5:
	TX_FAR _Route16Text5
	db "@"
