ActivatePC:
	call SaveScreenTilesToBuffer2
	ld a, SFX_TURN_ON_PC
	call PlaySound
	ld hl, TurnedOnPC1Text
	call PrintText
	call WaitForSoundToFinish
	ld hl, wFlags_0xcd60
	set 3, [hl]
	call LoadScreenTilesFromBuffer2
	call Delay3
PCMainMenu:
	callba DisplayPCMainMenu
	ld hl, wFlags_0xcd60
	set 5, [hl]
	call HandleMenuInput
	bit 1, a              ;if player pressed B
	jp nz, LogOff
	ld a, [wMaxMenuItem]
	cp a, 2
	jr nz, .next ;if not 2 menu items (not counting log off) (2 occurs before you get the pokedex)
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC    ;if current menu item id is 0, it's bills pc
	cp a, 1
	jr z, .playersPC ;if current menu item id is 1, it's players pc
	jp LogOff        ;otherwise, it's 2, and you're logging off
.next
	cp a, 3
	jr nz, .next2 ;if not 3 menu items (not counting log off) (3 occurs after you get the pokedex, before you beat the pokemon league)
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC    ;if current menu item id is 0, it's bills pc
	cp a, 1
	jr z, .playersPC ;if current menu item id is 1, it's players pc
	cp a, 2
	jp z, OaksPC     ;if current menu item id is 2, it's oaks pc
	jp LogOff        ;otherwise, it's 3, and you're logging off
.next2
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC    ;if current menu item id is 0, it's bills pc
	cp a, 1
	jr z, .playersPC ;if current menu item id is 1, it's players pc
	cp a, 2
	jp z, OaksPC     ;if current menu item id is 2, it's oaks pc
	cp a, 3
	jp z, PKMNLeague ;if current menu item id is 3, it's pkmnleague
	jp LogOff        ;otherwise, it's 4, and you're logging off
.playersPC
	ld hl, wFlags_0xcd60
	res 5, [hl]
	set 3, [hl]
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	ld hl, AccessedMyPCText
	call PrintText
	callba PlayerPC
	jr ReloadMainMenu
OaksPC:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	callba OpenOaksPC
	jr ReloadMainMenu
PKMNLeague:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	callba PKMNLeaguePC
	jr ReloadMainMenu
BillsPC:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	CheckEvent EVENT_MET_BILL
	jr nz, .billsPC ;if you've met bill, use that bill's instead of someone's
	ld hl, AccessedSomeonesPCText
	jr .printText
.billsPC
	ld hl, AccessedBillsPCText
.printText
	call PrintText
	callba BillsPC_
ReloadMainMenu:
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call ReloadMapData
	call UpdateSprites
	jp PCMainMenu
LogOff:
	ld a, SFX_TURN_OFF_PC
	call PlaySound
	call WaitForSoundToFinish
	ld hl, wFlags_0xcd60
	res 3, [hl]
	res 5, [hl]
	ret

TurnedOnPC1Text:
	TX_FAR _TurnedOnPC1Text
	db "@"

AccessedBillsPCText:
	TX_FAR _AccessedBillsPCText
	db "@"

AccessedSomeonesPCText:
	TX_FAR _AccessedSomeonesPCText
	db "@"

AccessedMyPCText:
	TX_FAR _AccessedMyPCText
	db "@"

; removes one of the specified item ID [hItemToRemoveID] from bag (if existent)
RemoveItemByID:
	ld hl, wBagItems
	ld a, [hItemToRemoveID]
	ld b, a
	xor a
	ld [hItemToRemoveIndex], a
.loop
	ld a, [hli]
	cp -1 ; reached terminator?
	ret z
	cp b
	jr z, .foundItem
	inc hl
	ld a, [hItemToRemoveIndex]
	inc a
	ld [hItemToRemoveIndex], a
	jr .loop
.foundItem
	ld a, $1
	ld [wItemQuantity], a
	ld a, [hItemToRemoveIndex]
	ld [wWhichPokemon], a
	ld hl, wNumBagItems
	jp RemoveItemFromInventory
