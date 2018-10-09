db DEX_KANGASKHAN ; pokedex id
db 130 ; base hp
db 100 ; base attack
db 75 ; base defense
db 70 ; base speed
db 50 ; base special
db FIRE   ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 175 ; base exp yield
INCBIN "pic/bmon/kangaskhan.pic",0,1 ; 77, sprite dimensions
dw KangaskhanPicFront
dw KangaskhanPicBack
; attacks known at lvl 0
db COMET_PUNCH
db RAGE
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14,15
	tmlearn 17,18,19,20,24
	tmlearn 25,26,27,31,32
	tmlearn 34,38,40
	tmlearn 44,48
	tmlearn 50,53,54
db 0 ; padding
