SeafoamIslands3Script:
	call EnableAutoTextBoxDrawing
	ld hl, wFlags_0xcd60
	bit 7, [hl]
	res 7, [hl]
	jr z, .asm_4649e
	ld hl, Seafoam3HolesCoords
	call CheckBoulderCoords
	ret nc
	EventFlagAddress hl, EVENT_SEAFOAM3_BOULDER1_DOWN_HOLE
	ld a, [wCoordIndex]
	cp $1
	jr nz, .asm_4647c
	SetEventReuseHL EVENT_SEAFOAM3_BOULDER1_DOWN_HOLE
	ld a, HS_SEAFOAM_ISLANDS_3_BOULDER_1
	ld [wObjectToHide], a
	ld a, HS_SEAFOAM_ISLANDS_4_BOULDER_3
	ld [wObjectToShow], a
	jr .asm_46488
.asm_4647c
	SetEventAfterBranchReuseHL EVENT_SEAFOAM3_BOULDER2_DOWN_HOLE, EVENT_SEAFOAM3_BOULDER1_DOWN_HOLE
	ld a, HS_SEAFOAM_ISLANDS_3_BOULDER_2
	ld [wObjectToHide], a
	ld a, HS_SEAFOAM_ISLANDS_4_BOULDER_4
	ld [wObjectToShow], a
.asm_46488
	ld a, [wObjectToHide]
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, [wObjectToShow]
	ld [wMissableObjectIndex], a
	predef_jump ShowObject
.asm_4649e
	ld a, $a1
	ld [wDungeonWarpDestinationMap], a
	ld hl, Seafoam3HolesCoords
	jp IsPlayerOnDungeonWarp

Seafoam3HolesCoords:
	db $06,$13
	db $06,$16
	db $ff

SeafoamIslands3TextPointers:
	dw BoulderText
	dw BoulderText
