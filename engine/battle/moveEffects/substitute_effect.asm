SubstituteEffect_:
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonMaxHP
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .notEnemy
	ld hl, wEnemyMonMaxHP
	ld de, wEnemySubstituteHP
	ld bc, wEnemyBattleStatus2
.notEnemy
	ld a, [bc]
	bit HasSubstituteUp, a ; user already has substitute?
	jr nz, .alreadyHasSubstitute
; quarter health to remove from user
; assumes max HP is 1023 or lower
	push bc
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b ; max hp / 4
	push de
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de ; point hl to current HP low byte
	pop de
	ld a, b
	ld [de], a ; save copy of HP to subtract in ccd7/ccd8 [how much HP substitute has]
	ld a, [hld]
; subtract [max hp / 4] to current HP
	sub b
	ld d, a
	ld a, [hl]
	sbc 0
	pop bc
	jr c, .notEnoughHP ; underflow means user would be left with negative health
                           ; bug: since it only branches on carry, it will possibly leave user with 0 HP
.userHasZeroOrMoreHP
	ldi [hl], a ; save resulting HP after subtraction into current HP
	ld [hl], d
	ld h, b
	ld l, c
	set HasSubstituteUp, [hl]
	ld a, [wOptions]
	bit 7, a ; battle animation is enabled?
	ld hl, PlayCurrentMoveAnimation
	ld b, BANK(PlayCurrentMoveAnimation)
	jr z, .animationEnabled
	ld hl, AnimationSubstitute
	ld b, BANK(AnimationSubstitute)
.animationEnabled
	call Bankswitch ; jump to routine depending on animation setting
	ld hl, SubstituteText
	call PrintText
	jpab DrawHUDsAndHPBars
.alreadyHasSubstitute
	ld hl, HasSubstituteText
	jr .printText
.notEnoughHP
	ld hl, TooWeakSubstituteText
.printText
	jp PrintText

SubstituteText:
	TX_FAR _SubstituteText
	db "@"

HasSubstituteText:
	TX_FAR _HasSubstituteText
	db "@"

TooWeakSubstituteText:
	TX_FAR _TooWeakSubstituteText
	db "@"
