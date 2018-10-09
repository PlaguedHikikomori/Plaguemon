SpaceWorldScript:
    ld a, REDS_HOUSE_2F
	ld [wLastMap], a
    call EnableAutoTextBoxDrawing
	ld a, [hJoyPressed]
	cp B_BUTTON
	ret nz
	call Bullet
	ret
	
Bullet:
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
.loop
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
	jr nz, .loop
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
	call RightEnemyDistance                     ;distanza in pixel univoca dal player
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
	call RightEnemyDistance 
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
	call RightEnemyDistance 
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
	call RightEnemyDistance 
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
	call RightEnemyDistance 
	call IsSpriteInFrontOfPlayer2 
    ld a,[hSpriteIndexOrTextID]
	ld [wMissableObjectList + 8], a
	xor a
	ld [wMissableObjectList + 9], a
	ld a, $ff
	ld [wMissableObjectList + 10], a
.return
    ret

	


Shmup1:

	INCBIN "gfx/red/shmup1.2bpp"
Shmup1End:
	
SpaceWorldTextPointers:
    dw PickUpItemText
	
	
RightEnemyDistance:
	ld a, [wOAMBuffer + 1]
	ld c, a
	ld a, [wOAMBuffer + 17]
	sub c
	ld d, a
	ret
	
	

    
	
	

    


