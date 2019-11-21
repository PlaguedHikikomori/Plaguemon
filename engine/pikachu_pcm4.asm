PlayPikachuSoundClip4::
	ld a, e
	ld e, a
	ld d, $0
	ld hl, PikachuCriesPointerTable4
	add hl, de
	add hl, de
	add hl, de
	ld b, [hl] ; bank of pikachu cry data
	inc hl
	ld a, [hli] ; cry data pointer
	ld h, [hl]
	ld l, a
	ld c, $4
.loop
	dec c
	jr z, .done_delay
	call DelayFrame
	jr .loop

.done_delay
	di
	push bc
	push hl
	ld a, $80
	ld [rNR52], a
	ld a, $77
	ld [rNR50], a
	xor a
	ld [rNR30], a
	ld hl, $ff30 ; wave data
	ld de, wRedrawRowOrColumnSrcTiles
.saveWaveDataLoop
	ld a, [hl]
	ld [de], a
	inc de
	ld a, $ff
	ld [hli], a
	ld a, l
	cp $40 ; end of wave data
	jr nz, .saveWaveDataLoop
	ld a, $80
	ld [rNR30], a
	ld a, [rNR51]
	or $44
	ld [rNR51], a
	ld a, $ff
	ld [rNR31], a
	ld a, $20
	ld [rNR32], a
	ld a, $ff
	ld [rNR33], a
	ld a, $87
	ld [rNR34], a
	pop hl
	pop bc
	call PlayPikachuPCM4
	xor a
	ld [wc0f3], a
	ld [wc0f4], a
	ld a, $80
	ld [rNR52], a
	xor a
	ld [rNR30], a
	ld hl, $ff30
	ld de, wRedrawRowOrColumnSrcTiles
.reloadWaveDataLoop
	ld a, [de]
	inc de
	ld [hli], a
	ld a, l
	cp $40 ; end of wave data
	jr nz, .reloadWaveDataLoop
	ld a, $80
	ld [rNR30], a
	ld a, [rNR51]
	and $bb
	ld [rNR51], a
	xor a
	ld [wChannelSoundIDs+Ch4], a
	ld [wChannelSoundIDs+Ch5], a
	ld [wChannelSoundIDs+Ch6], a
	ld [wChannelSoundIDs+Ch7], a
	ld a, [H_LOADEDROMBANK]
	ei
	ret


	
PlayPikachuPCM4::
	ld a, [H_LOADEDROMBANK]
	push af
	ld a, b
	call BankswitchCommon4
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
.loop
	ld a, [hli]
	ld d, a
	ld a, $3
.playSingleSample
	dec a
	jr nz, .playSingleSample

	rept 7
	call LoadNextSoundClipSample4
	call PlaySoundClipSample4
	endr

	call LoadNextSoundClipSample4
	dec bc
	ld a, c
	or b
	jr nz, .loop
	pop af
	call BankswitchCommon4
	ret
	
BankswitchCommon4::
	ld [H_LOADEDROMBANK], a
	ld [MBC1RomBank], a
	ret
	
LoadNextSoundClipSample4::
	ld a, d
	and $80
	srl a
	srl a
	ld [rNR32], a
	sla d
	ret

PlaySoundClipSample4::
	ld a, $3
.loop
	dec a
	jr nz, .loop
	ret
	
PikachuCriesPointerTable4:
	pikacry_def PikachuCry6
	pikacry_def PikachuCry7