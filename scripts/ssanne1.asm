SSAnne1Script:
	call EnableAutoTextBoxDrawing
	ret

SSAnne1TextPointers:
	dw SSAnne1Text1
	dw SSAnne1Text2

SSAnne1Text1:
	TX_FAR _SSAnne1Text1
	db "@"

SSAnne1Text2:
	TX_FAR _SSAnne1Text2
	db "@"
