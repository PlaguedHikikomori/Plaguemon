; function to check if the player will jump down a ledge and check if the tile ahead is passable (when not surfing)
; sets the carry flag if there is a collision, and unsets it if there isn't a collision
CollisionCheckOnLand::
	ld a,[wd736]
	bit 6,a ; is the player jumping?
	jr nz,.noCollision
; if not jumping a ledge
	ld a,[wSimulatedJoypadStatesIndex]
	and a
	jr nz,.noCollision ; no collisions when the player's movements are being controlled by the game
	ld a,[wPlayerDirection] ; the direction that the player is trying to go in
	ld d,a
	ld a,[wSpriteStateData1 + 12] ; the player sprite's collision data (bit field) (set in the sprite movement code)
	and d ; check if a sprite is in the direction the player is trying to go
	jr nz,.collision
	xor a
	ld [hSpriteIndexOrTextID],a
	call IsSpriteInFrontOfPlayer ; check for sprite collisions again? when does the above check fail to detect a sprite collision?
	ld a,[hSpriteIndexOrTextID]
	and a ; was there a sprite collision?
	jr nz,.collision
; if no sprite collision
	ld hl,TilePairCollisionsLand
	call CheckForJumpingAndTilePairCollisions
	jr c,.collision
	call CheckTilePassable
	jr nc,.noCollision
.collision
	ld a,[wChannelSoundIDs + Ch4]
	cp SFX_COLLISION ; check if collision sound is already playing
	jr z,.setCarry
	ld a,SFX_COLLISION
	call PlaySound ; play collision sound (if it's not already playing)
.setCarry
	scf
	ret
.noCollision
	and a
	ret
	
CollisionCheckOnWater::
	ld a,[wd730]
	bit 7,a
	jp nz,.noCollision ; return and clear carry if button presses are being simulated
	ld a,[wPlayerDirection] ; the direction that the player is trying to go in
	ld d,a
	ld a,[wSpriteStateData1 + 12] ; the player sprite's collision data (bit field) (set in the sprite movement code)
	and d ; check if a sprite is in the direction the player is trying to go
	jr nz,.checkIfNextTileIsPassable ; bug?
	ld hl,TilePairCollisionsWater
	call CheckForJumpingAndTilePairCollisions
	jr c,.collision
	predef GetTileAndCoordsInFrontOfPlayer ; get tile in front of player (puts it in c and [wTileInFrontOfPlayer])
	ld a,[wTileInFrontOfPlayer] ; tile in front of player
	cp a,$14 ; water tile
	jr z,.noCollision ; keep surfing if it's a water tile
	cp a,$32 ; either the left tile of the S.S. Anne boarding platform or the tile on eastern coastlines (depending on the current tileset)
	jr z,.checkIfVermilionDockTileset
	cp a,$48 ; tile on right on coast lines in Safari Zone
	jr z,.noCollision ; keep surfing
; check if the [land] tile in front of the player is passable
.checkIfNextTileIsPassable
	ld hl,wTilesetCollisionPtr ; pointer to list of passable tiles
	ld a,[hli]
	ld h,[hl]
	ld l,a
.loop
	ld a,[hli]
	cp a,$ff
	jr z,.collision
	cp c
	jr z,.stopSurfing ; stop surfing if the tile is passable
	jr .loop
.collision
	ld a,[wChannelSoundIDs + Ch4]
	cp SFX_COLLISION ; check if collision sound is already playing
	jr z,.setCarry
	ld a,SFX_COLLISION
	call PlaySound ; play collision sound (if it's not already playing)
.setCarry
	scf
	jr .done
.noCollision
	and a
.done
	ret
.stopSurfing
	xor a
	ld [wWalkBikeSurfState],a
	call LoadPlayerSpriteGraphics
	call PlayDefaultMusic
	jr .noCollision
.checkIfVermilionDockTileset
	ld a, [wCurMapTileset] ; tileset
	cp SHIP_PORT ; Vermilion Dock tileset
	jr nz, .noCollision ; keep surfing if it's not the boarding platform tile
	jr .stopSurfing ; if it is the boarding platform tile, stop surfing