db DEX_DRATINI ; pokedex id
db 94 ; base hp
db 96 ; base attack
db 98 ; base defense
db 94 ; base speed
db 118 ; base special
db GRASS ; species type 1
db DRAGON ; species type 2
db 45 ; catch rate
db 144 ; base exp yield
INCBIN "pic/bmon/dratini.pic",0,1 ; 55, sprite dimensions
dw DratiniPicFront
dw DratiniPicBack
; attacks known at lvl 0
db TACKLE
db GROWL
db GROW_CANNABIS
db VINE_WHIP
db 3 ; growth rate
; learnset
	tmlearn 6,8
	tmlearn 9,10,11,12,13,14
	tmlearn 20,23,24
	tmlearn 25,31,32
	tmlearn 33,34,38,39,40
	tmlearn 44,45
	tmlearn 50,53
db 0 ; padding
