CardsAvailable:
	ld a, $4    
	ld [wStar], a
	ld [wCircle], a
	ld [wSquare], a
	ld [wWaves], a
	ld [wPlus], a
	ret



SecretCard:
	call Random
	cp $10
	jr nz, .notStar
	ld b, a
	ld a, [wStar]
	cp $FF
	jp z, .notStar
	dec a
	ld [wStar], a
	ld a, b
	ld [wWhichCard], a
	ret
.notStar
	call Random
	cp $20
	jr nz, .notCircle
	ld b, a
	ld a, [wCircle]
	cp $FF
	jp z, .notCircle
	dec a
	ld [wCircle], a
	ld a, b
	ld [wWhichCard], a
	ret
.notCircle
	call Random
	cp $30
	jr nz, .notSquare
	ld b, a
	ld a, [wSquare]
	cp $FF
	jp z, .notSquare
	dec a
	ld [wSquare], a
	ld a, b
	ld [wWhichCard], a
	ret
.notSquare
	call Random
	cp $40
	jr nz, .notWaves
	ld b, a
	ld a, [wWaves]
	cp $FF
	jp z, .notWaves
	dec a
	ld [wWaves], a
	ld a, b
	ld [wWhichCard], a
	ret
.notWaves
	call Random
	cp $50
	jr nz, SecretCard
	ld b, a
	ld a, [wPlus]
	cp $FF
	jp z, SecretCard
	dec a
	ld [wPlus], a
	ld a, b
	ld [wWhichCard], a
	ret

