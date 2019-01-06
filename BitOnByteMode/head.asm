	device zxspectrum128

	org #4000
	incbin "hair.bin"

	org	#6000
SnaStart:
	ei

	xor a
	out (#fe),a

	ld hl,#4000
	ld bc,#1800
.l0:
;	halt
	ld a,(hl)
	cpl
	ld (hl),a

	xor a

	ld d,8
.l2:
	rrc (hl)
	jr nc,.l1
	inc a
.l1:
	dec d
	jr nz,.l2

	sub 7
	sbc a,a

	cpl
	ld (hl),a

	inc hl

	dec bc
	ld a,b
	or c
	jr nz,.l0

	jr $

	savesna "head.sna",SnaStart