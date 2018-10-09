_OakSpeechText1::
	text "Hello there!"
	line "Long time no see,"
	cont "huh?"

	para "It's me, THE PROF!"
	line "Things changed"
	cont "over here.."
    cont  "over years.."
	prompt

_OakSpeechText2A::
	text "The place you know"
	line "it's not the same."
	cont "it collapsed,"
	cont "creatures mutated"
    cont "people got mad."
	prompt


_OakSpeechText2B::
	text $51,"Now, you have"
	line "to escape!"
	cont "Don't look back."
	cont "GO AWAY!"

	para "This game is"
    line "cursed."

	para "Please.."
	line "don't play it."
	prompt

_IntroducePlayerText::
	text "First, what is"
	line "your name?"
	prompt

_IntroduceRivalText::
	text "You carry a huge"
	line "secret, <PLAYER>."
	cont "Something evil..."
	cont "Something bad."

	para "It will always "
	line "follow you,"
	cont "watch your back."
	
	para "Sometimes you'll"
	line "barely see it."
	cont "Others, you won't."
	cont "Call him: EVILIO."
	prompt

_OakSpeechText3::
	text $E1,$E2,"NOW YOU WILL"
	line "BE SCANNED."

	para "What? Who are you?"
	line $E1,$E2,"THE PROGRAM IS"
	cont "What do you want?!"

	para $E1,$E2,"CODING YOUR SOUL"
	line "Leave me ALONE!"
	cont $E1,$E2,"PLEASE,STAND BY."
	cont "NOOOOOOOO!"
	
	done
