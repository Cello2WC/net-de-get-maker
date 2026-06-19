
; \1 - Volume ($0 - $F)
; \2 - Pitch ($24 - $??) (probably use note constants)
; \3 - Length (in frames?? i think??)
MACRO note
	db $90 | (\1 & $0F), \2, \3
ENDM

; \1 - Length (in frames?? i think??)
MACRO rest
	db $80, \1
ENDM

; \1 - Instrument ID
MACRO instrument
	db $C0, \1, $00
ENDM

MACRO mus_set_loop_point
	db $FD
IF _NARG < 1
	db 0
ELSE
	db \1
ENDC
	db $00
ENDM

MACRO mus_loop
	db $FE, $00,
ENDM

MACRO mus_end
	db $FF, $2F
ENDM