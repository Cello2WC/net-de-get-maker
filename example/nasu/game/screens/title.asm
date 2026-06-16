TitleScreen::
    ld a, LYCMODE_TITLE
    call SetLYCMode
    call DrawBorders
    
    call ClearTilemap_KeepBorders
    call DrawTitle

    ld bc, TitleSong_Ptrs
    call PlaySong
    
.inputLoop
    
;    call APIJoypadFrameCount

    ld a, [hJoyPressed]
    and BUTTON_START | BUTTON_A
    or a
    jp nz, StartGame
    
    
    ld a, [hJoyPressed]
    and BUTTON_B
    or a
    ret nz

    ld a, [hJoyPressed]
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
    
; bc - src
; hl - dest
; e - len
BackwardsCopy:
.loop
    ld a, [bc]
    ld [hld], a
    dec bc
    dec e
    jr nz, .loop
    ret

DrawTitle:

    xor a
    ld [hCopyTo], a
    coord de, 0, 2
    ld hl, TitleTilePattern
    ld bc, $1307
    call APIScreenRectAttr

    coord de, 5, 11
    ld hl, String_PushStart
    ld bc, 10
    call APICopy

    coord de, 3, 13
    ld hl, String_HiScore
    ld bc, 8
    call APICopy

    coord de, 6, 15
    ld hl, String_Copyright
    ld bc, 8
    call APICopy

    coord de, 12, 13
    ld hl, String_Zeroes
    ld bc, 5
    call APICopy

.highScoreFromRAM
    
    ld a, [wHighScore]
    ld [wScore], a
    ld a, [wHighScore+1]
    ld [wScore+1], a
.highScoreLoaded
    coord hl, $0C, $0D
    jp DrawScoreAtHL
    

TitleTilePattern:
    db $A4, $A5, $83, $A6, $83, $A7, $A8, $A8, $A9, $83, $A7, $A8, $A8, $A9, $83, $A6, $83, $83, $A6
    db $AA, $AB, $83, $AC, $83, $AC, $83, $83, $AC, $83, $AC, $83, $83, $AD, $83, $AC, $83, $83, $AC
    db $AE, $AF, $A5, $AC, $83, $AC, $83, $83, $AC, $83, $AC, $83, $83, $83, $83, $AC, $83, $83, $AC
    db $AC, $B0, $AB, $AC, $83, $B1, $B2, $B2, $B3, $83, $B4, $B2, $B2, $A9, $83, $AC, $83, $83, $AC
    db $AC, $B5, $AF, $B6, $83, $AC, $83, $83, $AC, $83, $83, $83, $83, $AC, $83, $AC, $83, $83, $AC
    db $AC, $83, $B0, $BA, $83, $AC, $83, $83, $AC, $83, $A6, $83, $83, $AC, $83, $AC, $83, $83, $AC
    db $AD, $83, $B5, $B7, $83, $AD, $83, $83, $AD, $83, $B8, $B2, $B2, $B9, $83, $B8, $B2, $B2, $B9
    
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
TitleTilePattern_End:


String_PushStart:
    db "PUSH START"

String_HiScore:
    db "HI*SCORE"

String_Copyright:
    db $BB, $BC, $BD, $83, $BE, $BE, $BF, $C0
    
String_Zeroes:
    db "00000"
