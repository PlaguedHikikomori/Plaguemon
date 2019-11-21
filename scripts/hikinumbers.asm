PrintNumberHiki:
	ld a, [wZenerCardsDeck]
	cp $1A
	jr nz, .not25
	ld de, Num25
	coord hl, 2, 15
	call PlaceString
.not25
	ld a, [wZenerCardsDeck]
	cp $19
	jr nz, .not24
	ld de, Num24
	coord hl, 2, 15
	call PlaceString
.not24
	ld a, [wZenerCardsDeck]
	cp $18
	jr nz, .not23
	ld de, Num23
	coord hl, 2, 15
	call PlaceString
.not23
	ld a, [wZenerCardsDeck]
	cp $17
	jr nz, .not22
	ld de, Num22
	coord hl, 2, 15
	call PlaceString
.not22
	ld a, [wZenerCardsDeck]
	cp $16
	jr nz, .not21
	ld de, Num21
	coord hl, 2, 15
	call PlaceString
.not21
	ld a, [wZenerCardsDeck]
	cp $15
	jr nz, .not20
	ld de, Num20
	coord hl, 2, 15
	call PlaceString
.not20
	ld a, [wZenerCardsDeck]
	cp $14
	jr nz, .not19
	ld de, Num19
	coord hl, 2, 15
	call PlaceString
.not19
	ld a, [wZenerCardsDeck]
	cp $13
	jr nz, .not18
	ld de, Num18
	coord hl, 2, 15
	call PlaceString
.not18
	ld a, [wZenerCardsDeck]
	cp $12
	jr nz, .not17
	ld de, Num17
	coord hl, 2, 15
	call PlaceString
.not17
	ld a, [wZenerCardsDeck]
	cp $11
	jr nz, .not16
	ld de, Num16
	coord hl, 2, 15
	call PlaceString
.not16
	ld a, [wZenerCardsDeck]
	cp $10
	jr nz, .not15
	ld de, Num15
	coord hl, 2, 15
	call PlaceString
.not15
	ld a, [wZenerCardsDeck]
	cp $F
	jr nz, .not14
	ld de, Num14
	coord hl, 2, 15
	call PlaceString
.not14
	ld a, [wZenerCardsDeck]
	cp $E
	jr nz, .not13
	ld de, Num13
	coord hl, 2, 15
	call PlaceString
.not13
	ld a, [wZenerCardsDeck]
	cp $D
	jr nz, .not12
	ld de, Num12
	coord hl, 2, 15
	call PlaceString
.not12
	ld a, [wZenerCardsDeck]
	cp $C
	jr nz, .not11
	ld de, Num11
	coord hl, 2, 15
	call PlaceString
.not11
	ld a, [wZenerCardsDeck]
	cp $B
	jr nz, .not10
	ld de, Num10
	coord hl, 2, 15
	call PlaceString
.not10
	ld a, [wZenerCardsDeck]
	cp $A
	jr nz, .not9
	ld de, Num9
	coord hl, 2, 15
	call PlaceString
.not9
	ld a, [wZenerCardsDeck]
	cp $9
	jr nz, .not8
	ld de, Num8
	coord hl, 2, 15
	call PlaceString
.not8
	ld a, [wZenerCardsDeck]
	cp $8
	jr nz, .not7
	ld de, Num7
	coord hl, 2, 15
	call PlaceString
.not7
	ld a, [wZenerCardsDeck]
	cp $7
	jr nz, .not6
	ld de, Num6
	coord hl, 2, 15
	call PlaceString
.not6
	ld a, [wZenerCardsDeck]
	cp $6
	jr nz, .not5
	ld de, Num5
	coord hl, 2, 15
	call PlaceString
.not5
	ld a, [wZenerCardsDeck]
	cp $5
	jr nz, .not4
	ld de, Num4
	coord hl, 2, 15
	call PlaceString
.not4
	ld a, [wZenerCardsDeck]
	cp $4
	jr nz, .not3
	ld de, Num3
	coord hl, 2, 15
	call PlaceString
.not3
	ld a, [wZenerCardsDeck]
	cp $3
	jr nz, .not2
	ld de, Num2
	coord hl, 2, 15
	call PlaceString
.not2
	ld a, [wZenerCardsDeck]
	cp $2
	jr nz, .not1
	ld de, Num1
	coord hl, 2, 15
	call PlaceString
.not1
	ret

	
; PRINT GUESSED CARDS NUMBER	
GuessedPrint:
	ld a, [wGuessed]
	jr nz, .g1
	ld de, Num0
	coord hl, 16, 15
	call PlaceString
	ret
.g1
	ld a, [wGuessed]
	cp $1
	jr nz, .g2
	ld de, Num1
	coord hl, 16, 15
	call PlaceString
	ret
.g2
	ld a, [wGuessed]
	cp $2
	jr nz, .g3
	ld de, Num2
	coord hl, 16, 15
	call PlaceString
.g3
	ld a, [wGuessed]
	cp $3
	jr nz, .g4
	ld de, Num3
	coord hl, 16, 15
	call PlaceString
.g4
	ld a, [wGuessed]
	cp $4
	jr nz, .g5
	ld de, Num4
	coord hl, 16, 15
	call PlaceString
.g5
	ld a, [wGuessed]
	cp $5
	jr nz, .g6
	ld de, Num5
	coord hl, 16, 15
	call PlaceString
.g6
	ld a, [wGuessed]
	cp $6
	jr nz, .g7
	ld de, Num6
	coord hl, 16, 15
	call PlaceString
.g7
	ld a, [wGuessed]
	cp $7
	jr nz, .g8
	ld de, Num7
	coord hl, 16, 15
	call PlaceString
.g8
	ld a, [wGuessed]
	cp $8
	jr nz, .g9
	ld de, Num8
	coord hl, 16, 15
	call PlaceString
.g9
	ld a, [wGuessed]
	cp $9
	jr nz, .gA
	ld de, Num9
	coord hl, 16, 15
	call PlaceString
.gA
	ld a, [wGuessed]
	cp $A
	jr nz, .gB
	ld de, Num10
	coord hl, 16, 15
	call PlaceString
.gB
	ld a, [wGuessed]
	cp $B
	jr nz, .gC
	ld de, Num11
	coord hl, 16, 15
	call PlaceString
.gC
	ld a, [wGuessed]
	cp $C
	jr nz, .gD
	ld de, Num12
	coord hl, 16, 15
	call PlaceString
.gD
	ld a, [wGuessed]
	cp $D
	jr nz, .gE
	ld de, Num13
	coord hl, 16, 15
	call PlaceString
.gE
	ld a, [wGuessed]
	cp $E
	jr nz, .gF
	ld de, Num14
	coord hl, 16, 15
	call PlaceString
.gF
	ld a, [wGuessed]
	cp $F
	jr nz, .g10
	ld de, Num15
	coord hl, 16, 15
	call PlaceString
.g10
	ret
	
	
	

Num25:
	db   $02,$05
	db   "@"
	
Num24:
	db   $02,$04
	db   "@"
	
Num23:
	db   $02,$03
	db   "@"
	
Num22:
	db   $02,$02
	db   "@"

Num21:
	db   $02,$01
	db   "@"
	
Num20:
	db   $02,$0A
	db   "@"
	
Num19:
	db   $01,$09
	db   "@"
	
Num18:
	db   $01,$08
	db   "@"
	
Num17:
	db   $01,$07
	db   "@"

Num16:
	db   $01,$06
	db   "@"
	
Num15:
	db   $01,$05
	db   "@"
	
Num14:
	db   $01,$04
	db   "@"
	
Num13:
	db   $01,$03
	db   "@"
	
Num12:
	db   $01,$02
	db   "@"
	
Num11:
	db   $01,$01
	db   "@"
	
Num10:
	db   $01,$0A
	db   "@"
	
Num9:
	db   $0A,$09
	db   "@"
	
Num8:
	db   $0A,$08
	db   "@"
	
Num7:
	db   $0A,$07
	db   "@"
	
Num6:
	db   $0A,$06
	db   "@"
	
Num5:
	db   $0A,$05
	db   "@"
	
Num4:
	db   $0A,$04
	db   "@"
	
Num3:
	db   $0A,$03
	db   "@"
	
Num2:
	db   $0A,$02
	db   "@"
	
Num1:
	db   $0A,$01
	db   "@"
	
Num0:
	db   $0A,$0A
	db   "@"
	
