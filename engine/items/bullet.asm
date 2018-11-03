CalcNearestSpriteDistance:
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_RIGHT
	jp z, .distright
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_LEFT
	jp z, .distleft
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	jp z, .distup
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_DOWN
	jp z, .distdown
.distright
	ld a, [wOAMBuffer + 1]
	ld b, a
	ld a, [wOAMBuffer + 17]
	sub b
	ld d, a
	ret
.distleft
	ret
.distup
	ret
.distdown
	ret

Bullet2:
    xor a
	ld [wUnusedCC5B], a
    ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld de, AnimationTileset2 + $410 
    ld hl, vChars1 + $7C0
	lb bc, BANK(AnimationTileset2), $01
	call CopyVideoData
	ld de, AnimationTileset2 + $410 
    ld hl, vChars1 + $7D0
	lb bc, BANK(AnimationTileset2), $01
	call CopyVideoData
	ld de, AnimationTileset2 + $410 
    ld hl, vChars1 + $7E0
	lb bc, BANK(AnimationTileset2), $01
	call CopyVideoData
	ld de, AnimationTileset2 + $410 
    ld hl, vChars1 + $7F0
	lb bc, BANK(AnimationTileset2), $01
	call CopyVideoData
	ld de, FireOAM
	ld a, [wOAMBuffer]
	inc a
	ld b, a
	ld a, [wOAMBuffer + 1]
	inc a
	ld c, a
	ld a, 9
	call WriteOAMBlock
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_RIGHT
	jp z, .right
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_LEFT
	jp z, .left
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	jp z, .up
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_DOWN
	jp z, .down
.right
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
    ld a, [wUnusedCC5B]
	inc a
	ld [wUnusedCC5B], a
	ld de, FireOAM
	ld a, [wOAMBuffer + 145]
	add $10
	ld c, a
	ld a, [wOAMBuffer + 144]
	sub $50
	ld b, a
	ld a, 9
	call WriteOAMBlock
	ld c, 2
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ld a, [wUnusedCC5B]
	cp $05
	jr nz, .right
	call Gun
	ret
.left
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
    ld a, [wUnusedCC5B]
	inc a
	ld [wUnusedCC5B], a
	ld de, FireOAM
	ld a, [wOAMBuffer + 145]
	sub $10
	ld c, a
	ld a, [wOAMBuffer + 144]
	sub $50
	ld b, a
	ld a, 9
	call WriteOAMBlock
	ld c, 2
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ld a, [wUnusedCC5B]
	cp $05
	jr nz, .left
	call Gun
	ret
.up
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
    ld a, [wUnusedCC5B]
	inc a
	ld [wUnusedCC5B], a
	ld de, FireOAM
	ld a, [wOAMBuffer + 145]
	ld c, a
	ld a, [wOAMBuffer + 144]
	ld b, a
	ld a, 9
	inc b
	call WriteOAMBlock
	ld c, 2
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ld a, [wUnusedCC5B]
	cp $05
	jr nz, .up
	call Gun
	ret
.down
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
    ld a, [wUnusedCC5B]
	inc a
	ld [wUnusedCC5B], a
	ld de, FireOAM
	ld a, [wOAMBuffer + 145]
	ld c, a
	ld a, [wOAMBuffer + 144]
	ld b, a
	ld a, 9
	dec b
	call WriteOAMBlock
	ld c, 2
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ld a, [wUnusedCC5B]
	cp $05
	jr nz, .down
	call Gun
	ret

		
Gun:
    ld a, [wMissableObjectList]
	cp $ff
	jr nz, .due
	ld a, [wMissableObjectList]
	cp $01
	jr z, .due
	xor a
	ld [hSpriteIndexOrTextID],a
	call CalcNearestSpriteDistance
	call IsSpriteInFrontOfPlayer2 
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList], a
	xor a
	ld [wMissableObjectList + 1], a
	ld a, $ff
	ld [wMissableObjectList + 2], a
	jr .return
.due
    ld a, [wMissableObjectList + 2]
	cp $ff
	jr nz, .tre
	xor a
	ld [hSpriteIndexOrTextID],a
	call CalcNearestSpriteDistance 
	call IsSpriteInFrontOfPlayer2
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 2], a
	xor a
	ld [wMissableObjectList + 3], a
	ld a, $ff
	ld [wMissableObjectList + 4], a
	jr .return
.tre
    ld a, [wMissableObjectList + 4]
	cp $ff
	jr nz, .quattro
	xor a
	ld [hSpriteIndexOrTextID],a
	call CalcNearestSpriteDistance 
	call IsSpriteInFrontOfPlayer2
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 4], a
	xor a
	ld [wMissableObjectList + 5], a
	ld a, $ff
	ld [wMissableObjectList + 6], a
	jr .return
.quattro
    ld a, [wMissableObjectList + 6]
	cp $ff
	jr nz, .cinque
	xor a
	ld [hSpriteIndexOrTextID],a
	call CalcNearestSpriteDistance
	call IsSpriteInFrontOfPlayer2 
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 6], a
	xor a
	ld [wMissableObjectList + 7], a
	ld a, $ff
	ld [wMissableObjectList + 8], a
	jr .return
.cinque
    ld a, [wMissableObjectList + 8]
	cp $ff
	jr nz, .return
	xor a
	ld [hSpriteIndexOrTextID],a
	call CalcNearestSpriteDistance
	call IsSpriteInFrontOfPlayer2
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 8], a
	xor a
	ld [wMissableObjectList + 9], a
	ld a, $ff
	ld [wMissableObjectList + 10], a
.return
    ret
	