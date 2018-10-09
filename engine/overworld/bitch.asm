DisplayBitchDialogue::
	; zeroing these doesn't appear to serve any purpose
	xor a
	ld [$ff8b],a
	ld [$ff8c],a
	ld [$ff8d],a

	inc hl
	ld a,[H_LOADEDROMBANK]
	push af
	ld a,Bank(DisplayBitchDialogue_)
	ld [H_LOADEDROMBANK],a
	ld [MBC1RomBank],a
	call DisplayBitchDialogue_
	pop af
	ld [H_LOADEDROMBANK],a
	ld [MBC1RomBank],a
	jp AfterDisplayingTextID

DisplayBitchDialogue_:
	call SaveScreenTilesToBuffer1 ; save screen
	ld hl, PokemonCenterWelcomeText
	call PrintText
	ld hl, wd72e
	bit 2, [hl]
	set 1, [hl]
	set 2, [hl]
	jr nz, .skipShallWeHealYourPokemon
	ld hl, ShallWeHealYourPokemonText
	call PrintText
.skipShallWeHealYourPokemon
	call YesNoChoicePokeCenter ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .declinedHealing ; if the player chose No
	call SetLastBlackoutMap
	call LoadScreenTilesFromBuffer1 ; restore screen
	ld a, $64
	ld [hMoney], a
	ld [hMoney + 2], a
	ld a, $5
	ld [hMoney + 1], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	jp .done
.enoughMoney
	call SubtractAmountPaidFromMoney
	ld hl, NeedYourPokemonText
	call PrintText
	ld a, $18
	call Delay3
	predef HealParty
	callba Space_Weed
	xor a
	ld [wAudioFadeOutControl], a
	ld a, [wAudioSavedROMBank]
	ld [wAudioROMBank], a
	ld a, [wMapMusicSoundID]
	ld [wLastMusicSoundID], a
	ld [wNewSoundID], a
	call PlaySound
	ld hl, PokemonFightingFitText
	call PrintText
	ld a, $14
	ld c, a
	call DelayFrames
	jr .done
.declinedHealing
	call LoadScreenTilesFromBuffer1 ; restore screen
.done
	ld hl, PokemonCenterFarewellText
	call PrintText
	jp UpdateSprites

BitchWelcomeText:
	TX_FAR _PokemonCenterWelcomeText
	db "@"

BitchShallWeHealYourPokemonText:
	TX_DELAY
	TX_FAR _ShallWeHealYourPokemonText
	db "@"

BitchNeedYourPokemonText:
	TX_FAR _NeedYourPokemonText
	db "@"

BitchPokemonFightingFitText:
	TX_FAR _PokemonFightingFitText
	db "@"

BitchPokemonCenterFarewellText:
	TX_DELAY
	TX_FAR _PokemonCenterFarewellText
	db "@"