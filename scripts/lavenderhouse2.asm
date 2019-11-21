LavenderHouse2Script:
	call EnableAutoTextBoxDrawing
	ld a, [hJoyPressed]
	cp A_BUTTON
	jr nz, .other2
	ldpikacry e, PikachuCry1
	callab PlayPikachuSoundClip3
.other2
	ld a, [hJoyPressed]
	cp B_BUTTON 
	jr nz, .other
	ldpikacry e, PikachuCry1
	callab PlayPikachuSoundClip4
.other
	ld a, [hJoyPressed]
	cp D_LEFT
	jr nz, .other3
	ldpikacry e, PikachuCry2
	callab PlayPikachuSoundClip3
.other3
	ld a, [hJoyPressed]
	cp D_RIGHT
	jr nz, .other4
	ldpikacry e, PikachuCry2
	callab PlayPikachuSoundClip4
.other4
    ld a, [hJoyPressed]
	cp SELECT
	jr nz, .return
	ld a, SFX_PUSH_BOULDER
	call PlaySound
.return
    ld c, 2
	call DelayFrames
	ld a, %11111111 ; inverted palette for silhouette effect
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ld c, 2
	call DelayFrames
	ld a, %11100100 ; inverted palette for silhouette effect
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
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
