db DEX_POLIWRATH ; pokedex id
db 93 ; base hp
db 98 ; base attack
db 117 ; base speed
db 92 ; base defense
db 100 ; base special
db WATER ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 144 ; base exp yield
INCBIN "pic/bmon/poliwrath.pic",0,1 ; 77, sprite dimensions
dw PoliwrathPicFront
dw PoliwrathPicFront
; attacks known at lvl 0
db TACKLE
db TAIL_WHIP
db BUBBLE
db WATER_GUN
db 3 ; growth rate
; learnset
	tmlearn 1,5,6,8
	tmlearn 9,10,11,12,13,14,15
	tmlearn 17,18,19,20
	tmlearn 26,27,29,31,32
	tmlearn 34,35,40
	tmlearn 44,46
	tmlearn 50,53,54
db 0 ; padding
