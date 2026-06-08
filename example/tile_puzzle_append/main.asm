include "include/api.asm"
include "include/charmap.asm"
include "include/constants/icon_constants.asm"
include "include/macros.asm"
include "include/ram.asm"

; Affects minigame's primary icon
; Accepted values:
; CATEGORY_PROGRAM
;  - Standalone minigame
; CATEGORY_APPEND
;  - Add-on to another minigame
DEF GAME_CATEGORY EQU CATEGORY_APPEND
DEF APPEND_ID EQU APPEND_SLIDING_TILE_PUZZLE

; Affects minigame's secondary icon
; Accepted values:
; GENRE_MISC
; GENRE_ACTION
; GENRE_PUZZLE
; GENRE_PLATFORMER
; GENRE_RPG
; GENRE_SIMULATION
; GENRE_SHOOTER
; GENRE_ADVENTURE
DEF GAME_GENRE EQU GENRE_PUZZLE

; String
; Max. 10 characters (20 bytes)
game_title "Peng.Puzl."

; String
; Max. 18 characters
; Max. 31 bytes
;  - Characters with dakuten are two bytes
game_description "NDG-Maker example"

include "include/header.asm"

MinigameStart:
	; Launch the sliding tile puzzle
	ld a, 14
	jp APIStartMiniGame


SECTION "Tile Palettes", ROMX[$40A0]
incbin "game/palettes.bin"

SECTION "Border Palette", ROMX[$40D8]
	dw $7FFF
	dw $1637
	dw $1972
	dw $0CA8
	
incbin "game/objpals.bin"

; Top Border
incbin "game/tilemap.bin", 0, 20
incbin "game/attrmap.bin", 0, 20
; Bottom Border
incbin "game/tilemap.bin", 20*17, 20
incbin "game/attrmap.bin", 20*17, 20

; Left Border
DEF _loop_y = 0
REPT 16
incbin "game/tilemap.bin", 20 + (_loop_y*20), 1
DEF _loop_y += 1
ENDR
DEF _loop_y = 0
REPT 16
incbin "game/attrmap.bin", 20 + (_loop_y*20), 1
DEF _loop_y += 1
ENDR

; Right Border
DEF _loop_y = 0
REPT 16
incbin "game/tilemap.bin", 39 + (_loop_y*20), 1
DEF _loop_y += 1
ENDR
DEF _loop_y = 0
REPT 16
incbin "game/attrmap.bin", 39 + (_loop_y*20), 1
DEF _loop_y += 1
ENDR

; Puzzle Tiles
DEF _loop_y = 0
REPT 4
DEF _loop_x = 0
REPT 6
incbin "game/tilemap.bin", _loop_x*3+21 + (_loop_y*80), 3
incbin "game/tilemap.bin", _loop_x*3+41 + (_loop_y*80), 3
incbin "game/tilemap.bin", _loop_x*3+61 + (_loop_y*80), 3
incbin "game/tilemap.bin", _loop_x*3+81 + (_loop_y*80), 3
incbin "game/attrmap.bin", _loop_x*3+21 + (_loop_y*80), 3
incbin "game/attrmap.bin", _loop_x*3+41 + (_loop_y*80), 3
incbin "game/attrmap.bin", _loop_x*3+61 + (_loop_y*80), 3
incbin "game/attrmap.bin", _loop_x*3+81 + (_loop_y*80), 3
DEF _loop_x += 1
ENDR
DEF _loop_y += 1
ENDR

incbin "game/tiles.2bpp"

SECTION "Title", ROMX[$5BF0]
	db "ぺんぎん<NULL>"


include "include/footer.asm"
