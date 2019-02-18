KnifeRoomScript:
	call CheckAlive
	call SegnaPunti
	call RefreshWave
	ret
	
	

	
KnifeRoomTextPointers:
    dw PickUpItemText
	
	
ScoreText:
	TX_FAR _ScoreText
	db "@"
	
_ScoreText::
	text "SCORE: "
	done 
	
RefreshWave:
	ld a, [$C0B8]
	cp $30
	ret nz
	call LoadMapData
	ret

CheckAlive:
	ld a, [wZombieLifes]
	cp $00
	ret nz
	ld hl, ScoreText
	call PrintText
	call DisplayTextID
	call HighScore
	ld c, 60
	call DelayFrames
	call HandleBlackOut
	ret
	
	
CompareTable:
	ld a, [de]
	cp $09
	ret z
	ld a, [de]
	cp $19
	ret z
	ld a, [de]
	cp $29
	ret z
	ld a, [de]
	cp $39
	ret z
	ld a, [de]
	cp $49
	ret z
	ld a, [de]
	cp $59
	ret z
	ld a, [de]
	cp $69
	ret z
	ld a, [de]
	cp $79
	ret z
	ld a, [de]
	cp $89
	ret z
	ld a, [de]
	cp $99
	ret z
	ld a, [de]
	cp $A9
	ret z
	ld a, [de]
	cp $B9
	ret z
	ld a, [de]
	cp $C9
	ret z
	ld a, [de]
	cp $D9
	ret z
	ld a, [de]
	cp $E9
	ret z
	ld a, [de]
	cp $F9
	ret z
	ret 
	
LoadScore:	
	ld de, wScore + 1
	call CompareTable
	jr z, .up
	inc a
	ld [de], a
	jr SegnaPunti
.up
	inc a
	inc a
	inc a
	inc a
	inc a
	inc a
	inc a
	ld [de], a
SegnaPunti:
	ld de, wScore + 1
	cp $A0
	jr nz, .nope
	xor a
	ld [de], a
	ld de, wScore
	ld a, [de]
	inc a
	ld [de], a
.nope
	coord hl, 0, 0
	ld de, wScore
	ld c, $2
	call PrintBCDNumber
	ret
	
ResetZombieScore:
	ld a, [wCurMap]
	cp KNIFE_ROOM
	ret z
	xor a
	ld de, wScore
	ld [de], a
	ld de, wScore + 1
	ld [de] , a
	ret
	
	
HighScore:
	ld de, wScore + 1
	cp $A0
	jr nz, .nope
	xor a
	ld [de], a
	ld de, wScore
	ld a, [de]
	inc a
	ld [de], a
.nope
	coord hl, 15, 1
	ld de, wScore
	ld c, $2
	call PrintBCDNumber
	ret