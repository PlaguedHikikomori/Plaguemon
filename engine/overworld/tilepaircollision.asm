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
	