SaffronCityScript:
	jp EnableAutoTextBoxDrawing

SaffronCityTextPointers:
	dw SaffronCityText1
	dw SaffronCityText2
	dw SaffronCityText3
	dw SaffronCityText4
	dw SaffronCityText5
	dw SaffronCityText6
	dw SaffronCityText7
	dw SaffronCityText8
	dw SaffronCityText9
	dw SaffronCityText10
	dw SaffronCityText11
	dw SaffronCityText12
	dw SaffronCityText13
	dw SaffronCityText14
	dw SaffronCityText15
	dw SaffronCityText16
	dw SaffronCityText17
	dw SaffronCityText18
	dw MartSignText
	dw SaffronCityText20
	dw SaffronCityText21
	dw SaffronCityText22
	dw PokeCenterSignText
	dw SaffronCityText24
	dw SaffronCityText25

SaffronCityText1:
	TX_FAR _SaffronCityText1
	db "@"

SaffronCityText2:
	TX_FAR _SaffronCityText2
	db "@"

SaffronCityText3:
	TX_FAR _SaffronCityText3
	db "@"

SaffronCityText4:
	TX_FAR _SaffronCityText4
	db "@"

SaffronCityText5:
	TX_FAR _SaffronCityText5
	db "@"

SaffronCityText6:
	TX_FAR _SaffronCityText6
	db "@"

SaffronCityText7:
	TX_FAR _SaffronCityText7
	db "@"

SaffronCityText8:
	TX_FAR _SaffronCityText8
	db "@"

SaffronCityText9:
	TX_ASM
	CheckEvent EVENT_GOT_LAPRAS, 1
	jp c, .alreadyGotLapras
	ld hl, .LaprasNotBeenObtainedYetText
	call PrintText
.laprasNotBeenObtainedYet
	ld a, LAPRAS
	call DisplayPokedex
	lb bc, LAPRAS, 30
	call GivePokemon
	SetEvent EVENT_GOT_LAPRAS
	jr .done
.alreadyGotLapras
	ld hl, .AlreadyGotLaprasText
.printText
	call PrintText
.done
	jp TextScriptEnd

.LaprasNotBeenObtainedYetText
	TX_FAR _SaffronCityText9
	db "@"

.AlreadyGotLaprasText
	TX_FAR _SaffronCityText10
	db "@"

SaffronCityText10:
	TX_FAR _SaffronCityText10
	db "@"

SaffronCityText11:
	TX_FAR _SaffronCityText11
	db "@"

SaffronCityText12:
	TX_FAR _SaffronCityText12
	TX_CRY_PIDGEOT
	db "@"

SaffronCityText13:
	TX_FAR _SaffronCityText13
	db "@"

SaffronCityText14:
	TX_FAR _SaffronCityText14
	db "@"

SaffronCityText15:
	TX_FAR _SaffronCityText15
	db "@"

SaffronCityText16:
	TX_FAR _SaffronCityText16
	db "@"

SaffronCityText17:
	TX_FAR _SaffronCityText17
	db "@"

SaffronCityText18:
	TX_FAR _SaffronCityText18
	db "@"

SaffronCityText20:
	TX_FAR _SaffronCityText20
	db "@"

SaffronCityText21:
	TX_FAR _SaffronCityText21
	db "@"

SaffronCityText22:
	TX_FAR _SaffronCityText22
	db "@"

SaffronCityText24:
	TX_FAR _SaffronCityText24
	db "@"

SaffronCityText25:
	TX_FAR _SaffronCityText25
	db "@"
