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
DEF APPEND_ID EQU 5

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
game_title "Tiles"

; String
; Max. 18 characters
; Max. 31 bytes
;  - Characters with dakuten are two bytes
game_description "NDG-Maker example"

include "include/header.asm"

MinigameStart:
	ret


SECTION "Tile Palettes", ROMX[$40A0]
incbin "game/palettes.bin"
SECTION "Border Palette", ROMX[$40D8]
	db $FF,$7F,$37,$16,$72,$19,$A8,$0C
SECTION "Object Palettes", ROMX[$40E0]
incbin "game/objpals.bin"

SECTION "Tilemap", ROMX[$4120]

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

SECTION "Tiles 1", ROMX[$43F0]
;incbin "game/tiles.2bpp", $800, $800
SECTION "Tiles 2", ROMX[$4BF0]
incbin "game/tiles.2bpp"



SECTION "Tiles 3", ROMX[$53F0]
;incbin "game/tiles.2bpp", $1000, $800

SECTION "Unk1", ROMX[$5BF0]
	db "ぺんぎん<NULL>"


include "include/footer.asm"
