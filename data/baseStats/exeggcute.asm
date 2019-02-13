db DEX_EXEGGCUTE ; pokedex id
db 60 ; base hp
db 40 ; base attack
db 80 ; base defense
db 40 ; base speed
db 60 ; base special
db NORMAL ; species type 1
db PUPPET ; species type 2
db 90 ; catch rate
db 98 ; base exp yield
INCBIN "pic/bmon/exeggcute.pic",0,1 ; 77, sprite dimensions
dw ExeggcutePicFront
dw ExeggcutePicBack
; attacks known at lvl 0
db DEFENSE_CURL
db CREEPY_STARE
db 0
db 0
db 5 ; growth rate
; learnset
	tmlearn 6
	tmlearn 9,10
	tmlearn 20
	tmlearn 29,30,31,32
	tmlearn 33,34,36,37
	tmlearn 44,46,47
	tmlearn 50
db 0 ; padding
