DEF DEFAULT_ENV equ $60	;%10000000
DEF SILENT_ENV equ %00000000
;SILENT_ENV equ $11 ;%00010001



InitSound:

    ld a, $FF
    ldh [rNR52], a
    ld [wMusicFramesPerStep], a

    ld hl, $FF10
    ld de, $FF25 - $FF10
    xor a
    call Fill

    ld a, $FF
    ldh [rNR51], a
    ld a, %01110111
    ldh [rNR50], a   

    ld a, %10000000
    ld [rNR11], a
    ld [rNR21], a
    
    ;ld a, DEFAULT_ENV
    ld [rNR12], a
    ld [rNR22], a

    ;ld a, %10000001
    ;ld [rNR14], a

    ret

NotePitches:
    dw $F82C ; C_
    dw $F89D ; C#
    dw $F907 ; D_
    dw $F96B ; D#
    dw $F9CA ; E_
    dw $FA23 ; F_
    dw $FA77 ; F#
    dw $FAC7 ; G_
    dw $FB12 ; G#
    dw $FB58 ; A_
    dw $FB9B ; A#
    dw $FBDA ; B_

; a - note in [note][octave]
; 
; de - frequency
NoteToFrequency:
    ld c, a
    and %00001111
    ld b, a
    ld a, c
    rra
    rra
    rra
    rra
    and a, %00001111
    ld h, 0
    ld l, a
    add hl, hl
    ld d, h
    ld e, l
    ld hl, NotePitches
    add hl, de
    ld e, [hl]
    inc hl
    ld d, [hl]
    ld a, 8
    sub b
.divideLoop
    cp 7
    jr z, .done
    sra d
    rr e
    inc a
    jr .divideLoop
.done
    ld a, 8
    add d
    ld d, a

    ret
    
; a - note in [note][octave]
; b - channel
; d - duty/len
; e - envelope
SetChannelNote:
    push de
    push af
    ld a, b
    and a, %00000011
    ld hl, $0000
    ld bc, rNR21 - rNR11
    call AddATimes
    ld bc, rNR11
    add hl, bc
    pop af
    push hl

    or a
    jr z, .rest
    
    call NoteToFrequency

    ld b, d
    ld c, e

    pop hl
    pop de
    ld a, d
    ld [hli], a
    
    ld a, e   ;DEFAULT_ENV
    ld [hli], a
    ld d, b
    ld e, c
    ld a, c
    ld [hli], a
    ld a, [hl]
    and a, %01000000
    ld b, a
    ld a, d
    set 7, a
    res 6, a
    or b
    ld [hl], a
    ret
.rest
    pop hl
    inc hl
    ld a, SILENT_ENV
    ld [hli], a
    ;xor a
    ;ld [hli], a
    ;ld [hl], a
    pop de
    ret



;bc - pointer pointer
PlaySong:
    
    	;ld a, [hli]
    	;ld c, a
    	;ld a, [hl]
    	;ld hl, wCh1Ptr+1
    	;ld [hld], a
    	;ld a, c
    	;ld [hl], a

    xor a

    ldh [rNR10], a
    ldh [rNR14], a

    
    xor a
    ld hl, wCh1Ptr
    ld de, 4 * CHANNEL_DATA_SIZE
    call Fill

    ld hl, wCh1Ptr
    		;ld e, 8
    		;call Copy
    ld e, 4
.loop
    ld a, [bc]
    inc bc
    ld [hli], a
    ld a, [bc]
    inc bc
    ld [hli], a
    push de
    ld de, CHANNEL_DATA_SIZE - 3
    add hl, de
    ld a, DEFAULT_ENV
    ld [hli], a
    pop de
    dec e
    jr nz, .loop
    
    




    ld a, [bc]
    ld [wMusicFramesPerStep], a

    dec a
    ld [wMusicStepCount], a

    ret

;bc - pointer
PlaySFX:

    ld a, [wImportantSFX]
    or a
    ret nz
    
    xor a

    ldh [rNR10], a

    ld hl, wCh5Ptr +2   ;wCh1WaitTicks + 4 * CHANNEL_DATA_SIZE
    ld de, 4 * CHANNEL_DATA_SIZE - 2
    call Fill

    ld a, [bc]
    ld [wSFXFramesPerStep], a
    dec a
    ld [wSFXStepCount], a
    
    inc bc
    ld hl, wCh5Ptr
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
    inc hl
    inc hl
    ld a, DEFAULT_ENV
    ld [hli], a
    ret

UpdateSFX:

    ld a, [wCh5Ptr+1]
    or a
    jr nz, .noReset
    	;xor a
    ld [wImportantSFX], a
.noReset

    ld a, [wSFXFramesPerStep]
    ld b, a
    ld a, [wSFXStepCount]
    inc a
    ld [wSFXStepCount], a
    cp b
    ret c

    xor a
    ld [wSFXStepCount], a

    ld a, 4

.channelLoop
    push af
    call UpdateChannel
    pop af
    inc a
    cp 8
    jr c, .channelLoop

    ret

UpdateMusic:
    ld a, [wMusicFramesPerStep]
    ld b, a
    ld a, [wMusicStepCount]
    inc a
    ld [wMusicStepCount], a
    ;cp FRAMES_PER_MUSIC_STEP
    cp b
    ret c

    xor a
    ld [wMusicStepCount], a

.channelLoop
    push af
    call UpdateChannel
    pop af
    inc a
    cp 4
    jr c, .channelLoop

    ret
    
    

;a - channel to update
UpdateChannel:
    		;push af
    ld d, a
    ld hl, wCh1WaitTicks
    ld bc, CHANNEL_DATA_SIZE
    call AddATimes

    ld a, [hl]
    or a
    jp nz, .decWaitTicks

    		;;;pop af
    ;ld a, d
    ;ld h, 0
    ;ld l, a
    ;add hl, hl
    ;ld bc, wCh1Ptr
    ;add hl, bc

    ;ld bc, -2
    ;add hl, bc
    dec hl
    dec hl

    ld b, h
    ld c, l

    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp NoteProcessLoop
.decWaitTicks
    dec a
    ld [hl], a
    		;pop af
    ret

    
NoteProcessLoop:
    ld a, l
    or h
    jp z, .updateAndRet
    push bc
    ld a, [hl]
    cp $C0
    jr nc, .command
    
    
    push hl
    push de
    ld e, a  

    ld h, b
    ld l, c
    ld bc, CHANNEL_DATA_SIZE * 4
    add hl, bc
    ld a, [hli]
    ld b, a
    ld a, [hl]
    or b
    
    jr nz, .overridden
    	;push de

    ld hl, wCh1LenAndDuty
    ld bc, CHANNEL_DATA_SIZE
    ld a, d
    call AddATimes
    ld a, [hli]
    ld c, a
    ld a, [hl]
    ld b, a

    	;pop de

    ld a, e
    ld e, b
    ld b, d
    ld d, c
    call SetChannelNote
.overridden
    pop de

    ld a, d
    ld hl, wCh1WaitTicks
    ld bc, CHANNEL_DATA_SIZE
    call AddATimes

    ld b, h
    ld c, l

    pop hl
    inc hl

    ld a, [hli]
    ld [bc], a

    	;push hl
    	;ld a, d
    		;ld h, 0
    	;ld l, a
    	;add hl, hl
    	;ld bc, wCh1Ptr
    	;add hl, bc
    	;ld b, h
    	;ld c, l
    	;pop hl

    pop bc

.updateAndRet

    ld a, l
    ld [bc], a
    inc bc
    ld a, h
    ld [bc], a
    ret

.command
    
    
    sub a, $C0
    push hl
    ld h, 0
    ld l, a
    add hl, hl
    ld bc, MusCommandJumpTable
    add hl, bc

    

    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp hl
;.updateAndRet
;    xor a
;    ld [wImportantSFX], a
;    jp .updateAndRet_original

    
Mus_Jump:
    pop hl
    pop bc
    inc hl
;    ld a, [hli];\
;    ld [bc], a
;    ld a, [hli]
;    inc bc
;    ld [bc], a
;    ld h, a
;    dec bc
;    ld a, [bc]
;    ld l, a

    ld a, [hli]
    ld h, [hl]
    ld l, a

    jp NoteProcessLoop

Mus_Stop:
    pop hl
    pop bc
;    ;xor a
;    ;ld [bc], a
;    ;inc bc
;    ;ld [bc], a
    ld hl, $0000
    jp NoteProcessLoop

Mus_SetDuty:
    pop hl
    pop bc
    
    inc hl
    ld a, [hli]
    rla
    rla
    rla
    rla
    rla
    rla
    and a, %11000000
    inc bc
    inc bc
    inc bc
    push de
    ld d, a
    ld a, [bc]
    and a, %00111111
    or d
    ldh [rNR11], a
    
    ld [bc], a              ;wCh1LenAndDuty 

    pop de

    dec bc
    dec bc
    dec bc
    jp NoteProcessLoop

Mus_SetLen:
    pop hl
    pop bc

    inc hl


    
    ld a, [hli]
    or a
    jr z, .unLen

    inc bc
    inc bc
    inc bc

    and a, %00111111
    push de
    ld d, a
    ld a, [bc]
    and a, %11000000
    or d
    ldh [rNR11], a
    ld [bc], a

    ldh a, [rNR14]
    set 6, a
    ldh [rNR14], a

    pop de

    dec bc
    dec bc
    dec bc

    jp NoteProcessLoop
.unLen
    ldh a, [rNR14]
    res 6, a
    ldh [rNR14], a
    
    jp NoteProcessLoop

Mus_SetSweep:
    pop hl
    pop bc

    inc hl
    ld a, [hli]
    ldh [rNR10], a

    jp NoteProcessLoop

Mus_SetEnvelope:
    pop hl
    pop bc
    
    inc hl
    ld a, [hli]

    inc bc
    inc bc
    inc bc
    inc bc

    ;ldh [rNR11], a
    
    ld [bc], a              ;wCh1LenAndDuty 

    dec bc
    dec bc
    dec bc
    dec bc
    jp NoteProcessLoop
    

MusCommandJumpTable:
    dw Mus_Jump
    dw Mus_Stop
    dw Mus_SetDuty
    dw Mus_SetLen
    dw Mus_SetSweep
    dw Mus_SetEnvelope
