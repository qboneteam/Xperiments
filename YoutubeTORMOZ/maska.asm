	device zxspectrum128

	org	#6000
maskotablichka:
	db	0,%11101110
	db	4,%11101110
	db	2,%10111011
	db	6,%10111011
	db	0,%10111011
	db	4,%10111011
	db	2,%11101110
	db	6,%11101110

	db	1,%11011101
	db	5,%11011101
	db	3,%01110111
	db	7,%01110111
	db	1,%01110111
	db	5,%01110111
	db	3,%11011101
	db	7,%11011101

	db	0,%11011101
	db	4,%11011101
	db	2,%01110111
	db	6,%01110111
	db	0,%01110111
	db	4,%01110111
	db	2,%11011101
	db	6,%11011101

	db	1,%11101110
	db	5,%11101110
	db	3,%10111011
	db	7,%10111011
	db	1,%10111011
	db	5,%10111011
	db	3,%11101110
	db	7,%11101110

	align #100
zbrajd:
	db	%00000000,%00000000
	db	%00000000,%00000000
	db	%00000011,%11000000
	db	%00001111,%11110000
	db	%00011111,%11111000
	db	%00011111,%11111000
	db	%00111111,%11111100
	db	%00111111,%11111100
	db	%00111111,%11111100
	db	%00111111,%11111100
	db	%00011111,%11111000
	db	%00011111,%11111000
	db	%00001111,%11110000
	db	%00000011,%11000000
	db	%00000000,%00000000
	db	%00000000,%00000000

	align #100
ytspriteaddr:
	dw	#40ef
	dw	#4812
	dw	#4873
	dw	#48d2
	dw	#48ef
	dw	#48cc
	dw	#486b
	dw	#480c

SnaStart:
	ld	hl,#5800
	ld	de,#5801
	ld	bc,#2ff
	ld	(hl),%00000111
	ldir

	ld	hl,pizdauskas2
	ld	de,syuda
	ld	bc,256*4
	ldir
	ld	(hl),#c9

	ei
ZaLoop:
	xor	a
	out	(#fe),a
	halt
	inc	a
	out	(#fe),a
	call showsprite
	call kakaya
	jr ZaLoop

showsprite:
	ld	a,0
	inc	a
	and	%00000011
	ld (showsprite+1),a
	jr nz,.l1
	ld	a,(.l1+1)
	inc	a
	and	7
	ld	(.l1+1),a
.l1
	ld a,0
	add	a
	ld l,a
	ld	h,high ytspriteaddr
	ld	e,(hl)
	inc l
	ld d,(hl)

	ld hl,zbrajd
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:dec e:dec e

	INC d
	LD A,d
	AND 7
	JR NZ,.l0
	LD A,e
	SUB -32
	LD e,A
	SBC A,A
	AND -8
	ADD A,d
	LD d,A
.l0:

	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi:inc d:dec e:dec e
	ldi:ldi
	ret

kakaya:
	ld	a,#ff
	inc	a
	and	%00011111
	ld	(kakaya+1),a

	ld	h,high maskotablichka
	add	a
	ld	l,a
	ld	e,(hl)
	inc	l
	ld	d,(hl)
	ld	l,0

	ld	a,d
;	cpl
	ld	(pizdauskas+1),a

	ld	a,#40
	add	e
	ld	h,a
	push	hl
	push	hl
	call	pizdauskas

	pop	hl
	ld	a,#08
	add	h
	ld	h,a
	call	pizdauskas

	pop	hl
	ld	a,#10
	add	h
	ld	h,a
	call	pizdauskas
	ret

pizdauskas:
	ld	b,#fe
pizdauskas2
	ld	a,(hl)
	and	b
	ld	(hl),a
	inc	l
syuda:
	display	"introsize=",$-#6000
	savesna "maska.sna",SnaStart
