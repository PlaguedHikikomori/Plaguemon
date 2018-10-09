LavenderHouse2Script:
	call EnableAutoTextBoxDrawing
	ld a, %11100100 ; inverted palette for silhouette effect
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ld c, 4
	call DelayFrames
	ld a, %00011011 ; inverted palette for silhouette effect
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ld a, [hJoyPressed]
	cp A_BUTTON
	jr nz, .other2
	ld a, SFX_SNARE_2
	call PlaySound
.other2
	ld a, [hJoyPressed]
	cp B_BUTTON 
	jr nz, .other
	ld a, SFX_GO_INSIDE
	call PlaySound
.other
	ld a, [hJoyPressed]
	cp D_LEFT
	jr nz, .other3
	ld a, SFX_TINK
	call PlaySound
.other3
	ld a, [hJoyPressed]
	cp D_RIGHT
	jr nz, .other4
	ld a, SFX_POISONED
	call PlaySound
.other4
    ld a, [hJoyPressed]
	cp SELECT
	jr nz, .return
	ld a, SFX_PUSH_BOULDER
	call PlaySound
.return
	ret

LavenderHouse2TextPointers:
	dw LavenderHouse2Text1
	dw LavenderHouse2Text2

LavenderHouse2Text1:
	TX_FAR _LavenderHouse2Text1
	TX_ASM
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

LavenderHouse2Text2:
	TX_ASM
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .asm_65711
	ld hl, LavenderHouse2Text_1d9dc
	call PrintText
	jr .asm_64be1
.asm_65711
	ld hl, LavenderHouse2Text_1d9e1
	call PrintText
.asm_64be1
	jp TextScriptEnd

LavenderHouse2Text_1d9dc:
	TX_FAR _LavenderHouse2Text_1d9dc
	db "@"

LavenderHouse2Text_1d9e1:
	TX_FAR _LavenderHouse2Text_1d9e1
	db "@"
