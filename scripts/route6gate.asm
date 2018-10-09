Route6GateScript:
	call EnableAutoTextBoxDrawing
	ld hl, Route6GateScriptPointers
	ld a, [wRoute6GateCurScript]
	call CallFunctionInTable
	ret

Route6GateScriptPointers:
	dw Route6GateScript0
	dw Route6GateScript1

Route6GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1e08c
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	xor a
	ld [hJoyHeld], a
	callba RemoveGuardDrink
	ld a, [$ffdb]
	and a
	jr nz, .asm_1e080
	ld a, $2
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route6GateScript_1e0a1
	ld a, $1
	ld [wRoute6GateCurScript], a
	ret
.asm_1e080
	ld hl, wd728
	set 6, [hl]
	ld a, $3
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

CoordsData_1e08c:
	db $02,$03
	db $02,$04,$FF

Route6GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute6GateCurScript], a
	ret

Route6GateScript_1e0a1:
	ld hl, wd730
	set 7, [hl]
	ld a, $80
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpriteStateData2 + $06], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route6GateTextPointers:
	dw Route6GateText1
	dw Route6GateText2
	dw Route6GateText3
