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

	call BeginMenu
    ld a, [wMenuChoice]
    cp $ff
    ret z
    
    
    
    call PrepareGameOver
    call APIFunction5B
    call ResetInterrupts
    xor a
    ldh [$FF07], a
    call DisableFlash
	ret

ResetInterrupts:
    di
    ld de, 0
    call APISetTimer
    ld de, 0
    call APISetVBlank
    ld de, 0
    call APISetLCDC
    ld de, 0
    call APISetSerial
    ei
    ret
	
FadeOut:
	call APIFadeAudio
.loop
	ld a, [wPalPackScale]
	ld c, a
	ld a, [$CF86]
	or c
	jr nz, .loop
	ret
	
DisableFlash:
	push af
	ld a, [$D07F]
	cp a, 3
	jr c, .done
	push hl
	call $1359 ; ROM0_DisableFlash
	pop hl
.done
	pop af
	ret
	
Function42AA:
	ld hl, $6000
	ld a, [$D07F]
	cp 3
	ret c
	ld hl, $60A0
	ret
	
Function430B:
	halt
	nop
.loop
	ldh a, [$FF8A]
	and a
	jr z, .loop
	xor a
	ldh [$FF8A], a
	ret
	
Function4957:
	ld [$D006], a
	ld a, 0
	ld [$C1B8], a
	call Function42AA
	ld a, 4
	call APIPackAllPalettes
.loop
	call APIApplyAllPalettes
	call APIFunction5B
	call Function430B
	ld a, [wPalPackScale]
	ld c, a
	ld a, [$CF86]
	or c
	jr nz, .loop
	ret
	
PrepareGameOver:
	ld hl, wGameOverLine1
	ld de, .string1
	call StringCopy
	ld hl, wGameOverLine2
	ld de, .string2
	call StringCopy
;	ld a, 3
;	ld de, $D00D
;.loop ; print completion time
;	push af
;	ld a, [de]
;	add $20
;	ld [hl], a
;	inc hl
;	dec de
;	ld a, [de]
;	add $20
;	ld [hl], a
;	inc hl
;	dec de
;	ld a, $2A
;	ld [hl], a
;	inc hl
;	pop af
;	dec a
;	or a
;	jr nz, .loop
	
;	dec hl
;	ld a, 0
;	ld [hl], a
;	ld a, 0
;	ld [wReactPointReward], a
;	ld a, 0
;	ld [wReactPointReward], a
;	ld a, 0
;	ld [wTastePointReward], a
;	ld a, [$D00D]
;	or a
;	jr z, .skip1
;	ld a, 1
;	ld [wSmartPointReward], a
;.skip1
	;ld a, [$D00C]
	;ld b, a
	;ld a, 10
	;sub b
	;ld c, 12
	;call APISmallMultiply
	;srl a
	;srl a
	;srl a
	;ld a, 13
	;ld [wSmartPointReward], a ; smarts point reward
	;srl a
	;srl a
;	ld [wReactPointReward], a ; reaction point reward
	;srl a
;	ld [wTastePointReward], a ; taste point reward
	;call Function5012
	
	
	
	ld a, 13
	ld [wReactPointReward], a ; reaction point reward
	ld a, 37
	ld [wSmartPointReward], a ; smarts point reward
	ld a, 69
	ld [wTastePointReward], a ; taste point reward
	
	ret
.string1
	;lang J, db "    だいせいこう!!<NULL>"
	;lang E, db "   SUCCESS!!<NULL>"
	db "   SUCCESS!!<NULL>"
.string2
	;lang J, db "かんせいじかん <NULL>"
	;lang E, db "CMPL.TIME <NULL>"
	db "DEBUG STRING<NULL>"
	
	
StringCopy:
	ld a, [de]
	ld [hl], a
	or a
;	jr z, .done
	ret z
	inc de
	inc hl
	jr StringCopy
;.done
;	ret
	
Function5012:
	;call Function4FC1 ; save scores to file?
	ld a, [$C73D]
	srl a
	or a
	jr nz, .skip1
	ld a, 1 ; dont divide by 0
.skip1
	ld c, a
	ld a, [$C84B]
	call APIByteDivide
	ld a, l ; remainder
	ld [$C84B], a
	
	ld a, [$C73E]
	srl a
	or a
	jr nz, .skip2
	ld a, 1 ; dont divide by 0
.skip2
	ld c, a
	ld a, [$C84C]
	call APIByteDivide
	ld a, l ; remainder
	ld [$C84C], a
	
	ld a, [$C73F]
	srl a
	srl a
	or a
	jr nz, .skip3
	ld a, 1 ; dont divide by 0
.skip3
	; should there be a "ld c, a" here??
	ld a, [$C84D]
	call APIByteDivide
	ld a, l
	ld [$C84D], a
	ret
	
GameInfo:
	ld a, [wMinigameFlashBank]
	ldh [$FF9D], a ; Bank B Num
	ld a, $08
	ldh [$FF9E], a ; Bank B Rom/Flash Select
	
	ld a, LOW(GameInfoData+$2000)
	ldh [$FF9F], a ; Pointer Lo
	ld a, HIGH(GameInfoData+$2000)
	ldh [$FFA0], a ; Pointer Hi
	ld a, 5
	ld b, 0
	call APIPredef
	call Function4957
	;jr BeginMenu
	
BeginMenu:
    ld a, $FF
    ld [$D07F], a
    ld a, 2
    ld c, a
    ld hl, .Options
    call APIDoMenu
    ld a, [wMenuChoice]
    cp $FF
    jr z, .backedOut
    ld hl, .OptionFuncs
    push hl
    jp $05F5 ; Jumptable
.Start
    call FadeOut
    ret
.backedOut
    ld a, $10
    ld [$C671], a
    
	call ResetInterrupts
    
    ld a, $FF
    ld [wMenuChoice], a
    ret
.OptionFuncs
	; $4CAF, $4CB3, $4CF5
	dw .Start
	dw GameInfo
	;dw .DeleteSaveData
    
.Options
    db "Start<NULL>"
    db "Info<NULL>"
    ;db "Del. Save<NULL>"
	
GameInfoData:
.palettes
	dw $0000, $35AD, $6C1F, $7FFF
	dw $001F, $210D, $0000, $7FFF
	dw $7C00, $3D8C, $0000, $7FFF
	dw $7FFF, $0000, $001F, $497E
	dw $7FFF, $0000, $7E68, $7FFF
	dw $0260, $338D, $0000, $7FFF
	dw $6C1F, $6C1F, $6C1F, $6C1F
	dw $4401, $7CC8, $7E8A, $7FFF
	dw $0000, $0000, $56B5, $7FFF
	dw $001F, $210D, $56B5, $7FFF
	dw $7C00, $3D8C, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $4401, $7CC8, $7E8A, $7FFF
.header
	db 3 ; num pages
	dw .page1+$2000
	dw .page2+$2000
	dw .page3+$2000
	dw 5 ; ???
	dw 6 ; ???
.page1
	db "RULES(1)<LINE>"
	db "its rules time<LINE>"
	db "baybeeeeeeeeeeeee<LINE>"
	db "lets goooooooo<NULL>"
.page2
	db "RULES(2)<LINE>"
	db "rules page twooooo<LINE>"
	db "im sleepy as hell<LINE>"
	db "but i wanna see this<LINE>"
	db "in-game!!!!!!<NULL>"
.page3
	db "RULES(3)<LINE>"
	db "i dunno what else<LINE>"
	db "to write lol<NULL>"

	
	
	

include "include/footer.asm"
