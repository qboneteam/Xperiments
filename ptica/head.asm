	device zxspectrum128

	org	#6000
SnaStart:
	ei

	xor a
	out (#fe),a

	jr $

	savesna "head.sna",SnaStart