SECTION "Header Jump", ROMX[$4000]
MinigameDataStart::
	jp MinigameStart
	dw MinigameStart - $4000 ; ???

SECTION "Header Info", ROMX[$4005]
GameHeader_BlockSize::  db (((MinigameDataEnd - MinigameDataStart) - 1) / $2000) + 1
GameHeader_Category::   db GAME_CATEGORY
GameHeader_Genre::      db GAME_GENRE
GameHeader_Unk1::       db 1 ; ???
GameHeader_GameID::     db "G000" ; to be assigned by server
GameHeader_AppendID::
IF DEF(APPEND_ID)
	dw APPEND_ID ; ???
ELSE
	dw 0
ENDC

SECTION "Game Title", ROMX[$400F]
GameHeader_Title::
IF DEF(GAME_TITLE)
	db "{GAME_TITLE}"
ENDC
	db "<NULL>"

SECTION "Game Description", ROMX[$4024]
GameHeader_Description::
IF DEF(GAME_DESCR)
	db "{GAME_DESCR}"
ENDC
	db "<NULL>"

SECTION "Header Title Check", ROMX[$4044]
GameHeader_TitleCheck::
IF DEF(GAME_TITLE)
	db $FF
ELSE
	db $00
ENDC

SECTION "Header Unknown Append Data", ROMX[$404D]
GameHeader_AppendUnk1::
	dw 0 ; pointer to some kind of data
	; unknown data follows

SECTION "Main", ROMX[$406D]
GameHeader_Magic::
	db $3B, $B3