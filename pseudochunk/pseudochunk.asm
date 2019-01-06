	device zxspectrum128

	org #5800
	incbin  "qblogo.bin"

	org	#6000
table_mask:
	db	%00010001,#40
	db	%01000100,#42
	db	%01000100,#40
	db	%00010001,#42

	db	%00100010,#41
	db	%10001000,#43
	db	%10001000,#41
	db	%00100010,#43

	db	%00100010,#40
	db	%10001000,#42
	db	%10001000,#40
	db	%00100010,#42

	db	%00010001,#41
	db	%01000100,#43
	db	%01000100,#41
	db	%00010001,#43

SnaStart:
	ei
	ld	hl,copy_sorc
	ld	de,copy_dest
	ld	bc,256*2
	ldir
	ld	(hl),#c9

ZaLoop:
	xor	a
	out	(#fe),a
	halt
	inc	a
	out	(#fe),a

screen_shift:
	ld	a,#ff
	inc	a
	and	%00001111
	ld	(screen_shift+1),a

	ld	h,high table_mask
	add	a
	ld	l,a
	ld	a,(hl)
	inc	l
	ld	h,(hl)
	ld	l,0
	xor	(hl)

	ld c,6
.l0	call someproc1
	inc h
	inc h
	inc h
	inc h
	dec c
	jr nz,.l0

	jr	ZaLoop

someproc1:
copy_sorc:
	ld	(hl),a
	inc	l
copy_dest:
	display	"introsize=",$-#6000
	savesna "pseudochunk.sna",SnaStart
