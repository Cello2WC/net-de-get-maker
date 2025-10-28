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
DEF GAME_CATEGORY EQU CATEGORY_PROGRAM

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
DEF GAME_GENRE EQU GENRE_ADVENTURE

; String
; Max. 10 characters (20 bytes)
game_title "My Game!"

; String
; Max. 18 characters
; Max. 31 bytes
;  - Characters with dakuten are two bytes
game_description "NDG-Maker example"

include "include/header.asm"

MinigameStart:
	ret



include "include/footer.asm"
