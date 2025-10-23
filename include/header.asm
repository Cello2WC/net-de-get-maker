SECTION "Header Jump", ROMX[$4000]
MinigameDataStart::
	jp MinigameStart

SECTION "Header Info", ROMX[$4005]
	db (((MinigameDataEnd - MinigameDataStart) - 1) / $2000) + 1
	db GAME_CATEGORY
	db GAME_GENRE
	db "G000" ; to be assigned by server

SECTION "Game Title", ROMX[$400F]
IF DEF(GAME_TITLE)
	db "{GAME_TITLE}"
ENDC
	db "<NULL>"

SECTION "Game Description", ROMX[$4024]
	db "{GAME_DESCR}"
	db "<NULL>"

SECTION "Header Title Check", ROMX[$4044]
IF DEF(GAME_TITLE)
	db $FF
ELSE
	db $00
ENDC

SECTION "Main", ROMX[$406D]
	db $3B, $B3