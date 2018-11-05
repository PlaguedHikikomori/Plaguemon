RedsHouse1FScript:
	jp EnableAutoTextBoxDrawing

RedsHouse1FTextPointers:
	dw RedsHouse1FText1
	dw RedsHouse1FText2

RedsHouse1FText1: ; Mom
	TX_ASM
	ld a, [wd72e]
	bit 3, a
	jr nz, .heal ; if player has received a Pokémon from Oak, heal team
	ld hl, MomWakeUpText
	call PrintText
	jr .done
.heal
	call MomHealPokemon
.done
	jp TextScriptEnd

MomWakeUpText:
	TX_FAR _MomWakeUpText
	db "@"

MomHealPokemon:
	ld hl, MomHealText1
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, [wAudioROMBank] ; save the actual music bank
	ld b, a ; save it to b register
	ld a, BANK(Music_PalletTown) ; load the pallet town music bank
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a ; set it on ram
	push bc ; save bc registers on the stack
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
	xor a
    ld [wd736], a
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	pop bc ; retrieve the saved bc register cointaining the old music bank
	ld a, b ; move the old music bank to a
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a ; set it on ram
	call PlayDefaultMusic
	call GBFadeInFromWhite
	ld hl, MomHealText2
	jp PrintText

MomHealText1:
	TX_FAR _MomHealText1
	db "@"
MomHealText2:
	TX_FAR _MomHealText2
	db "@"

RedsHouse1FText2: ; TV
	TX_ASM
	ld a,[wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	ld hl,TVWrongSideText
	jr nz,.notUp
	ld hl,StandByMeText
.notUp
	call PrintText
	jp TextScriptEnd

StandByMeText:
	TX_FAR _StandByMeText
	db "@"

TVWrongSideText:
	TX_FAR _TVWrongSideText
	db "@"
