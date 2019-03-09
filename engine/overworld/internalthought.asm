InternalThought:
	push af
	ld a, %00000000
	ld [rOBP0], a
	ld a, %11111111
	ld [rOBP1], a
	ld a, %01111111
	ld [rBGP], a	
	call Sadness
	ret
	
	
Sadness:
	ld a,MESSAGE_BOX
	ld [wTextBoxID],a
	call DisplayTextBoxID
	call EnableAutoTextBoxDrawing 
	pop af
	cp $56
	jr nz, .nonZero
	tx_pre SadnessText
	call Drama
.nonZero
	tx_pre WantToKillText
	call Drama
	ret
	
SadnessText:
	TX_FAR _SadnessText
	db "@"
	
_SadnessText::
	text "I'm SAD."
	prompt
	
WantToKillText:
	TX_FAR _WantToKillText
	db "@"
	
_WantToKillText::
	text "I want to"
	line "kill myself.."
	prompt

	
Drama:
	ld a, [wSadness]
	cp $5   ; Numero di motivi per cui essere tristi - dichiarato anche in gengar, evos_moves
	jr z, .here
	inc a
	ld [wSadness], a
	ret
.here
	call PreDrama
	ld a, $00
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $01
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $02
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $03
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $04
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	ld a, $05
	ld [wWhichPokemon], a
	callab TryEvolvingMon
	call PostDrama
	ret
	
PreDrama:
	call SaveScreenTilesToBuffer2
	ret
	
PostDrama:
	call LoadScreenTilesFromBuffer2
	call EnterMap
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	call UpdateSprites
	ret

	

	
