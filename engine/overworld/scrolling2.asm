Scrolling2:	
    ld a, [wCurMap]
	cp POKEMONTOWER_3
	ret nz
	ld a, [wCurMap]
	cp POKEMONTOWER_4
	ret nz
	ld a, [wCurMap]
	cp POKEMONTOWER_5
	ret nz
	ld a, [wCurMap]
	cp POKEMONTOWER_6
	ret nz
	ld a, [wCurMap]
	cp POKEMONTOWER_7
	ret nz
	
	ld hl, vChars2 
	ld c, $10

	ld a, [wMovingBGTilesCounter2]
	inc a
	and 7
	ld [wMovingBGTilesCounter2], a
	
	and 4
	jr nz, .left
.right
	ld a, [hl]
	rrca
	ld [hli], a
	dec c
	jr nz, .right
	jr .done
.left
	ld a, [hl]
	rlca
	ld [hli], a
	dec c
	jr nz, .left
.done
	ld a, [hTilesetType]
	rrca
	ret nc
	xor a
	ld [hMovingBGTilesCounter1], a
	ret