GameOver:

    ld bc, Silence_Ptrs
    call PlaySong

    ld bc, SFX_Lose
    call PlaySFX

    ld a, 3
    call SetLYCMode

    xor a
    ld [rSCX], a

    ld a, [rLCDC]
    set 1, a
    ld [rLCDC], a

    ld e, 4
.flashLoop
    call SetPalRed
    ld a, 5
    call WaitAFrames
    call SetPalBlack
    ld a, 5
    call WaitAFrames
    dec e
    jr nz, .flashLoop
    call SetPalRed
    

    ld a, $01
    ld [hCopyTo], a

    call ClearTilemap_KeepBorders
;    	;call DrawBorders

    coord hl, 5, 8
    ld bc, String_GameOver
    ld de, 9
    call Copy

    coord hl, 9, 16
    ld bc, String_Score
    ld de, 11
    call Copy

    coord hl, 15, 16
    call DrawScoreAtHL

    call CopyTilemapToScreen_2

    ld a, 59
    call WaitAFrames

    call SetPalBlack

    ld a, 4
    call SetLYCMode

    call ClearVOAM
    call UseMapOne

    ; game over song
    ld bc, GameOverSong_Ptrs
    call PlaySong

    ld a, [wFlags]
    bit 2, a
    jr nz, .noHigh
    ld a, [wHighScore]
    ld b, a
    ld a, [wHighScore+1]
    ld c, a
    ld a, [wScore]
    cp b
    jr c, .noHigh
    jr nz, .high
    ld a, [wScore+1]
    cp c
    jr c, .noHigh
.high
    ld a, $0A
    ld [$0000], a

    ld a, [wScore+1]
    ld [wHighScore+1], a
    ;ld [$A001], a
    ld a, [wScore]
    ld [wHighScore], a
    ;ld [$A000], a

    xor a
    ld [$0000], a
.noHigh
    xor a
    ld [wFlags], a

    call DrawTitle

    ld a, 255
    call WaitAFrames
    ld a, 194
    call WaitAFrames

    jp TitleScreen
    


SetPalRed:
    ld a, 1
    ld [wFlashPal], a
    ld hl, RedPal
.entry
    call WaitOneFrame
    ld a, 1 << rBGPI_AUTO_INCREMENT + (2*8)
    ld [rBGPI], a
    ld b, 8 * 1
.gbcbgploop
    ld a, [hli]
    ld [rBGPD], a
    dec b
    jr nz, .gbcbgploop
    ret

SetPalBlack:
    xor a
    ld [wFlashPal], a
    ld hl, BlackPal
    jr SetPalRed.entry

BlackPal:
    RGB24 $FF, $00, $00
    RGB24 $90, $00, $00
    RGB24 $00, $00, $00
    RGB24 $00, $00, $00

RedPal:
    RGB24 $00, $00, $00
    RGB24 $00, $00, $00
    RGB24 $90, $00, $00
    RGB24 $FF, $00, $00

String_GameOver:
    db "GAME OVER"