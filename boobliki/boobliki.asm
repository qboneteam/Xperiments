	device zxspectrum128

	org	#6000
SnaStart:

;	ld hl,risovach

genya:
	ld hl,risovach
	ld de,rrrddd
	ld bc,(rrrddd-risovach)*127
	ldir
	ex hl,de
	ld (hl),#c3
	inc hl
	ld (hl),low savesp
	inc hl
	ld (hl),high savesp

	ld hl,sintab
	ld de,sintab+64
	ld bc,#100
	ldir

fill_kuda:
	ld xl,96
	ld bc,#29
	ld hl,risovach+16
	ld de,#4000+30
.l0:
	inc de
	inc de
	ld (hl),e
	inc hl
	ld (hl),d
	dec de
	dec de
	INC d
	LD A,d
	AND 7
	JR NZ,.l1 ;CY=0
	LD A,e
	ADD A,32
	LD e,A
	JR C,.l1  ;CY=1
	LD A,d
	ADD A,-8
	LD d,A     ;CY=1
.l1:
	add hl,bc
	dec xl
	jr nz,.l0

theLOOP:
	ei
	halt
	xor	a
	out	(#fe),a
	di
	ld (savesp+1),sp
	jp risovach
savesp:
	ld sp,#FACE

gentab:
	exx
	ld bc,#29
	ld hl,risovach+1
	exx
.l_x:
	ld ix,sintab
.l_y:
	ld iy,sintab

	ld b,96
.l0:
	ld a,(ix+0)
	add (iy+0)
	inc xl
	bit 0,b
	jr z,.l1
	inc yl
.l1:
	exx
	push hl
	ld de,oval
	ld h,0
	ld l,a
	add hl,hl ;2
	add hl,hl ;4
	add hl,hl ;8
	add hl,hl ;16
	add hl,de
	ex de,hl
	pop hl
	ld (hl),e
	inc hl
	ld (hl),d
	add hl,bc
	exx
	djnz .l0

	ld a,(.l_x+2)
	inc a
	and 63
	ld (.l_x+2),a
	ld a,(.l_y+2)
	inc a
	and 63
	ld (.l_y+2),a

	ld	a,1
	out	(#fe),a
	jr	theLOOP

risovach:
;	dup 128
	ld sp,#0000
		dup 2
			pop af
			pop hl
			pop de
			pop bc
			exx
			ex af
		edup
	ld sp,#0000
		dup 4
			push bc
			push de
			push hl
			push af
			exx
			ex af
		edup
rrrddd:
;	edup
;	jp savesp
	display $-SnaStart

	org #8000
oval:	incbin	"sprite.bin"

	org #9000
sintab:
	include "sns.asm"
	savesna "boobliki.sna",SnaStart