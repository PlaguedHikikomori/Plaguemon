SpaceWorldScript:
    ld a, REDS_HOUSE_2F
	ld [wLastMap], a
    call EnableAutoTextBoxDrawing
	ld a, [hJoyPressed]
	cp B_BUTTON
	ret nz
	call Bullet2
	ret
	
Shmup1:

	INCBIN "gfx/red/shmup1.2bpp"
Shmup1End:
	
SpaceWorldTextPointers:
    dw PickUpItemText
	
	
RightEnemyDistance:
	ld a, [wOAMBuffer + 1]
	ld c, a
	ld a, [wOAMBuffer + 17]
	sub c
	ld d, a
	ret
	
	

    
	
	

    


