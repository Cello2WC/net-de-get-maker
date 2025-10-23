MACRO RGB
rept _NARG / 3
	dw palred (\1) + palgreen (\2) + palblue (\3)
	shift 3
endr
ENDM

DEF palred   EQUS "(1 << 0) *"
DEF palgreen EQUS "(1 << 5) *"
DEF palblue  EQUS "(1 << 10) *"

MACRO RGB24
    dw palred (\1 >> 3) + palgreen (\2 >> 3) + palblue (\3 >> 3)
ENDM