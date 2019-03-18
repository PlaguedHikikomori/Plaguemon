PrintStatusAilment:
	ld a, [de]
	bit PSN, a
	jr nz, .psn
	bit BRN, a
	jr nz, .brn
	bit FRZ, a
	jr nz, .frz
	bit PAR, a
	jr nz, .par
	and SLP
	ret z
	ld a, "O"
	ld [hli], a
	ld a, "V"
	ld [hli], a
	ld [hl], "D"
	ret
.psn
	ld a, "T"
	ld [hli], a
	ld a, "M"
	ld [hli], a
	ld [hl], "R"
	ret
.brn
	ld a, "P"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld [hl], "S"
	ret
.frz
	ld a, "C"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld [hl], "M"
	ret
.par
	ld a, "A"
	ld [hli], a
	ld a, "N"
	ld [hli], a
	ld [hl], "X"
	ret
