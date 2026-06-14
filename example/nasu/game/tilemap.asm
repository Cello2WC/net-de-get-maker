;UseMapZero:
;    ldh a, [rLCDC]
;    and a, %11110111
;    jr UseMapOne.load
;UseMapOne:
;    ldh a, [rLCDC]
;    or a, %00001000
;.load
;    ldh [rLCDC], a
;    ret


;ClearTilemap:
;    ld a, $83
;    ld hl, wTileMap
;    ld de, SCR_WIDTH * SCR_HEIGHT
;    jp Fill

ClearTilemap_KeepBorders:
    ld a, $83
    ld hl, $9800 + BG_MAP_WIDTH
    ld de, BG_MAP_WIDTH * (SCR_HEIGHT-2)
    jp Fill



DrawBorders:
    ld hl, .pattern
    ld bc, $1401
    ld de, $9800
    call APIScreenRectAttr
    ld hl, .pattern
    ld bc, $1401
    ld de, $9800+(32*17)
    jp APIScreenRectAttr
.pattern
    db $A1, $A2, $A3, $A1, $A2, $A3, $A1, $A2, $A3, $A1, $A2, $A3, $A1, $A2, $A3, $A1, $A2, $A3, $A1, $A2
    db $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84




DrawScoreAtHL:
    ld a, [wScore]
    bit 7, a
    jr z, .notCapped
    ld a, CHARVAL("9")
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

    ld a, CHARVAL("0")
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
    
    ld a, CHARVAL("0")
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

    ld a, CHARVAL("0")
    add d
    ld [wTempDrawNum+2], a

    ld a, CHARVAL("0")
    add l
    ld [wTempDrawNum+3], a
    
    pop de
    ld hl, wTempDrawNum
    ld bc, 4
    jp APICopy
