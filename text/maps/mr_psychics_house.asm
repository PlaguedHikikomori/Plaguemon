_TM29PreReceiveText::
	text "...Wait! Don't"
	line "say a word!"

	para "You wanted this!"
	prompt

_ReceivedTM29Text::
	text "<PLAYER> received"
	line "@"
	TX_RAM wcf4b
	text "!@@"

_TM29ExplanationText::
	text "TM29 is PSYCHIC!"

	para "It can lower the"
	line "target's SPECIAL"
	cont "abilities."
	done

_TM29NoRoomText::
	text "Where do you plan"
	line "to put this?"
	done
