const_value = 1

	const POUND        ; 01
	const KARATE_CHOP  ; 02
	const DOUBLESLAP   ; 03
	const UNDERWORLD   ; 04
	const MEGA_PUNCH   ; 05
	const PAY_DAY      ; 06
	const BLACK_MASS   ; 07
	const ICE_PUNCH    ; 08
	const THUNDERPUNCH ; 09
	const SHANK_UP     ; 0a
	const VICEGRIP     ; 0b
	const GUILLOTINE   ; 0c
	const HURRICANE    ; 0d
	const SWORDS_DANCE ; 0e
	const CUT          ; 0f
	const GUST         ; 10
	const WING_ATTACK  ; 11
	const WHIRLWIND    ; 12
	const FLY          ; 13
	const BIND         ; 14
	const SLAM         ; 15
	const VINE_WHIP    ; 16
	const STOMP        ; 17
	const DOUBLE_KICK  ; 18
	const MEGA_KICK    ; 19
	const JUMP_KICK    ; 1a
	const ROLLING_KICK ; 1b
	const SAND_ATTACK  ; 1c
	const HEADBUTT     ; 1d
	const HORN_ATTACK  ; 1e
	const FURY_ATTACK  ; 1f
	const KIDNAPPING   ; 20
	const TACKLE       ; 21
	const BODY_SLAM    ; 22
	const WRAP         ; 23
	const TAKE_DOWN    ; 24
	const THRASH       ; 25
	const DOUBLE_EDGE  ; 26
	const TAIL_WHIP    ; 27
	const POISON_STING ; 28
	const TWINEEDLE    ; 29
	const PIN_MISSILE  ; 2a
	const LEER         ; 2b
	const BAD_TOOTH    ; 2c
	const GROWL        ; 2d
	const VENTRILOQUY  ; 2e
	const SING         ; 2f
	const SUPERSONIC   ; 30
	const SONICBOOM    ; 31
	const DISABLE      ; 32
	const ACID         ; 33
	const RITUAL       ; 34
	const SABBATH      ; 35
	const MIST         ; 36
	const WATER_GUN    ; 37
	const HYDRO_PUMP   ; 38
	const SURF         ; 39
	const ICE_BEAM     ; 3a
	const BLIZZARD     ; 3b
	const PSYBEAM      ; 3c
	const BUBBLEBEAM   ; 3d
	const AURORA_BEAM  ; 3e
	const HYPER_BEAM   ; 3f
	const PECK         ; 40
	const DRILL_PECK   ; 41
	const SUBMISSION   ; 42
	const LOW_KICK     ; 43
	const COUNTER      ; 44
	const SEISMIC_TOSS ; 45
	const STRENGTH     ; 46
	const ABSORB       ; 47
	const MEGA_DRAIN   ; 48
	const GROW_CANNABIS; 49
	const GROWTH       ; 4a
	const RAZOR_LEAF   ; 4b
	const SOLARBEAM    ; 4c
	const POISONPOWDER ; 4d
	const STUN_SPORE   ; 4e
	const SLEEP_POWDER ; 4f
	const PARANOIA     ; 50
	const CURSED_WIRES ; 51
	const GOD_REVENGE  ; 52
	const SACRIFICE    ; 53
	const THUNDERSHOCK ; 54
	const THUNDERBOLT  ; 55
	const THUNDER_WAVE ; 56
	const THUNDER      ; 57
	const ROCK_THROW   ; 58
	const CONVULSION   ; 59
	const FISSURE      ; 5a
	const TUNNEL       ; 5b
	const TOXIC        ; 5c
	const CONFUSION    ; 5d
	const MIND_CONTROL ; 5e
	const LIMBO_LOOP   ; 5f
	const DARK_VOODOO  ; 60
	const AGILITY      ; 61
	const QUICK_ATTACK ; 62
	const RAGE         ; 63
	const TELEPORT     ; 64
	const STALKING     ; 65
	const MOCKINGBIRD  ; 66
	const SCREECH      ; 67
	const DOUBLE_TEAM  ; 68
	const RECOVER      ; 69
	const HARDEN       ; 6a
	const MINIMIZE     ; 6b
	const SMOKESCREEN  ; 6c
	const BLACKMAIL    ; 6d
	const WITHDRAW     ; 6e
	const DEFENSE_CURL ; 6f
	const BARRIER      ; 70
	const LIGHT_SCREEN ; 71
	const HAZE         ; 72
	const REFLECT      ; 73
	const FOCUS_ENERGY ; 74
	const SADNESS      ; 75
	const METRONOME    ; 76
	const MIRROR_MOVE  ; 77
	const SUICIDE      ; 78
	const MACHINE_LEARN; 79
	const TRYPOPHOBIA  ; 7a
	const SMOG         ; 7b
	const SLUDGE       ; 7c
	const REVENANT     ; 7d
	const FIRE_BLAST   ; 7e
	const WATERFALL    ; 7f
	const CLAMP        ; 80
	const SHURIKEN     ; 81
	const SKULL_BASH   ; 82
	const SPIKE_CANNON ; 83
	const CONSTRICT    ; 84
	const BLANK_OUT    ; 85
	const EVIL_LAUGH   ; 86
	const PREGNANCY    ; 87
	const HI_JUMP_KICK ; 88
	const CREEPY_STARE ; 89
	const BRAIN_EATER  ; 8a
	const POISON_GAS   ; 8b
	const BARRAGE      ; 8c
	const LEECH_LIFE   ; 8d
	const JUDAHS_KISS  ; 8e
	const SKY_ATTACK   ; 8f
	const TRANSFORM    ; 90
	const BUBBLE       ; 91
	const DIZZY_PUNCH  ; 92
	const SPORE        ; 93
	const FLASH        ; 94
	const PSYWAVE      ; 95
	const SPLASH       ; 96
	const ACID_ARMOR   ; 97
	const CRABHAMMER   ; 98
	const EXPLOSION    ; 99
	const FURY_SWIPES  ; 9a
	const BONEMERANG   ; 9b
	const REST         ; 9c
	const ROCK_SLIDE   ; 9d
	const HYPER_FANG   ; 9e
	const SHARPEN      ; 9f
	const KASHIRA_SWAP ; a0
	const TRI_ATTACK   ; a1
	const SUPER_FANG   ; a2
	const SLASH        ; a3
	const DISCIPLE     ; a4
	const STRUGGLE     ; a5
	const PROTO_CANNON ; a6
	const MECHA_PUNCH  ; a7
	const LOW_ON_MEMORY; a8
	const HEADACHE     ; a9
	const CROP_CIRCLES ; aa
	const TIME_WARP    ; ab
	const WRATH_OF_GOD ; ac
	const JUDGEMENT    ; ad
	
NUM_ATTACKS EQU const_value
const_value = STRUGGLE + 1



	; Moves do double duty as animation identifiers.

	const SHOWPIC_ANIM
	const STATUS_AFFECTED_ANIM
	const ANIM_A8
	const ANIM_A9
	const TRADE_BALL_DROP_ANIM
	const TRADE_BALL_SHAKE_ANIM
	const TRADE_BALL_TILT_ANIM
	const TRADE_BALL_POOF_ANIM
	const XSTATITEM_ANIM ; use X Attack/Defense/Speed/Special
	const ANIM_AF
	const ANIM_B0
	const ANIM_B1
	const ANIM_B2
	const ANIM_B3
	const ANIM_B4
	const ANIM_B5
	const ANIM_B6
	const ANIM_B7
	const ANIM_B8
	const ANIM_B9
	const BURN_PSN_ANIM ; Plays when a monster is burned or poisoned
	const ANIM_BB
	const ANIM_BC
	const SLP_ANIM ; sleeping monster
	const ANIM_BE
	const SUBJ_ANIM ; subjugated monster
	const ANIM_C0
	const TOSS_ANIM ; toss Poké Ball
	const SHAKE_ANIM ; shaking Poké Ball when catching monster
	const POOF_ANIM ; puff of smoke
	const BLOCKBALL_ANIM ; trainer knocks away Poké Ball
	const GREATTOSS_ANIM ; toss Great Ball
	const ULTRATOSS_ANIM ; toss Ultra Ball or Master Ball
	const ANIM_C7
	const HIDEPIC_ANIM ; monster disappears
	const ROCK_ANIM ; throw rock
	const BAIT_ANIM ; throw bait
