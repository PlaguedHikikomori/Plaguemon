dpikapic: macro
	db (\1_id - PikaPicAnimPointers) / 2
	endm

ldpikapic: macro
	ld \1, (\2_id - PikaPicAnimPointers) / 2
	endm

dpikaemotion: macro
	db (\1_id - PikachuEmotionTable) / 2
	endm

ldpikaemotion: macro
	ld \1, (\2_id - PikachuEmotionTable) / 2
	endm

dpikaanim: macro
	db (\1_id - PikaPicAnimBGFramesPointers) / 2
	endm

pikaframeend EQUS "db $e0"
pikaframe: macro
	db (\1_id - PikaPicTilemapPointers) / 2, \2
	endm

pikaframedelay EQUS "db 0,"

; Starter Pikachu emotion commands constants

	const_def
	const PIKAEMOTION_DUMMY1
	const PIKAEMOTION_PRINTTEXT
	const PIKAEMOTION_PLAYPCMSOUNDCLIP
	const PIKAEMOTION_DOEMOTIONBUBBLE
	const PIKAEMOTION_4
	const PIKAEMOTION_5
	const PIKAEMOTION_SUBCMD
	const PIKAEMOTION_DELAYFRAMES
	const PIKAEMOTION_DUMMY2
	const PIKAEMOTION_9
	const PIKAEMOTION_DUMMY3

	const_def
	const PIKAEMOTION_SUBCMD_LOADEXTRAPIKASPRITES
	const PIKAEMOTION_SUBCMD_LOADFONT
	const PIKAEMOTION_SUBCMD_SHOWMAPVIEW
	const PIKAEMOTION_SUBCMD_WAITBUTTONPRESS
	const PIKAEMOTION_SUBCMD_CHECKPEWTERCENTER
	const PIKAEMOTION_SUBCMD_CHECKLAVENDERTOWER
	const PIKAEMOTION_SUBCMD_CHECKBILLSHOUSE

	const_def
	const PIKASTEPDIR_DOWN
	const PIKASTEPDIR_UP
	const PIKASTEPDIR_LEFT
	const PIKASTEPDIR_RIGHT
	const PIKASTEPDIR_DOWN_LEFT
	const PIKASTEPDIR_DOWN_RIGHT
	const PIKASTEPDIR_UP_LEFT
	const PIKASTEPDIR_UP_RIGHT


; Macros for commands
pikaemotion_dummy1: MACRO
	db PIKAEMOTION_DUMMY1
ENDM

pikaemotion_printtext: MACRO
	db PIKAEMOTION_PRINTTEXT
	dw \1
ENDM

pikaemotion_pcm: MACRO
	db PIKAEMOTION_PLAYPCMSOUNDCLIP
IF _NARG > 0
	dpikacry \1
ELSE
	db $ff
ENDC
ENDM

pikaemotion_emotebubble: MACRO
	db PIKAEMOTION_DOEMOTIONBUBBLE
	db \1
ENDM

pikaemotion_movement: MACRO
	db PIKAEMOTION_4
	dw \1
ENDM

pikaemotion_pikapic: MACRO
	db PIKAEMOTION_5
	dpikapic \1
ENDM

pikaemotion_subcmd: MACRO
	db PIKAEMOTION_SUBCMD
	db \1
ENDM

pikaemotion_delay: MACRO
	db PIKAEMOTION_DELAYFRAMES
	db \1
ENDM

pikaemotion_dummy2: MACRO
	db PIKAEMOTION_DUMMY2
ENDM

pikaemotion_9: MACRO
	db PIKAEMOTION_9
ENDM

pikaemotion_dummy3: MACRO
	db PIKAEMOTION_DUMMY3
ENDM

pikacry_def: MACRO
\1_id:: dba \1
endm

dpikacry: MACRO
	db (\1_id - PikachuCriesPointerTable) / 3
	endm

ldpikacry: MACRO
	ld \1, (\2_id - PikachuCriesPointerTable) / 3
	ENDM

pikacry: MACRO
	ldpikacry a, \1
	endm

