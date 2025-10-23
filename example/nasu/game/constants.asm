INCLUDE "game/macros.asm"
INCLUDE "game/constants/hardware_constants.asm"
INCLUDE "game/constants/wram_constants.asm"
INCLUDE "game/charmap.asm"

DEF SCR_WIDTH equ 20
DEF SCR_HEIGHT equ 18
DEF BG_MAP_WIDTH equ $20

DEF BUTTON_A      equ %00000001
DEF BUTTON_B      equ %00000010
DEF BUTTON_SELECT equ %00000100
DEF BUTTON_START  equ %00001000
DEF BUTTON_RIGHT  equ %00010000
DEF BUTTON_LEFT   equ %00100000
DEF BUTTON_UP     equ %01000000
DEF BUTTON_DOWN   equ %10000000

; 00 - rest

; C  - 0
; C# - 1
; D  - 2
; D# - 3
; E  - 4
; F  - 5
; F# - 6
; G  - 7
; G# - 8
; A  - 9
; A# - A
; B  - B

; C0 - jump (a16)
; C1 - stop
; C2 - set duty (d8)
; C3 - set len (d8)
; C4 - pitch sweep (d8)
; C5 - envelope (d8)

