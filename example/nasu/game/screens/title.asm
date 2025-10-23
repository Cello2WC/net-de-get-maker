TitleScreen::

    call ClearVOAM
    call UseMapOne
    call ClearTilemap
    call DrawBorders
    call DrawTitle
;    call CopyTilemapToScreen

    call DisableLCD
    call CopyScreen
;    ld e, $68
;    call Copy
    call EnableLCD

;    ld a, LYCMODE_TITLE
;    call SetLYCMode

    ld bc, TitleSong_Ptrs
    call PlaySong

    call UseMapZero
    
.inputLoop
    ld a, [hPressedButtons]
    and BUTTON_START | BUTTON_A
    or a
    jp nz, StartGame
    
    
    ld a, [hPressedButtons]
    and BUTTON_B
    or a
    ret nz

    ld a, [hPressedButtons]
    	;and BUTTON_UP | BUTTON_DOWN | BUTTON_LEFT | BUTTON_RIGHT
    or a
    jr nz, .checkCode
.codeReturn

    call WaitOneFrame
    jr .inputLoop

.checkCode
    
    push af
    ld hl, wCode+8
    ld bc, wCode+7
    ld e, 8
    call BackwardsCopy
    pop af
    ld [wCode], a

    ld a, [wFlags]
    or a
    jr nz, .codeReturn

    ld hl, wCode
    ld bc, .code
    ld e, 8
    call StringCompare
    jr nc, .codeReturn
    
    ld a, [wFlags]
    set 2, a
    ld [wFlags], a

    ld bc, SFX_Lose
    call PlaySFX

    jp .codeReturn

.code
    db $80, $40, $80, $40, $10, $10, $20, $20

DrawTitle:

    xor a
    ld [hCopyTo], a
    coord hl, 0, 2
    ld bc, TitleTilePattern
    ld de, TitleTilePattern_End - TitleTilePattern
    call Copy

    
;    bgcoord hl, $1F, $02
;    ld bc, $20
;    ld d, 8
    ;call WaitOneFrame
;    ld a, $83
;.specialTileLoop
;    ld [hl], a
;    add hl, bc
;    dec d
;    jr nz, .specialTileLoop

;    ld [$9D1F], a

    coord hl, 5, 11
    ld bc, String_PushStart
    ld de, 10
    call Copy

    coord hl, 3, 13
    ld bc, String_HiScore
    ld de, 8
    call Copy

    coord hl, 6, 15
    ld bc, String_Copyright
    ld de, 8
    call Copy

    coord hl, 12, 13
    ld de, 5
    ld a, "0"
    call Fill

;    ld a, $0A
;    ld [$0000], a
;
;    ld a, [$A000]
;    cp $FF
;    jr z, .highScoreFromRAM
;    ld [wScore], a
;    ld [wHighScore], a
;    ld a, [$A001]
;    ld [wScore+1], a
;    ld [wHighScore+1], a
;
;    xor a
;    ld [$0000], a
;
;    jr .highScoreLoaded

.highScoreFromRAM
    
    ld a, [wHighScore]
    ld [wScore], a
    ld a, [wHighScore+1]
    ld [wScore+1], a
.highScoreLoaded
    coord hl, $0C, $0D
    call DrawScoreAtHL

;    call IsGBC
;    ret z
    
    bgcoord hl, 0, 2
    lb de, SCR_WIDTH, 7
    ld a, 3
    call PaletteRect
    ld a, 2
    call WaitAFrames

    
    bgcoord hl, 0, 11
    lb de, SCR_WIDTH, 6
    xor a
    jp PaletteRect
    ret
    

TitleTilePattern:
    db $A4, $A5, $83, $A6, $83, $A7, $A8, $A8, $A9, $83, $A7, $A8, $A8, $A9, $83, $A6, $83, $83, $A6, $83
    db $AA, $AB, $83, $AC, $83, $AC, $83, $83, $AC, $83, $AC, $83, $83, $AD, $83, $AC, $83, $83, $AC, $83
    db $AE, $AF, $A5, $AC, $83, $AC, $83, $83, $AC, $83, $AC, $83, $83, $83, $83, $AC, $83, $83, $AC, $83
    db $AC, $B0, $AB, $AC, $83, $B1, $B2, $B2, $B3, $83, $B4, $B2, $B2, $A9, $83, $AC, $83, $83, $AC, $83
    db $AC, $B5, $AF, $B6, $83, $AC, $83, $83, $AC, $83, $83, $83, $83, $AC, $83, $AC, $83, $83, $AC, $83
    db $AC, $83, $B0, $BA, $83, $AC, $83, $83, $AC, $83, $A6, $83, $83, $AC, $83, $AC, $83, $83, $AC, $83
    db $AD, $83, $B5, $B7, $83, $AD, $83, $83, $AD, $83, $B8, $B2, $B2, $B9, $83, $B8, $B2, $B2, $B9, $83
TitleTilePattern_End:


String_PushStart:
    db "PUSH START"

String_HiScore:
    db "HI*SCORE"

String_Copyright:
    db $BB, $BC, $BD, $83, $BE, $BE, $BF, $C0
