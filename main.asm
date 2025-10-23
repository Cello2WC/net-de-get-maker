include "include/charmap.asm"

include "include/constants/icon_constants.asm"
DEF GAME_CATEGORY EQU  CATEGORY_PROGRAM
DEF GAME_GENRE    EQU  GENRE_ADVENTURE
DEF GAME_TITLE    EQUS "Test Game"
DEF GAME_DESCR    EQUS "Test of NDG-Maker"

include "include/header.asm"

MinigameStart:
	ret



include "include/footer.asm"
