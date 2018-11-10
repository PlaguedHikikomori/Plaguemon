AnimateBoulderDust:
	ld a, [wUpdateSpritesEnabled]
	push af
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, %11100100
	ld [rOBP1], a
	ld a, [wWhichAnimationOffsets] ; which animation?
	cp $02
	jr z, .loadBullet
	callba LoadSmokeTileFourTimes
	jr .writeAnimation
.loadBullet
	ld b, $01
	callab LoadRightCoordinates
	callba WriteBulletAnimationOAMBlock
	jr .wrote
.writeAnimation
	callba WriteCutOrBoulderDustAnimationOAMBlock
.wrote
	ld a, [wAnimationDuration] ; get the animation duration
	ld c, a ; number of steps in animation
.loop
	push bc
	call GetMoveBoulderDustFunctionPointer
	ld bc, .returnAddress
	push bc
	ld c, 4
	jp hl
.returnAddress
	ld a, [rOBP1]
	xor %01100100
	ld [rOBP1], a
	call Delay3
	pop bc
	dec c
	jr nz, .loop
	pop af
	ld [wUpdateSpritesEnabled], a
	jp LoadPlayerSpriteGraphics

GetMoveBoulderDustFunctionPointer:
	ld a, [wWhichAnimationOffsets] ; which animation?
	cp $02
	ld hl, ShootBulletFunctionPointerTable
	jr z, .set
	ld hl, MoveBoulderDustFunctionPointerTable
.set
	ld a, [wSpriteStateData1 + 9] ; player's sprite facing direction
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hli]
	ld [wCoordAdjustmentAmount], a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld hl, wOAMBuffer + $90
	ld d, $0
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ret

MoveBoulderDustFunctionPointerTable:
; facing down
	db $FF,$00
	dw AdjustOAMBlockYPos

; facing up
	db $01,$00
	dw AdjustOAMBlockYPos

; facing left
	db $01,$01
	dw AdjustOAMBlockXPos

; facing right
	db $FF,$01
	dw AdjustOAMBlockXPos

ShootBulletFunctionPointerTable:
; facing down
	db $09,$00
	dw AdjustOAMBlockXPos

; facing up
	db $F7,$00
	dw AdjustOAMBlockYPos

; facing left
	db $F7,$01
	dw AdjustOAMBlockXPos

; facing right
	db $09,$01
	dw AdjustOAMBlockXPos
