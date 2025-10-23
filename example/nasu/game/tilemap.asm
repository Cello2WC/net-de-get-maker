UseMapZero:
    ldh a, [rLCDC]
    and a, %11110111
    jr UseMapOne.load
UseMapOne:
    ldh a, [rLCDC]
    or a, %00001000
.load
    ldh [rLCDC], a
    ret


ClearTilemap:
    ld a, $83
    ld hl, wTileMap
    ld de, SCR_WIDTH * SCR_HEIGHT
    jp Fill

ClearTilemap_KeepBorders:
    ld a, $83
    ld hl, wTileMap + SCR_WIDTH
    ld de, SCR_WIDTH * (SCR_HEIGHT-2)
    jp Fill

CopyTilemapToScreen_2:
    	;ld hl, $9C00
    ld a, $9C
    ld [hVBGCopyDest], a
    jr CopyTilemapToScreen.entry
CopyTilemapToScreen:
    	;ld hl, $9800
    ld a, $98
    ld [hVBGCopyDest], a
.entry
    xor a
    ld [hVBGCopyDest+1], a
    ld [hVBGCopySrc+1], a
    ld a, HIGH(wTileMap)
    ld [hVBGCopySrc], a
    ld a, SCR_HEIGHT
    ld [hVBGCopyLen], a
    ret


;.entry
;    ld e, 6; SCR_HEIGHT, 
;    ld bc, wTileMap
;.biggerLoop
;    ld d, 3
;    call WaitOneFrame
;.loop
;    push de
;    ld de, SCR_WIDTH
;    call Copy
;    pop de
;    push bc
;    ld bc, $20 - SCR_WIDTH
;    add hl, bc
;    pop bc
;    dec d
;    jr nz, .loop
;    dec e
;    jr nz, .biggerLoop
;    ret


RowToAddresses:
    ld hl, $9800
    ld bc, $20
    push af
    call AddATimes
    pop af
    ld d, h
    ld e, l
    ld hl, wTileMap
    ld bc, SCR_WIDTH
    jp AddATimes

; a - row to copy
CopyTileRowToScreen:
    call RowToAddresses

    ld a, h
    ld [hVBGCopySrc], a
    ld a, l
    ld [hVBGCopySrc+1], a

    ld a, d
    ld [hVBGCopyDest], a
    ld a, e
    ld [hVBGCopyDest+1], a

    ld a, 1
    ld [hVBGCopyLen], a
    ret




;    ;push hl
;    ;push de
;    ;pop hl
;    ;pop bc
;
;    ;call WaitOneFrame
;    ;ld de, SCR_WIDTH
;    ;jp Copy

;    ld a, h
;    ld [hVCopySrc], a
;    ld a, l
;    ld [hVCopySrc+1], a
    ;
;    d a, d
;    ld [hVCopyDest], a
;    ld a, e
;    ld [hVCopyDest+1], a
    
;   	 ;ld a, 2
;    ld a, 2
;    ld [hVCopyLen], a
;    ret

; a - first row to copy
CopyTwoRowsToScreen:
    call RowToAddresses

    ld a, h
    ld [hVBGCopySrc], a
    ld a, l
    ld [hVBGCopySrc+1], a

    ld a, d
    ld [hVBGCopyDest], a
    ld a, e
    ld [hVBGCopyDest+1], a

    ld a, 2
    ld [hVBGCopyLen], a
    ret





    ;push af

    ;ld hl, wTileMap
    ;ld bc, SCR_WIDTH
    ;call AddATimes
    
    ;ld b, h
    ;ld c, l
    ;ld hl, wTempTileBuffer
    ;ld e, SCR_WIDTH
    ;call Copy
    ;push bc
    ;ld bc, $20 - SCR_WIDTH
    ;add hl, bc
    ;pop bc
    ;ld e, SCR_WIDTH
    ;call Copy

    ;pop af
    ;ld hl, $9800
    ;ld bc, $20
    ;call AddATimes
    
    ;ld a, h
    ;ld [hVCopyDest], a
    ;ld a, l
    ;ld [hVCopyDest+1], a

    ;ld a, HIGH(wTempTileBuffer)
    ;ld [hVCopySrc], a
    ;ld a, LOW(wTempTileBuffer)
    ;ld [hVCopySrc+1], a

    ;ld a, 3
    ;ld [hVCopyLen], a
    ;ret
    
    
    

; hl - bgcoord
; de - wh
; a - pal id
PaletteRect:
   
    ld [hVBGPalI], a
   ; ld b, a
    push de

    ld a, [hCopyTo]
    or a
    jr z, .mapOne
    ld de, $0400
    add hl, de
.mapOne

    pop de
    
   ; ld a, h
   ; ld [hVBGPalDest], a
   ; ld a, l
   ; ld [hVBGPalDest+1], a
    
    ld a, d
    ld [hVBGPalW], a
    ld a, e
    ld [hVBGPalH], a
    
    ;ld a, b
    ;ld [hVBGPalI], a
    
    
    ld a, 1
    ldh [rVBK], a

    	;ld b, d

    
    ld a, [hVBGPalW]
    ld c, a

    ;ld a, [hVBGPalDest]
    ;ld h, a
    ;ld a, [hVBGPalDest+1]
    ;ld l, a

    ;ld b, ROWS_PER_FRAME

    ld d, 0
.loop
    ld e, c
    push hl
    ld a, [hVBGPalI]
    call Fill
    
    pop hl
    ld de, $20
    add hl, de

    ld a, [hVBGPalH]
    dec a
    ld [hVBGPalH], a
    jr nz, .loop
    
   ; dec b
   ; jr nz, .loop

.exit
    
    ld a, h
    ld [hVBGPalDest], a
    ld a, l
    ld [hVBGPalDest+1], a

    xor a
    ldh [rVBK], a

    ;scf
    ret
    
    ;ret







;    push af
;    ld a, [hCopyTo]
;    or a
;    jr z, .mapOne
;    ld bc, $0400
;    add hl, bc
;.mapOne
;    pop af
;    ld b, a
;    ld a, 1
;    ldh [rVBK], a
;    ld a, b

;;.colLoop
;    push hl
;    ld b, d
;.rowLoop
;    ld [hli], a
;    dec d
;    jr nz, .rowLoop
;    ld d, b
;    pop hl;

;    push af
;    ldh a, [rSTAT]
;    and a, %00000011
;    cp 1
;    jr z, .noProblem
;    call WaitOneFrame
;    pop af
;    jr .colLoop
;.noProblem
;    pop af
    
;    dec e
;;    jr z, .exit
;    ld bc, $20
;    add hl, bc
;    jr .colLoop
    
;.exit
;    xor a
;    ldh [rVBK], a
    
;    ret

DrawBorders:
    ld d, SCR_WIDTH
    ld hl, wTileMap
    ld bc, SCR_WIDTH*(SCR_HEIGHT-1)
.resetLoop
    ld a, $A1
.loop
    push hl
    add hl, bc
    ld [hl], a
    pop hl
    ld [hli], a
    dec d
    jr z, .done
    inc a
    cp a, $A4
    jr c, .loop
    jr .resetLoop
.done
;    call IsGBC
;    ret z
    
    bgcoord hl, 0, 0
    lb de, SCR_WIDTH, 1
    ld a, 4
    call PaletteRect
    ;call WaitOneFrame
    bgcoord hl, 0, SCR_HEIGHT-1
    lb de, SCR_WIDTH, 1
    ld a, 4
    call PaletteRect
    
    bgcoord hl, 0, 1
    lb de, SCR_WIDTH, SCR_HEIGHT-2
    xor a
    jp PaletteRect




DrawScoreAtHL:
    ld a, [wScore]
    bit 7, a
    jr z, .notCapped
    ld a, "9"
    ld de, 5
    jp Fill
.notCapped

    push hl ; needed?

    ld a, [wScore]
    ld h, a
    ld a, [wScore+1]
    ld l, a

    ld d, -1
    ld bc, -1000

.thousandsloop
    inc d
    ld a, h
    cp $03
    jr c, .exitthousands
    jr nz, .thousands_notestl
    ld a, l
    cp $E8
    jr c, .exitthousands
.thousands_notestl
    add hl, bc
    jr .thousandsloop
.exitthousands

;    	;ld bc, 1000
;    	;add hl, bc

    ld a, "0"
    add d
    ld [wTempDrawNum], a

    ld d, -1
    ld bc, -100

.hundredsloop
    inc d
    ld a, h
    or a
    jr nz, .hundreds_notestl
    ld a, l
    cp $64
    jr c, .exithundreds
.hundreds_notestl
    add hl, bc
    jr .hundredsloop
.exithundreds
;    	ld bc, 100
;    	add hl, bc
    
    ld a, "0"
    add d
    ld [wTempDrawNum+1], a

    ld d, -1
    ld a, l

.tensloop
    inc d
    sub 10
    jr nc, .tensloop

    add 10
    ld l, a

    ld a, "0"
    add d
    ld [wTempDrawNum+2], a

    ld a, "0"
    add l
    ld [wTempDrawNum+3], a
    
    pop hl

    ld bc, wTempDrawNum
    ld de, 4
    jp Copy
