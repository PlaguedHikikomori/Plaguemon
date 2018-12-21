InternalThought:
	push af
	ld a, %00000000
	ld [rOBP0], a
	ld a, %11111111
	ld [rOBP1], a
	ld a, %01111111
	ld [rBGP], a	
	call Sadness
	call RunDefaultPaletteCommand
	call GBPalNormal
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
.nonZero
	tx_pre WantToKillText
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
	

	
