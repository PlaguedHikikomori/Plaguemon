Knife:
    ld a, [wMissableObjectList]
	cp $ff
	jr nz, .due
	ld a, [wMissableObjectList]
	cp $01
	jr z, .due
	xor a
	ld [hSpriteIndexOrTextID],a
	call IsSpriteInFrontOfPlayer 
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
	call IsSpriteInFrontOfPlayer 
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
	call IsSpriteInFrontOfPlayer 
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
	call IsSpriteInFrontOfPlayer 
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
	call IsSpriteInFrontOfPlayer 
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 8], a
	xor a
	ld [wMissableObjectList + 9], a
	ld a, $ff
	ld [wMissableObjectList + 10], a
.return
    call Flame
    call BurningMan 
    predef EmotionBubble
    ret
	
BurningMan:
    ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, %11010000
	ld [rOBP0], a
    ld de, BurnedMan
    ld hl, vChars1 + $7C0
	lb bc, BANK(BurnedMan), $04
	call CopyVideoData
	ld de, FireOAM
	ld a, [wOAMBuffer + 16]
	ld b, a
	ld a, [wOAMBuffer + 17]
	ld c, a
	ld a, 1
	call WriteOAMBlock
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ret
	
Flame:
    ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, %01111000
	ld [rOBP0], a
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
	ld a, [wOAMBuffer + 16]
	ld b, a
	ld a, [wOAMBuffer + 17]
	ld c, a
	ld a, 1
	call WriteOAMBlock
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ret
	
FireOAM:
	db $FC,$00,$FD,$00
	db $FE,$00,$FF,$00
	

	
	