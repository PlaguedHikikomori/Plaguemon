Shmup:
    call GBPalWhiteOutWithDelay3
	call ClearScreen
	ld c,10
	call DelayFrames
	ld a, SPACE_WORLD
	ld [wDestinationMap],a
	ld hl,wd732
	set 2,[hl] ; fly warp or dungeon warp
	callab SpecialWarpIn
	callab SpecialEnterMap
	
Scrolling:	
    ld a, [wCurMap]
	cp SPACE_WORLD
	ret nz
	
	ld hl, vChars2 
	ld c, $10

	ld a, [wMovingBGTilesCounter2]
	inc a
	and 7
	ld [wMovingBGTilesCounter2], a
	
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
	
