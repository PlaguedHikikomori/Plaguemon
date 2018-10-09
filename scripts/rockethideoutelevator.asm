RocketHideoutElevatorScript:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	push hl
	call nz, RocketHideoutElevatorScript_4572c
	pop hl
	bit 7, [hl]
	res 7, [hl]
	call nz, RocketHideoutElevatorScript_4575f
	xor a
	ld [wAutoTextBoxDrawingControl], a
	inc a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ret

RocketHideoutElevatorScript_4572c:
	ld hl, wWarpEntries
	ld a, [wWarpedFromWhichWarp]
	ld b, a
	ld a, [wWarpedFromWhichMap]
	ld c, a
	call RocketHideoutElevatorScript_4573a

RocketHideoutElevatorScript_4573a:
	inc hl
	inc hl
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ret

RocketHideoutElevatorScript_45741:
	ld hl, RocketHideoutElavatorFloors
	call LoadItemList
	ld hl, RocketHideoutElevatorWarpMaps
	ld de, wElevatorWarpMaps
	ld bc, RocketHideoutElevatorWarpMapsEnd - RocketHideoutElevatorWarpMaps
	call CopyData
	ret

RocketHideoutElavatorFloors:
	db $03 ; num elements in list
	db FLOOR_B1F
	db FLOOR_B2F
	db FLOOR_B4F
	db $FF ; terminator

RocketHideoutElevatorWarpMaps:
; first byte is warp number
; second byte is map number
; These specify where the player goes after getting out of the elevator.
	db $04, ROCKET_HIDEOUT_1
	db $04, ROCKET_HIDEOUT_2
	db $02, ROCKET_HIDEOUT_4
RocketHideoutElevatorWarpMapsEnd:

RocketHideoutElevatorScript_4575f:
	call Delay3
	callba ShakeElevator
	ret

RocketHideoutElevatorTextPointers:
	dw RocketHideoutElevatorText1

RocketHideoutElevatorText1:
	TX_ASM
	ld b, LIFT_KEY
	call IsItemInBag
	jr z, .asm_45782
	call RocketHideoutElevatorScript_45741
	ld hl, RocketHideoutElevatorWarpMaps
	predef DisplayElevatorFloorMenu
	jr .asm_45788
.asm_45782
	ld hl, RocketHideoutElevatorText_4578b
	call PrintText
.asm_45788
	jp TextScriptEnd

RocketHideoutElevatorText_4578b:
	TX_FAR _RocketElevatorText_4578b
	TX_WAIT
	db "@"
