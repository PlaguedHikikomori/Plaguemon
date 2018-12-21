SpaceWorldScript:
	ld a, REDS_HOUSE_2F
	ld [wLastMap], a
    call EnableAutoTextBoxDrawing
	call ProduceSine
	pop de
	call NPCBullet
	ret
	
	
Shmup1:

	INCBIN "gfx/red/shmup1.2bpp"
Shmup1End:
	
SpaceWorldTextPointers:
    dw PickUpItemText

ProduceSine:	
.Increase
	ld a, [wSineCounter]
	inc a
	ld [wSineCounter] , a	
.goDown
	ld a, [wSineCounter] 
	cp $10
	jr z, .goUp
	ld hl, wSpriteStateData1 + $14
	ld de, wSpriteStateData1 + $14
	push de
	call GoDown
	ld hl, wSpriteStateData1 + $24
	pop de
	call GoDown
	ret
.goUp
	call GoUp
	ld c, $1
	call DelayFrames
	ld a, [wSineCounter]
	dec a
	ld [wSineCounter] , a
	jr nz, .goUp
	jr .Increase
	
GoDown:
	;ld hl, wSpriteStateData1 + $14
	call Compare16bit
	push hl
	ld a, [hl]                      
	inc a 
	jr nc, .notPlayerTwo
	inc a
.notPlayerTwo
	ld [hl] , a                     
	inc hl
	inc hl
	ld a, [hl]
	dec a
	ld [hl] , a
	ret
GoUp:	
	ld hl, wSpriteStateData1 + $14
	ld a, [hl] 
	dec a
	ld [hl] , a
	inc hl 
	inc hl
	ld a, [hl] 
	dec a
	ld [hl] , a
	ret

;Subtraction 16 bit routine  X - Y
;INPUT:  X = DE  Y = HL  --> DE-HL
;OUTPUT: Set carry flag if mismatch occurs.
Compare16bit:
	ld a, e
	sub l
	jr nz, .notEqual
	ld a, d
	sub h
	ret z
.notEqual
	scf
	ret

NPCBullet:
	ld c, 9
	push bc
.bulletLoop
	pop bc
	ld a, $FF
	ld [wUpdateSpritesEnabled], a
	ld a, 9
	pop de
	call WriteOAMBlock
	push bc
	ld c, 30
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	pop bc
	ld a, c
	dec a
	ld c, a
	jp nz, .bulletLoop
	ret

