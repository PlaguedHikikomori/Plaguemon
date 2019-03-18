db DEX_TRAPTOR ; pokedex id
db 100 ; base hp
db 105 ; base attack
db 100 ; base defense
db 110 ; base speed
db 130 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 0 ; catch rate
db 190 ; base exp yield
INCBIN "pic/bmon/traptor1.pic",0,1 ; 66, sprite dimensions
dw TraptorOnePicFront
dw TraptorOnePicFront
; attacks known at lvl 0
db STALKING
db UNDERWORLD
db LIMBO_LOOP
db KIDNAPPING
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,15
	tmlearn 17,18,19,20,21,24
	tmlearn 25,29,31,32
	tmlearn 34,35,36,40
	tmlearn 42,44,46,47
	tmlearn 50,54
db 0 ; padding
