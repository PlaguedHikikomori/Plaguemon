db DEX_PROGLOTTO ; pokedex id
db 96 ; base hp
db 96 ; base attack
db 96 ; base defense
db 96 ; base speed
db 96 ; base special
db NORMAL ; species type 1
db GROUND ; species type 2
db 25 ; catch rate
db 70 ; base exp yield
INCBIN "pic/bmon/proglotto.pic",0,1 ; 77, sprite dimensions
dw ProglottoPicFront
dw ProglottoPicFront
; attacks known at lvl 0
db TRANSFORM
db 0
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
	tmlearn 0
db 0 ; padding
