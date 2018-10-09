DisplayPokemartDialogue_:
	ld a,[wListScrollOffset]
	ld [wSavedListScrollOffset],a
	call UpdateSprites
	xor a
	ld [wBoughtOrSoldItemInMart],a
.loop
	xor a
	ld [wListScrollOffset],a
	ld [wCurrentMenuItem],a
	ld [wPlayerMonNumber],a
	inc a
	ld [wPrintItemPrices],a
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID
	ld a,BUY_SELL_QUIT_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID

; This code is useless. It copies the address of the pokemart's inventory to hl,
; but the address is never used.
	ld hl,wItemListPointer
	ld a,[hli]
	ld l,[hl]
	ld h,a

	ld a,[wMenuExitMethod]
	cp a,CANCELLED_MENU
	jp z,.done
	ld a,[wChosenMenuItem]
	and a ; buying?
	jp z,.buyMenu
	dec a ; selling?
	jp z,.sellMenu
	dec a ; quitting?
	jp z,.done
.sellMenu

; the same variables are set again below, so this code has no effect
	xor a
	ld [wPrintItemPrices],a
	ld a,INIT_BAG_ITEM_LIST
	ld [wInitListType],a
	callab InitList

	ld a,[wNumBagItems]
	and a
	jp z,.bagEmpty
	ld hl,PokemonSellingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1 ; save screen
.sellMenuLoop
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID ; draw money text box
	ld hl,wNumBagItems
	ld a,l
	ld [wListPointer],a
	ld a,h
	ld [wListPointer + 1],a
	xor a
	ld [wPrintItemPrices],a
	ld [wCurrentMenuItem],a
	ld a,ITEMLISTMENU
	ld [wListMenuID],a
	call DisplayListMenuID
	jp c,.returnToMainPokemartMenu ; if the player closed the menu
.confirmItemSale ; if the player is trying to sell a specific item
	call IsKeyItem
	ld a,[wIsKeyItem]
	and a
	jr nz,.unsellableItem
	ld a,[wcf91]
	call IsItemHM
	jr c,.unsellableItem
	ld a,PRICEDITEMLISTMENU
	ld [wListMenuID],a
	ld [hHalveItemPrices],a ; halve prices when selling
	call DisplayChooseQuantityMenu
	inc a
	jr z,.sellMenuLoop ; if the player closed the choose quantity menu with the B button
	ld hl,PokemartTellSellPriceText
	lb bc, 14, 1 ; location that PrintText always prints to, this is useless
	call PrintText
	coord hl, 14, 7
	lb bc, 8, 15
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; yes/no menu
	ld a,[wMenuExitMethod]
	cp a,CHOSE_SECOND_ITEM
	jr z,.sellMenuLoop ; if the player chose No or pressed the B button

; The following code is supposed to check if the player chose No, but the above
; check already catches it.
	ld a,[wChosenMenuItem]
	dec a
	jr z,.sellMenuLoop

.sellItem
	ld a,[wBoughtOrSoldItemInMart]
	and a
	jr nz,.skipSettingFlag1
	inc a
	ld [wBoughtOrSoldItemInMart],a
.skipSettingFlag1
	call AddAmountSoldToMoney
	ld hl,wNumBagItems
	call RemoveItemFromInventory
	jp .sellMenuLoop
.unsellableItem
	ld hl,PokemartUnsellableItemText
	call PrintText
	jp .returnToMainPokemartMenu
.bagEmpty
	ld hl,PokemartItemBagEmptyText
	call PrintText
	call SaveScreenTilesToBuffer1
	jp .returnToMainPokemartMenu
.buyMenu

; the same variables are set again below, so this code has no effect
	ld a,1
	ld [wPrintItemPrices],a
	ld a,INIT_OTHER_ITEM_LIST
	ld [wInitListType],a
	callab InitList

	ld hl,PokemartBuyingGreetingText
	call PrintText
	call SaveScreenTilesToBuffer1
.buyMenuLoop
	call LoadScreenTilesFromBuffer1
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID
	ld hl,wItemList
	ld a,l
	ld [wListPointer],a
	ld a,h
	ld [wListPointer + 1],a
	xor a
	ld [wCurrentMenuItem],a
	inc a
	ld [wPrintItemPrices],a
	inc a ; a = 2 (PRICEDITEMLISTMENU)
	ld [wListMenuID],a
	call DisplayListMenuID
	jr c,.returnToMainPokemartMenu ; if the player closed the menu
	ld a,99
	ld [wMaxItemQuantity],a
	xor a
	ld [hHalveItemPrices],a ; don't halve item prices when buying
	call DisplayChooseQuantityMenu
	inc a
	jr z,.buyMenuLoop ; if the player closed the choose quantity menu with the B button
	ld a,[wcf91] ; item ID
	ld [wd11e],a ; store item ID for GetItemName
	call GetItemName
	call CopyStringToCF4B ; copy name to wcf4b
	ld hl,PokemartTellBuyPriceText
	call PrintText
	coord hl, 14, 7
	lb bc, 8, 15
	ld a,TWO_OPTION_MENU
	ld [wTextBoxID],a
	call DisplayTextBoxID ; yes/no menu
	ld a,[wMenuExitMethod]
	cp a,CHOSE_SECOND_ITEM
	jp z,.buyMenuLoop ; if the player chose No or pressed the B button

; The following code is supposed to check if the player chose No, but the above
; check already catches it.
	ld a,[wChosenMenuItem]
	dec a
	jr z,.buyMenuLoop

.buyItem
	call .isThereEnoughMoney
	jr c,.notEnoughMoney
	ld hl,wNumBagItems
	call AddItemToInventory
	jr nc,.bagFull
	call SubtractAmountPaidFromMoney
	ld a,[wBoughtOrSoldItemInMart]
	and a
	jr nz,.skipSettingFlag2
	ld a,1
	ld [wBoughtOrSoldItemInMart],a
.skipSettingFlag2
	ld a,SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld hl,PokemartBoughtItemText
	call PrintText
	jp .buyMenuLoop
.returnToMainPokemartMenu
	call LoadScreenTilesFromBuffer1
	ld a,MONEY_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID
	ld hl,PokemartAnythingElseText
	call PrintText
	jp .loop
.isThereEnoughMoney
	ld de,wPlayerMoney
	ld hl,hMoney
	ld c,3 ; length of money in bytes
	jp StringCmp
.notEnoughMoney
	ld hl,PokemartNotEnoughMoneyText
	call PrintText
	jr .returnToMainPokemartMenu
.bagFull
	ld hl,PokemartItemBagFullText
	call PrintText
	jr .returnToMainPokemartMenu
.done
	ld hl,PokemartThankYouText
	call PrintText
	ld a,1
	ld [wUpdateSpritesEnabled],a
	call UpdateSprites
	ld a,[wSavedListScrollOffset]
	ld [wListScrollOffset],a
	ret

PokemartBuyingGreetingText:
	TX_FAR _PokemartBuyingGreetingText
	db "@"

PokemartTellBuyPriceText:
	TX_FAR _PokemartTellBuyPriceText
	db "@"

PokemartBoughtItemText:
	TX_FAR _PokemartBoughtItemText
	db "@"

PokemartNotEnoughMoneyText:
	TX_FAR _PokemartNotEnoughMoneyText
	db "@"

PokemartItemBagFullText:
	TX_FAR _PokemartItemBagFullText
	db "@"

PokemonSellingGreetingText:
	TX_FAR _PokemonSellingGreetingText
	db "@"

PokemartTellSellPriceText:
	TX_FAR _PokemartTellSellPriceText
	db "@"

PokemartItemBagEmptyText:
	TX_FAR _PokemartItemBagEmptyText
	db "@"

PokemartUnsellableItemText:
	TX_FAR _PokemartUnsellableItemText
	db "@"

PokemartThankYouText:
	TX_FAR _PokemartThankYouText
	db "@"

PokemartAnythingElseText:
	TX_FAR _PokemartAnythingElseText
	db "@"
