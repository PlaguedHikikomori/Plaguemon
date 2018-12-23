FalloutLoop::
    ld a, [hTilesetType]
	cp $02
	ret nz
    ld a, [wWalkBikeSurfState]
	cp $7
	ret z
	ld a, [wTilePlayerStandingOn]
	ld c, a
	ld a, $03
	cp c
	ret nz
	
PoisonAllMonsters:
	ld hl, wPartyMon1Status ; load the first Pokémon status pointer
	ld a, [wPartyCount] ; load the number of Pokémon in the player's party
	ld d, a ; move it to d
.poisonAllPartyLoop
	ld a, $88
	cp [hl] ; is the Pokémon already poisoned?
	jr z, .checkCounter
	ld [hl], a ; poison the Pokémon
	ld bc, wPartyMon2Status - wPartyMon1Status ; load the value between the two addresses
	add hl, bc ; add it to hl
.checkCounter
	dec d
	jr nz, .poisonAllPartyLoop
	ret


	
	
	