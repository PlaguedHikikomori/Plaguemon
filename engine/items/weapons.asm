CheckWeaponShot:
	ld a, [hJoyPressed]
	bit 1, a
	jr z, .checkFinished  ; check if the player is holding B
	ld hl, ValidVehiclesPtr
	ld c, (ValidVehiclesPtrEnd - ValidVehiclesPtr) / 4 ; get the total valid vehicles
.checkIsDrivingValidVehicle
	ld a, [hli] ; get the vehicle number and move it to a, then increment hl
	ld b, a ; move it to a
	ld a, [wWalkBikeSurfState] ; get the driven vehicle
	cp b ; compare it with the previous one
	jr z, .isDrivingValidVehicle
	dec c
	jr z, .checkFinished ; check if the list is finished
	inc hl
	inc hl
	inc hl ; "jump" to the next vehicle
	jr .checkIsDrivingValidVehicle ; loop through the list
.isDrivingValidVehicle ; the player is driving a vehicle with a weapon
	ld a, [hli] ; store the vehicle bullet type
	ld c, a ; move it to c
	ld a, [hli] ; store the vehicle shooting range
	ld d, a ; move it to d
	ld a, [hl] ; store the vehicle shooting capibility
	ld e, a ; move it to e
	call Shoot
.checkFinished
	ret

; Weapon ID | Weapon animation type| Weapon shooting range | Shooting capibility (can shoot without enemy in front of the player)
ValidVehiclesPtr:
	db $1, $0, $10, $0; Panda
	db $4, $0, $10, $0 ; Flamethrower
	db $6, $1, $50, $1 ; Ak47
	db $7, $2,  $0, $0 ; Radio Suit
ValidVehiclesPtrEnd:

; INPUTS
; b = weapon number, c = animation type, d = max weapon shooting range, e = shooting capibility
Shoot:
	ld a, c ; move the animation type to a
	ld [wShotAnimation], a ; save it on ram
	push de
	ld e, d ; move the shooting range to e
	call FindNPCToKill ; kill the NPCs in range
	ld h, d
	ld l, e ; move de to hl, then push it
	pop de
	push hl ; save hl
	jr c, .weaponCanShoot ; check if the weapon can shoot
.canWeaponShoot
	ld a, e ; load e into a
	and a ; move flags
	jr z, .noSpritesFound ; return if no sprites were found and the weapon cannot shoot without a sprite in front of the player
.weaponCanShoot
	call ShotAnimation ; play the weapon animation
	pop hl ; restore the stored wMissableObjectList address
	ld a, [hSpriteIndexOrTextID] ; load the sprite ID
	ld [hli], a ; set the sprite
	xor a
	ld [hl], a  ; hide the killed NPC
	ld a, [wCurMap]
	cp KNIFE_ROOM
	ret nz
	ld a, [wKilledZombie]
	cp $1
	ret nz
	callab LoadScore   ;Add score for the zombie room
	xor a
	ld [wKilledZombie], a
	ret
.noSpritesFound
	pop hl
	ret
	
	
; INPUTS
; e = max NPCs distance
; OUTPUTS
; bc = X and Y coordinates of the found sprite
; de = wMissableObjectList address, containing the NPC's hide/show ID
; carry = 1 if a sprite was found, 0 otherwise
FindNPCToKill:
	ld d, $10
.searchSprite
	push de
	call IsSpriteInFrontOfPlayer2
	pop de
	ld a, [hSpriteIndexOrTextID] ; load into a, the found sprite ID
	ld c, a ; load it in the c register
	and a
	jr nz, .spriteFound
	ld a, d
	cp e
	jr z, .noSpriteFound
	ld b, $10 ; set b to $10
	add a, b ; a += b
	ld d, a ; increment d by $10
	jr .searchSprite
.spriteFound
	ld a, $1
	ld [wKilledZombie], a
	ld a, d
	ld [wAnimationDuration], a ; save the animation duration on ram
	; if a sprite was found
	ld hl,wSpriteStateData1 ; load into the hl regiter the player sprite (ID = 0)
.loop
	ld de, $0010
	add hl, de ; skip to the next sprite
	dec c ; decrement the sprite ID
	jr nz, .loop
	push hl
	ld hl, wMissableObjectList ; load to hl the starting pointer of the missable object list
	ld b, $0
.searchEmptyMissableObject ; search the first empty missable object
	ld a, [hl] ; load into a the value of the pointed address
	cp $FF ; is it an empty missable object?
	jr z, .emptyMissableObjectFound ; an empty missable object was found
	ld c, a
	ld a, [hSpriteIndexOrTextID]
	cp c
	jr z, .notEmptyMissableObjectFound ; a not empty missable object was found
	inc hl
	inc hl ; skip to the next sprite
	inc b ; increase the counter
	cp $11 ; has it reached the maximum sprites value? (17, 0x11)
	jr nz, .searchEmptyMissableObject
.emptyMissableObjectFound ; an empty missable object was found
	;ld a, [hSpriteIndexOrTextID] - load into a the found sprite ID
	;ld [hli], a - load it into the wMissableObjectList and increase hl
	;xor a - reset a
	;ld [hli], a - load 00 to reset the object and increase hl
	ld d, h
	ld e, l ; load the sprite address to de
	inc hl 
	inc hl ; increment hl
	ld a, $FF
	ld [hl], a ; load the character terminator
	jr .weaponFireAnimation
.notEmptyMissableObjectFound
	;inc hl
	;xor a
	;ld [hl], a - set the sprite to 00
	ld d, h
	ld e, l ; load the sprite address to de
.weaponFireAnimation
	pop hl ; get the previously saved sprite data pointer
	;xor a - set a to $00
	;ld [hSpriteIndexOrTextID], a - reset the sprite index
	push de ; push de to preserve its state
	ld de, $0004
	add hl, de ; jump to the Y coordinate
	pop de
	ld a, [wSpriteStateData1 + 9] ; load the player facing direction
	cp SPRITE_FACING_LEFT
	jr z, .isFacingLeftOrDown ; check if the player is facing left
	cp SPRITE_FACING_DOWN
	jr nz, .isFacingRightOrUp ; check if the player is facing other direction than left or down
.isFacingLeftOrDown
	ld a, [hli] ; move it to a and increment hl
	sub $03 ; if the player is facing left/down
	ld c, a ; move it to c --> c = Y coordinate
	inc hl ; increment hl to the X coordinate
	ld a, [hl]
	add $1D ; if the player is facing left/down
	ld b, a ; move it to b --> b = X coordinate
	jr .done
.isFacingRightOrUp
	ld a, [hli] ; move it to a and increment hl
	add $1D ; if the player is facing right/up
	ld c, a ; move it to c --> c = Y coordinate
	inc hl ; increment hl to the X coordinate
	ld a, [hl]	
	sub $03 ; if the player is facing right/up
	ld b, a ; move it to b --> b = X coordinate
.done
	scf ; set the carry flag
	ret
.noSpriteFound
	ld a, $50 ; set the maximum animation range
	or a ; reset the carry flag
	ld [wAnimationDuration], a ; no sprites were found
	ret

; INPUTS
; bc = animation coordinates, [wShotAnimation] = animation type, [wAnimationDuration] = animation duration
ShotAnimation:
	push bc
	ld hl, BulletsPtr ; load the starting pointer
	ld b, $0 ; initialize the counter (array index)
	ld c, (BulletsPtrEnd - BulletsPtr) / 2 ; get the total items 
.searchShotAnimation
	ld a, [wShotAnimation] ; load the saved shot animation
	cp b ; check if a = b
	jr z, .shotAnimationFound
	inc hl
	inc hl ; "jump" to the next address
	inc b
	dec c  ; check if we looped through the whole array
	jr z, .shotAnimationNotFound
	jr .searchShotAnimation
.shotAnimationFound
	pop bc
	push de
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a ; load the function address to de
	ld h, d
	ld l, e ; move it to hl
	pop de ; preserve e register
	jp hl ; jump to the desired function
.shotAnimationNotFound
	pop bc
	ret
	
; INPUTS
; bc = animation coordinates
FlameThrowerAnimation:
	xor a ; reset a
	ld [wEmotionBubbleSpriteIndex], a
	ld [wWhichEmotionBubble], a ; set the "DIE" emotion bubble
	push bc
	predef EmotionBubble
	pop bc
	call Flame
	call ExecuteAnimation
    call BurningMan 
	call ExecuteAnimation
	ld a, [wBurnedPeople]
	inc a
	ld [wBurnedPeople], a
	callab TryEvolvingMon
	ret

BulletAnimation:
	push de
	ld b, $00 ; fire
	call LoadRightCoordinates ; get the right coordinates to spawn the bang sprite
	call ExecuteBangAnimation
	ldpikacry e, PikachuCry2
	callab PlayPikachuSoundClip
	pop de
	ld a, $02 ; set the animation offset to 2 (Bullet animation)
	ld [wWhichAnimationOffsets], a
	ld a, [wAnimationDuration]
	swap a ; swap nibbles
	add a ; double it
	ld [wAnimationDuration], a ; reload it
	callba AnimateBoulderDust	
	ret

; INPUTS
; b = type
; OUTPUTS
; bc = bang coordinates
LoadRightCoordinates:
	ld a, [wSpriteStateData1 + 9] ; load the player facing direction
	cp SPRITE_FACING_LEFT
	jr z, .isFacingLeft
	cp SPRITE_FACING_RIGHT
	jr z, .isFacingRight
	cp SPRITE_FACING_UP
	jr z, .isFacingUp
.isFacingDown
	ld a, b
	and a
	jr z, .loadBangDown
	call LoadBulletRotatedTileOneTime
	jr .loadedDown
.loadBangDown
	call LoadBangRotatedOneTime
.loadedDown
	ld a, [wSpriteStateData1 + 4] ; load the player X coordinate into b
	add $19
	ld b, a
	ld a, [wSpriteStateData1 + 6] ; load the player Y coordinate into c
	add $0A
	ld c, a
	ld de, BangOAMDown
	ret
.isFacingUp
	ld a, b
	and a
	jr z, .loadBangUp
	call LoadBulletRotatedTileOneTime
	jr .loadedUp
.loadBangUp
	call LoadBangRotatedOneTime
.loadedUp
	ld a, [wSpriteStateData1 + 4] ; load the player X coordinate into b
	add $02
	ld b, a
	ld a, [wSpriteStateData1 + 6] ; load the player Y coordinate into c
	add $0A
	ld c, a
	ld de, BangOAMUp
	ret
.isFacingLeft
	ld a, b
	and a
	jr z, .loadBangLeft
	call LoadBulletTileOneTime
	jr .loadedLeft
.loadBangLeft
	call LoadBangOneTime
.loadedLeft
	ld a, [wSpriteStateData1 + 4] ; load the player X coordinate into b
	add $12
	ld b, a
	ld a, [wSpriteStateData1 + 6] ; load the player Y coordinate into c
	sub $05
	ld c, a
	ld de, BangOAMLeft
	ret
.isFacingRight
	ld a, b
	and a
	jr z, .loadBangRight
	call LoadBulletTileOneTime
	jr .loadedRight
.loadBangRight
	call LoadBangOneTime
.loadedRight
	ld a, [wSpriteStateData1 + 4] ; load the player X coordinate into b
	add $12
	ld b, a
	ld a, [wSpriteStateData1 + 6] ; load the player Y coordinate into c
	add $14
	ld c, a
	ld de, BangOAMRight
	ret
	
LoadBulletTileOneTime:
	ld de, BulletSprite
	ld hl, vChars1 + $7C0
	lb bc, BANK(BulletSprite), $04
	jp CopyVideoData
	
LoadBulletRotatedTileOneTime:
	ld de, BulletRotatedSprite
	ld hl, vChars1 + $7C0
	lb bc, BANK(BulletRotatedSprite), $04
	jp CopyVideoData

LoadBangOneTime:
    ld de, BangSprite
    ld hl, vChars1 + $7C0
	lb bc, BANK(BangSprite), $04
	jp CopyVideoData

LoadBangRotatedOneTime:
    ld de, BangRotatedSprite
    ld hl, vChars1 + $7C0
	lb bc, BANK(BangRotatedSprite), $04
	jp CopyVideoData

; INPUTS
; de = OAM
ExecuteBangAnimation:
	ld a, $FF
	ld [wUpdateSpritesEnabled], a
	ld a, 9
	call WriteOAMBlock
	ld c, 30
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	ret

BulletsPtr:
	dw FlameThrowerAnimation
	dw BulletAnimation
	dw NoAnimation
BulletsPtrEnd:	

BurningMan:
	push bc
	ld a, %11010000
	ld [rOBP0], a
    ld de, BurnedMan
    ld hl, vChars1 + $7C0
	lb bc, BANK(BurnedMan), $04
	call CopyVideoData
	pop bc
	ret

; INPUTS bc = coordinates
Flame:
	push bc
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
	pop bc
	ret

; INPUTS bc = coordinates
ExecuteAnimation:
	push bc
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld de, FireOAM
	ld a, 1
	call WriteOAMBlock
	call DelayFrames
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	call DelayFrame
	call UpdateSprites
	pop bc
	ret
	
FireOAM:
	db $FC,$00,$FD,$00
	db $FE,$00,$FF,$00

BangOAMLeft:
	db $FC,$00,$FD,$00
	db $FE,$00,$FF,$00
	
BangOAMRight:
	db $FD,$20,$FC,$20
	db $FF,$20,$FE,$20

BangOAMUp:
	db $FC,$00,$FD,$00
	db $FE,$00,$FF,$00
	
BangOAMDown:
	db $FE,$40,$FF,$40
	db $FC,$40,$FD,$40
	
NoAnimation:
	ret
	