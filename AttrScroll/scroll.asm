	DEVICE	ZXSPECTRUM128
FONT = #C000
	ORG	#8000
SnaStart:
	EI
	XOR	A
	OUT	(#FE),A
	LD	HL,#3D00
	LD	DE,#C000
	LD	BC,#300
	LDIR
	LD	HL,#0000
	LD	DE,#4000
	LD	BC,#1800
	LDIR
MAINLOOP:
	HALT
	CALL	SCROLL
	JR	MAINLOOP

SCROLL:	LD	A,01
	DEC	A
	JR	NZ,NotNewSymbol
L834C:	LD	HL,TEXT
	BIT	7,(HL)
	JR	Z,NotNewText
	LD	HL,TEXT
NotNewText:
	LD	A,(HL)
	INC	HL
	LD	(L834C+1),HL
	LD	H,0
	LD	L,A
	ADD	HL,HL
	ADD	HL,HL
	ADD	HL,HL
	LD	DE,FONT-#100
	ADD	HL,DE
	LD	(L82F7+2),HL
	LD	A,08
NotNewSymbol:
	LD	(SCROLL+1),A
	LD	HL,#5900
L82F7:	LD	IX,#0000
	LD	B,#08
L82FD:	LD	C,H
	LD	E,L
	LD	D,H
	INC	L
	DUP	31
	LDI
	EDUP
	RLC	(IX+00)
	SBC	A,A
	;AND	#45
	LD	(DE),A
	INC	IXL
	DJNZ	L82FD
	RET
	RET
TEXT:	DB	"OLOLOLOLO   ",#FF
	SAVESNA "scroll.sna",SnaStart
