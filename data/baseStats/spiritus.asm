db DEX_SPIRITUS ; pokedex id
db 99 ; base hp
db 99 ; base attack
db 99 ; base defense
db 199; base speed
db 150 ; base special
db PSYCHIC ; species type 1
db DRAGON  ; species type 2
db 50 ; catch rate
db 186 ; base exp yield
INCBIN "pic/bmon/spiritus.pic",0,1 ; 77, sprite dimensions
dw SpiritusPicFront
dw SpiritusPicFront
; attacks known at lvl 0
db TELEPORT
db CONFUSION
db DISABLE
db 0
db 3 ; growth rate
; learnset
	tmlearn 1,2,3,4,5,6,7,8
	tmlearn 9,10,11,12,13,14,15,16
	tmlearn 17,18,19,20,21,22,23,24
	tmlearn 25,26,27,28,29,30,31,32
	tmlearn 33,34,35,36,37,38,39,40
	tmlearn 41,42,43,44,45,46,47,48
	tmlearn 49,50,51,52,53,54,55,56
db 0 ; padding
