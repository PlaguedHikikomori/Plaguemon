PalletTownScript:
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr z,.next
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
.next
	call EnableAutoTextBoxDrawing
	ld hl,PalletTownScriptPointers
	ld a,[wPalletTownCurScript]
	jp CallFunctionInTable

PalletTownScriptPointers:
	dw PalletTownScript0
	dw PalletTownScript1
	dw PalletTownScript2
	dw PalletTownScript3
	dw PalletTownScript4
	dw PalletTownScript5
	dw PalletTownScript6

PalletTownScript0:
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret nz
	ld a,[wYCoord]
	cp 1 ; is player near north exit?
	ret nz
	xor a
	ld [hJoyHeld],a
	ld a,PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection],a
	ld a,$FF
	call PlaySound ; stop music
	ld a, BANK(Music_MeetProfOak)
	ld c,a
	ld a, MUSIC_MEET_PROF_OAK ; “oak appears” music
	call PlayMusic
	ld a,$FC
	ld [wJoyIgnore],a
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a,1
	ld [wPalletTownCurScript],a
	ret

PalletTownScript1:
	xor a
	ld [wcf0d],a
	ld a,1
	ld [hSpriteIndexOrTextID],a
	call DisplayTextID
	ld a,$FF
	ld [wJoyIgnore],a
	ld a,HS_PALLET_TOWN_OAK
	ld [wMissableObjectIndex],a
	predef ShowObject

	; trigger the next script
	ld a,2
	ld [wPalletTownCurScript],a
	ret

PalletTownScript2:
	ld a,1
	ld [H_SPRITEINDEX],a
	ld a,SPRITE_FACING_UP
	ld [hSpriteFacingDirection],a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	ld a,1
	ld [wYCoord],a
	ld a,1
	ld [hNPCPlayerRelativePosPerspective],a
	ld a,1
	swap a
	ld [hNPCSpriteOffset],a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl,hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak’s movement into wNPCMovementDirections2
	ld de,wNPCMovementDirections2
	ld a,1 ; oak
	ld [H_SPRITEINDEX],a
	call MoveSprite
	ld a,$FF
	ld [wJoyIgnore],a

	; trigger the next script
	ld a,3
	ld [wPalletTownCurScript],a
	ret

PalletTownScript3:
	ld a,[wd730]
	bit 0,a
	ret nz
	xor a ; ld a, SPRITE_FACING_DOWN
	ld [wSpriteStateData1 + 9],a
	ld a,1
	ld [wcf0d],a
	ld a,$FC
	ld [wJoyIgnore],a
	ld a,1
	ld [hSpriteIndexOrTextID],a
	call DisplayTextID
; set up movement script that causes the player to follow Oak to his lab
	ld a,$FF
	ld [wJoyIgnore],a
	ld a,1
	ld [wSpriteIndex],a
	xor a
	ld [wNPCMovementScriptFunctionNum],a
	ld a,1
	ld [wNPCMovementScriptPointerTableNum],a
	ld a,[H_LOADEDROMBANK]
	ld [wNPCMovementScriptBank],a

	; trigger the next script
	ld a,4
	ld [wPalletTownCurScript],a
	ret

PalletTownScript4:
	ld a,[wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; trigger the next script
	ld a,5
	ld [wPalletTownCurScript],a
	ret

PalletTownScript5:
	CheckEvent EVENT_DAISY_WALKING
	jr nz,.next
	CheckBothEventsSet EVENT_GOT_TOWN_MAP, EVENT_ENTERED_BLUES_HOUSE, 1
	jr nz,.next
	SetEvent EVENT_DAISY_WALKING
	ld a,HS_DAISY_SITTING
	ld [wMissableObjectIndex],a
	predef HideObject
	ld a,HS_DAISY_WALKING
	ld [wMissableObjectIndex],a
	predef_jump ShowObject
.next
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	ret z
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
PalletTownScript6:
	ret

PalletTownTextPointers:
	dw PalletTownText1
	dw PalletTownText2
	dw PalletTownText3
	dw PalletTownText4
	dw PalletTownText5
	dw PalletTownText6
	dw PalletTownText7

PalletTownText1:
	TX_ASM
	ld a,[wcf0d]
	and a
	jr nz,.next
	ld a,1
	ld [wDoNotWaitForButtonPressAfterDisplayingText],a
	ld hl,OakAppearsText
	jr .done
.next
	ld hl,OakWalksUpText
.done
	call PrintText
	jp TextScriptEnd

OakAppearsText:
	TX_FAR _OakAppearsText
	TX_ASM
	ld c,10
	call DelayFrames
	xor a
	ld [wEmotionBubbleSpriteIndex],a ; player's sprite
	ld [wWhichEmotionBubble],a ; EXCLAMATION_BUBBLE
	predef EmotionBubble
	ld a,PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection],a
	jp TextScriptEnd

OakWalksUpText:
	TX_FAR _OakWalksUpText
	db "@"

PalletTownText2: ; girl
	TX_FAR _PalletTownText2
	db "@"

PalletTownText3: ; fat man
	TX_FAR _PalletTownText3
	db "@"

PalletTownText4: ; sign by lab
	TX_FAR _PalletTownText4
	db "@"

PalletTownText5: ; sign by fence
	TX_FAR _PalletTownText5
	db "@"

PalletTownText6: ; sign by Red’s house
	TX_FAR _PalletTownText6
	db "@"

PalletTownText7: ; sign by Blue’s house
	TX_FAR _PalletTownText7
	db "@"
