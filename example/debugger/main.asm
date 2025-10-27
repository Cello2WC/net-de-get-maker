include "include/api.asm"
include "include/charmap.asm"
include "include/constants/icon_constants.asm"
include "include/macros.asm"
include "include/wram.asm"

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
game_title "Debugger"

; String
; Max. 18 characters
; Max. 31 bytes
;  - Characters with dakuten are two bytes
game_description "Test API calls"

include "include/header.asm"

include "game/coords.asm"
include "game/hardware_constants.asm"
include "game/input_constants.asm"

DEF SCREEN_WIDTH EQU 20
DEF SCREEN_HEIGHT EQU 18
DEF BG_MAP_WIDTH EQU $20


MinigameStart:

;    call APIClearVRAM
    
    ld bc, Palettes
    ld hl, wBGPals1
    ld e, 8*4*2
    call Copy
    
    ld a, 1
    ld [wPalUpdate], a
    
    call APIFunction5B
    


    ld a,$80
    call APIStopAudio
;    ld hl,$6000
;    ld de,0 ; song id
;    call APILoadSong
;    ld a,$81
;    call APIPlaySong

    
    ld c, 1
    ld a, 0
    ld de, MyBoxes
    call APITextBox

    ld hl, String_Title
    ld bc, $0000
    call APIDrawString
    
    
    di
    
    ld de, VBlankHandler
    call APISetVBlank
    
    xor a
    ld [hJoypadDown], a
    ld [hJoypadPressed], a
    ld [hJoypadReleased], a
    ld [hJoypadSum], a
    ;ldh [$FF4F], a
    ;ldh [$FF70], a
    
;    ld [$C21D], a
    
;    ld a, $3F
;    ld [$C21C], a
    
;    ld hl, $56EB
;    call $0258
;    ld de, $0000
;    call $0153
;    ld de, $4B67
;    call $0150
    
    
    ei
    
    call APIDisableLCD
    call APIUpdatePalettesVBlank
    call DrawCursor
    call DrawData
    call APIEnableLCD
    
    
.menuLoop
    ld a, [hJoypadDown]
    and a, 1 << A_BUTTON_F
    jr nz, .changeVal
    
    ld a, [hJoypadDown]
    and a, 1 << B_BUTTON_F
    jp nz, .quit
    
    ld a, [hJoypadPressed]
    and a, (1 << D_LEFT_F) | 1 << D_UP_F
    jr nz, .moveUp
    ld a, [hJoypadPressed]
    and a, (1 << D_RIGHT_F) | (1 << D_DOWN_F)
    jr z, .checkButton_noRedraw
.moveDown
    ld a, [wMenuOption]
    inc a
    jr .doneScroll
.moveUp
    ld a, [wMenuOption]
    dec a
.doneScroll
    cp $FF
    jr z, .loopBack
    cp 9
    jr c, .loopContinue
.loopForward
    xor a
    jr .loopContinue
.loopBack
    ld a, 8
.loopContinue
    ld [wMenuOption], a
    jr .checkButton

.changeVal
    ld hl, wCallA
    ld a, [wMenuOption]
    ld d, 0
    ld e, a
    add hl, de

    ld a, [hJoypadPressed]
    and a, %11110000
    cp a, 1 << D_UP_F
    jr z, .up
    cp a, 1 << D_DOWN_F
    jr z, .down
    cp a, 1 << D_LEFT_F
    jr z, .left
    cp a, 1 << D_RIGHT_F
    jr nz, .checkButton_noRedraw
.right
    ld a, [hl]
    inc a
    jr .doneChange
.up
    ld a, [hl]
    add a, $10
    jr .doneChange
.down
    ld a, [hl]
    sub a, $10
    jr .doneChange
.left
    ld a, [hl]
    dec a
.doneChange

    ld [hl], a

.checkButton

    call APIDisableLCD
    call DrawCursor
    call DrawData
    call APIEnableLCD
.checkButton_noRedraw

    ld a, [hJoypadPressed]
    cp a, 1 << START_F
    jr nz, .menuLoop
    
    
    
    ld hl, .menuLoop ; return pointer
    push hl
    
    ld a, [wCallFunc]
    ld c, a
    ld b, 0
    ld hl, $0150
    add hl, bc
    add hl, bc
    add hl, bc
    ;ld a, [wCallFunc+1]
    ;ld l, a
    push hl ; function pointer
    
    ld a, [wCallBC]
    ld b, a
    ld a, [wCallBC+1]
    ld c, a
    ld a, [wCallDE]
    ld d, a
    ld a, [wCallDE+1]
    ld e, a
    ld a, [wCallHL]
    ld h, a
    ld a, [wCallHL+1]
    ld l, a
    ld a, [wCallA]
    ret ; jp [wCallFunc]
    
.quit
    
    di
    xor a
    ldh [$FF8E], a
    ldh [$FF8F], a
    ldh [$FF07],a
    ei
    ret

DrawCursor:

    ld d, 10
    hlbgcoord 8, 6, $9800
    ld bc, $20;SCREEN_WIDTH
.clearCursorLoop
    ld [hl], $79
    add hl, bc
    dec d
    jr nz, .clearCursorLoop

    ld a, [wMenuOption]
    hlbgcoord 8, 6, $9800
    ld bc, $20;SCREEN_WIDTH
    call AddNTimes

    ld [hl], $3F
    
    ret


    
    
PlaceString::
.placeNext::
    ld a, [de]
    cp "<NULL>"
    ret z
    ld [hli], a
    inc de
    jr .placeNext
    
    
String_Title:
    db "$FEDCBA9876543210<LINE>"
    db "→NDG Debugger v0.0<LINE>"
    db "A.:<LINE>"
    db "BC:<LINE>"
    db "DE:<LINE>"
    db "HL:<LINE>"
    db "FUNC<NULL>"
    
    
    
    
    



Cry_DrawNum_16:
    ld a, $50;"$"
    ld [hli], a
    ld a, [de]
    call DrawHexNum
    inc de
    ld a, [de]
    
    
DrawHexNum:
    ld b, a
    swap a
    and a, %00001111
    call PrintHigit
    ld a, b
    and a, %00001111
    
PrintHigit:
.print
    add $40
    ld [hli], a
    ret
    
    
    
    
DrawData:

    hlbgcoord 9, 6, $9800
    ld a, $50
    ld [hli], a
    ld a, [wCallA]
    call DrawHexNum

    hlbgcoord 9, 8, $9800
    ld de, wCallBC
    call Cry_DrawNum_16

    hlbgcoord 9, 10, $9800
    ld de, wCallDE
    call Cry_DrawNum_16

    hlbgcoord 9, 12, $9800
    ld de, wCallHL
    call Cry_DrawNum_16

    hlbgcoord 5, 14, $9800
    ld a, [wCallFunc]
    call DrawHexNum
    
    ld a, [wCallFunc]
    ld c, a
    ld b, 0
    ld hl, $0150
    add hl, bc
    add hl, bc
    add hl, bc
    ld a, h
    ld [wCallFunc+1], a
    ld a, l
    ld [wCallFunc+2], a
    ld de, wCallFunc+1
    hlbgcoord 9, 14, $9800
    jp Cry_DrawNum_16
        

VBlankHandler:
    call VBlank
    ;call APIUpdatePalettesVBlank
    jp APIOAMDMA

include "game/vblank.asm"
    
Copy:
.loop
    ld a, [bc]
    ld [hli], a
    inc bc
    dec e
    jr nz, .loop
    ret
    
AddNTimes::
; Add bc * a to hl.
    and a
    ret z
.loop
    add hl, bc
    dec a
    jr nz, .loop
    ret
    




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

Palettes:
BGPals:
REPT 16
;white on black
    RGB24 $FF, $FF, $FF
    RGB24 $AA, $AA, $AA
    RGB24 $55, $55, $55
    RGB24 $00, $00, $00
ENDR
    
MyBoxes:
    db 0, 0, 18, 7

include "include/footer.asm"


include "game/wram.asm"
