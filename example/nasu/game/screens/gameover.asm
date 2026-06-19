GameOver:

    ld a, SOUNDBANK_NASU_MUS_SILENCE
    call APIPlaySong

    ld a, NASU_SFX_LOSE
    call APIPlaySFX

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
    ld a, 6
    call WaitAFrames
    call SetPalBlack
    ld a, 6
    call WaitAFrames
    dec e
    jr nz, .flashLoop
    call SetPalRed
    
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
    ; Save Hi-Score to file
    ld bc, 2
    ld de, GameHeader_GameID
    call APIOpenFile

    ld a, [wScore]
    ld [wHighScore], a
    ld [hli], a
    ld a, [wScore+1]
    ld [wHighScore+1], a
    ld [hl], a
    
    call APICloseFile
    
.noHigh
    xor a
    ld [wGameReturnState], a
    
    
;    ld a, NASU_SFX_SILENCE
;    call APIPlaySFX
    call APIStopAudio
    
    ret
    


SetPalRed:
    ld hl, RedPal
    ld a, 2
    jp APISetBGPal

SetPalBlack:
    ld hl, BlackPal
    ld a, 2
    jp APISetBGPal

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

;String_GameOver:
;    db "GAME OVER"