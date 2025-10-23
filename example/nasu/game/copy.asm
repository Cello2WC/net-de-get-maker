; bc - src
; hl - dest
; e - len
Copy:
.loop
    ld a, [bc]
    ld [hli], a
    inc bc
    dec e
    jr nz, .loop
    ret
    
LongCopy:
    inc d
.loop
    ld a, [bc]
    ld [hli], a
    inc bc
    dec e
    jr nz, .loop
    dec d
    jr nz, .loop
    ret

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

CopyScreen:
    ld bc, wTileMap
DEF loopind = 0
REPT 17
    ld hl, $9800+($20*loopind)
    ld e, 20
    call Copy
DEF loopind += 1
ENDR
    ld hl, $9800+($20*loopind)
    ld e, 20
    jp Copy
    
;CopyTile
;    ld e, $10
;.copyTileLoop
;    ld a, [bc]
;    ld [hli], a
;    inc bc
;    dec e
;    jr nz, .copyTileLoop
;    ret



; bc - src
; hl - dest
; d - len (tiles)
;CopyToVram:
;    call WaitOneFrame
;    ld a, d
;    cp a, NUM_TILES_PER_FRAME
;    jr c, .lessThanFrame
;.copyLoop
;    push de
;    ld e, NUM_TILES_PER_FRAME * $10
;    call Copy
;    pop af
;    sub NUM_TILES_PER_FRAME
;    ld d, a
;    ;jr nz, .copyLoop
;    jr CopyToVram
;.lessThanFrame
;    call CopyTile
;    dec d
;    jr nz, .lessThanFrame
;    ret


;CopyToVram:
;    ld a, b
;    ld [hVCopySrc], a
;    ld a, c
;    ld [hVCopySrc+1], a
;    
;    ld a, h
;    ld [hVCopyDest], a
;    ld a, l
;    ld [hVCopyDest+1], a
;
;    ld a, d
;    ld [hVCopyLen], a
;    ;ld a, e
;    ;ld [hVCopyLen+1], a
;    ret



    


; a - value
; hl - dest
; de - len
Fill:
    push bc
.loop
    ld [hli], a
    dec de
    ld b, a
    ld a, d
    or e
    ld a, b
    jr nz, .loop
    pop bc
    ret

; a - initial value
; hl - dest
; de - len
IncFill:
    ld [hli], a
    dec de
    inc a
    ld b, a
    ld a, d
    or e
    ld a, b
    jr nz, IncFill
    ret
