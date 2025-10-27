MACRO warnstrcharsize
	DEF _index = 0
	DEF _len = 0
	REPT STRLEN(\1)
		DEF _len += CHARSIZE(STRSLICE(\1,_index,_index+1))
		DEF _index += 1
	ENDR
	IF _len > \2
		FAIL \3
	ENDC
	PURGE _index
	PURGE _len
ENDM

MACRO game_title
	IF STRLEN(\1) > 10
		WARN "Game title \1 is longer than 10 characters."
	ENDC
	warnstrcharsize \1, 20, "Game title \1 is longer than 20 bytes."
	DEF GAME_TITLE EQUS \1
ENDM

MACRO game_description
	IF STRLEN(\1) > 18
		WARN "Game description \1 is longer than 18 characters."
	ENDC
	warnstrcharsize \1, 31, "Game description \1 is longer than 31 bytes."
	DEF GAME_DESCR EQUS \1
ENDM
