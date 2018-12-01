StabPlayer:
	call CheckPlayerIsInFrontOfSprite
	and a
	jp z, .return
	ld c, 5
	call DelayFrames
	call CheckPlayerIsInFrontOfSprite
	and a
	jp z, .return
	call HandleBlackOut
.return
	ret
	