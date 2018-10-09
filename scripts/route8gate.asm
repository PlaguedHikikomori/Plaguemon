Route8GateScript:
	call EnableAutoTextBoxDrawing
	ld hl, Route8GateScriptPointers
	ld a, [wRoute8GateCurScript]
	jp CallFunctionInTable

Route8GateScriptPointers:
	dw Route8GateScript0
	dw Route8GateScript1

Route8GateScript_1e1d7:
	ld hl, wd730
	set 7, [hl]
	ld a, $10
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpriteStateData2 + $06], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route8GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1e22c
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	xor a
	ld [hJoyHeld], a
	callba RemoveGuardDrink
	ld a, [$ffdb]
	and a
	jr nz, .asm_1e220
	ld a, $2
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route8GateScript_1e1d7
	ld a, $1
	ld [wRoute8GateCurScript], a
	ret
.asm_1e220
	ld hl, wd728
	set 6, [hl]
	ld a, $3
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

CoordsData_1e22c:
	db 3,2
	db 4,2
	db $ff

Route8GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute8GateCurScript], a
	ret

Route8GateTextPointers:
	dw Route8GateText1
	dw Route8GateText2
	dw Route8GateText3
