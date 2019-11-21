SadFace:
	ld a, [hJoyPressed]
	cp SELECT 
	ret nz
	;ld a, [wSadness]
	;cp $9
	;jp nc, .supersad

	call DisplayMonFrontSpriteInBox
	ret

