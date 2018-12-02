FalloutLoop::
    ld a, [wWalkBikeSurfState]
	cp $7
	ret z
	ld a, [wTilePlayerStandingOn]
	ld c, a
	ld a, $03
	cp c
	ret nz
	call PoisonAllMonsters
	ret
	
PoisonAllMonsters:
	ld bc,wPartyMon1Status - wPartyMon1
.poisonloop
	ld a, [wPartyMon6Status]
	cp $88
	ret z
	ld hl,wPartyMons
    add hl,bc
	ld a, $88
	ld [hl], a
    ld a, $2C 
	ld e, a
	xor a
	ld d, a
	push bc
	pop hl
	add hl,de
	push hl
	pop bc
	jp .poisonloop

	
	
	