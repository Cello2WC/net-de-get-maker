DEF BYTES_PER_FRAME equ 96;128 ; 112 ; 96   ;128
DEF TILES_PER_FRAME equ 8;10
DEF ROWS_PER_FRAME equ 3;4



VBlank:
    push af
    push bc
    push de
    push hl
    
    call VCopy
    jr c, .noBGCopy
    call VBGCopy
    jr c, .noBGCopy
    ;call VPalCopy
.noBGCopy
    
    ld a, HIGH(wVOAM)
    call $FF80;hOamDma
    xor a
    ld [hVBlankFlag], a
    call Random
    call UpdateButtons

    call UpdateSFX
    call UpdateMusic


    ld a, [wGlobalTimer]
    inc a
    ld [wGlobalTimer], a


    pop hl
    pop de
    pop bc
    pop af
    reti

VCopy:
    ld a, [hVCopyLen]
    or a
    ret z

    ld d, a

    ld a, [hVCopySrc]
    ld b, a
    ld a, [hVCopySrc+1]
    ld c, a

    ld a, [hVCopyDest]
    ld h, a
    ld a, [hVCopyDest+1]
    ld l, a

    ld e, TILES_PER_FRAME
.loop
REPT 16
    ld a, [bc]
    ld [hli], a
    inc bc
ENDR
    
    dec d
    ld a, d
    ld [hVCopyLen], a
    or a
    jr z, .exit

    dec e
    jr z, .exit
    jr .loop
    
.exit
    ld a, b
    ld [hVCopySrc], a
    ld a, c
    ld [hVCopySrc+1], a
    
    ld a, h
    ld [hVCopyDest], a
    ld a, l
    ld [hVCopyDest+1], a
    
    scf
    ret

VBGCopy:
    ld a, [hVBGCopyLen]
    or a
    ret z

    ld d, a

    ld a, [hVBGCopySrc]
    ld b, a
    ld a, [hVBGCopySrc+1]
    ld c, a

    ld a, [hVBGCopyDest]
    ld h, a
    ld a, [hVBGCopyDest+1]
    ld l, a

    ld e, ROWS_PER_FRAME
.loop
    push de

    ld e, SCR_WIDTH
    call Copy

    ld de, $20 - SCR_WIDTH
    add hl, de

    pop de
    
    dec d
    ld a, d
    ld [hVBGCopyLen], a
    or a
    jr z, .exit

    dec e
    jr z, .exit
    jr .loop

.exit
    ld a, b
    ld [hVBGCopySrc], a
    ld a, c
    ld [hVBGCopySrc+1], a
    
    ld a, h
    ld [hVBGCopyDest], a
    ld a, l
    ld [hVBGCopyDest+1], a
    
    scf
    ret
    

;VPalCopy:
;
;    
;
;    ld a, [hVBGPalH]
;    or a
;    ret z
;    	;ld d, a
;
;    
;    ld a, 1
;    ldh [rVBK], a
;
;    	;ld b, d
;
;    
;    ld a, [hVBGPalW]
;    ld c, a
;
;    ld a, [hVBGPalDest]
;    ld h, a
;    ld a, [hVBGPalDest+1]
;    ld l, a
;
;    ld b, ROWS_PER_FRAME
;
;    ld d, 0
;.loop
;    ld e, c
;    push hl
;    ld a, [hVBGPalI]
;    call Fill
;    
;    pop hl
;    ld de, $20
;    add hl, de
;
;    ld a, [hVBGPalH]
;    dec a
;    ld [hVBGPalH], a
;    jr z, .exit
;    
;    dec b
;    jr nz, .loop
;
;.exit
;    
;    ld a, h
;    ld [hVBGPalDest], a
;    ld a, l
;    ld [hVBGPalDest+1], a
;
;    xor a
;    ldh [rVBK], a
;
;    scf
;    ret




WaitOneFrame:
    ld a, 1
    ld [hVBlankFlag], a
.delayLoop
    halt
    ld a, [hVBlankFlag]
    and a
    ret z
    jr .delayLoop

WaitAFrames:
    ld b, a
WaitBFrames:
.loop
    call WaitOneFrame
    dec b
    jr nz, .loop
    ret
