DEF FIELD_LEFT_EDGE equ $05
DEF FIELD_RIGHT_EDGE equ $9B

CloudData:
    db $83, $C1, $83
    db $C2, $C3, $C4
    
    db $02, $02, $02
    db $02, $02, $02
    
ClearStartData:
    db $83, $83, $83, $83, $83
    db $83, $83, $83, $83, $83
    db $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02
    
GroundData:
    db $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

StartGame::

    ld a, 4
    call SetLYCMode

    ld bc, Silence_Ptrs
    call PlaySong

    call ClearTilemap_KeepBorders
    ld a, 1
	ld [rVBK], a
    ld a, $02
    ld hl, $9800 + BG_MAP_WIDTH
    ld de, BG_MAP_WIDTH * (SCR_HEIGHT-2)
    call Fill
    xor a
	ld [rVBK], a

    coord de, 7, 8
    ld hl, String_Ready
    lb bc, 5, 1
    call APIScreenRectAttr


    ld a, 6
    call WaitAFrames

.skipPal

    call InitGameVars

    ld a, 89
    call WaitAFrames

    ld a, 2
    call SetLYCMode
    
    call WaitOneFrame

    ld bc, GamePlaySong_Ptrs
    call PlaySong
    
        

    coord de, 7, 8
    ld hl, String_Start
    lb bc, 5, 1
    call APIScreenRectAttr
    
    coord de, 0, 15
    lb bc, SCR_WIDTH, 1
    ld hl, GroundData
    push bc
    push hl
    call APIScreenRectAttr
    
    coord de, 0, 16
    pop hl
    pop bc
    call APIScreenRectAttr
    
    coord de, 9, 16
    ld hl, String_Score
    ld bc, 11
    call APICopyVRAM

    coord de, 14, 4
    ld hl, CloudData
    ld bc, $0302
    push hl
    push bc
    call APIScreenRectAttr
    
    coord de, 2, 6
    pop bc
    pop hl
    call APIScreenRectAttr
    
    
    

GameLoop:
    ld a, [wStartTimer]  
    or a
    jr z, .skipStart
    dec a
    jr nz, .noClear
    
    ld hl, ClearStartData
    coord de, 7, 8
    ld bc, $0502
    call APIScreenRectAttr
    
    xor a
.noClear
    ld [wStartTimer], a
.skipStart
    
    ld a, [hJoyDown]
    and a, BUTTON_LEFT | BUTTON_RIGHT
    cp a, BUTTON_LEFT
    jr z, .left
    cp a, BUTTON_RIGHT
    jr nz, .noDir
.right
    ld a, [wNasuJumpTimer]
    or a
    jr nz, .skipFrameRight
    ld a, [wNasuFrame]
    inc a
    res 6, a
    res 7, a
    ld [wNasuFrame], a
.skipFrameRight

    ldh a, [hGlobalTimer]
    and a, %00000111
    
    ld a, [wNasuX]
    jr z, .noInc_right
    inc a
.noInc_right
    cp a, FIELD_RIGHT_EDGE
    jr c, .noRightWall
    ld a, FIELD_RIGHT_EDGE
.noRightWall
    jr .done_hacky
.left
    ld a, [wNasuJumpTimer]
    or a
    jr nz, .skipFrameLeft
    ld a, [wNasuFrame]
    inc a
    res 6, a
    set 7, a
    ld [wNasuFrame], a
.skipFrameLeft

    ldh a, [hGlobalTimer]
    and a, %00000111
    
    ld a, [wNasuX]
    jr z, .noInc_left
    dec a
.noInc_left
    cp a, FIELD_LEFT_EDGE
    jr nc, .noLeftWall
    ld a, FIELD_LEFT_EDGE
.noLeftWall
.done_hacky
    ld [wNasuX], a
    jr .doneDir
.noDir
    ld a, [wNasuFrame]
    and a, %10000000
    set 6, a
    ld [wNasuFrame], a
.doneDir
    ld a, [wNasuJumpTimer]
    or a
    jr nz, .noNewJump
    ld a, [hJoyPressed]
    and a, BUTTON_START | BUTTON_A
    or a
    jr z, .notJumping
    ld a, 25
    ld [wNasuJumpTimer], a

    ld bc, SFX_Jump
    call PlaySFX

        ;ld a, 120 - 5
        ;ld [wNasuY], a
        ;jr .skipJumpUpdate
.noNewJump
    ld a, [wNasuY]
    ld b, a
    ld a, [wNasuJumpTimer]
    or a
    jr z, .skipJumpUpdate
    dec a
    ld [wNasuJumpTimer], a
    or a
    jr z, .finishJump
    cp 20
    jr nc, .dec2
    cp 17
    jr nc, .dec1
    cp 15
    jr z, .dec1
    cp 11
    jr z, .add1
    cp 8
    jr nc, .skipJumpUpdate
    cp 5
    jr nc, .add1
.add2
    inc b
.add1
    inc b
    jr .endjump_hacky
.dec2
    dec b
.dec1
    dec b
.endjump_hacky
    ld a, b
    ld [wNasuY], a
    jr .skipJumpUpdate
.finishJump
    ld a, 120
    ld [wNasuY], a
    ld bc, SFX_Land
    call PlaySFX
.skipJumpUpdate
    call EggplantCheck
    call RedEggplantCheck
    jr .jumped
.notJumping
    ld a, [wFlags]
    res 0, a
    ld [wFlags], a

    ld a, [wNasuFrame]
    and a, %00111111
    cp a, 1
    jr nz, .otherSound
    ld bc, SFX_Walk1
    call PlaySFX
    jr .noSound
.otherSound
    cp a, 13
    jr nz, .noSound
    ld bc, SFX_Walk2
    call PlaySFX
.noSound

.jumped
    ld a, [wNasuFrame]
    and a, %00111111
    cp a, 24
    jr c, .less
    ld a, [wNasuFrame]
    and a, %11000000
    ld [wNasuFrame], a

.less

    

    

    ld a, [wFlags]
    bit 1, a
    jr z, .noRedEggplant
    ld a, [wBonusTimer]
    cp $FF
    jr nz, .noRedEggplant
    call NewRedEggplant
    
.noRedEggplant


    ;ld a, wNasuFrame


    call UpdateRedEggplant

    call DrawNasu
    call DrawEggplant
    call DrawRedEggplant
    call DrawSmallPoints
    call CapScore
    call DrawScore

    ld a, [wEggplantY]
    inc a
    ld [wEggplantY], a
    cp 133
    jp z, GameOver
.gameNotOver
    


    call WaitOneFrame
    jp GameLoop


InitGameVars:
    xor a
    ld hl, wScore
    ld de, wPts2Timer - wScore
    call Fill
    
    ld a, 60
    ld [wStartTimer], a
    ld a, 80
    ld [wNasuX], a
    ld a, 120
    ld [wNasuY], a
    ld a, %10000000
    ld [wNasuFrame], a
    ld a, 84
    ld [wEggplantX], a
    ld a, -47 + 16 - 4
    ld [wEggplantY], a
    ld a, $FF
    ld [wBonusTimer], a
    ret
    
    

DrawNasu:
    
    ld a, [wNasuY]
    ld [wVOAM+(8*4)], a
    ld [wVOAM+(8*4) + 4], a
    add a, 8
    ld [wVOAM+(8*4) + 8], a
    ld [wVOAM+(8*4) + 12], a
    ld a, [wNasuFrame]
    bit 7, a
    jr z, .noFlip
    ld a, [wNasuX]
    ld [wVOAM+(8*4) + 5], a
    ld [wVOAM+(8*4) + 13], a
    add a, 8
    ld [wVOAM+(8*4) + 1], a
    ld [wVOAM+(8*4) + 9], a
    ld a, %00100001
    jr .doneFlip
.noFlip
    ld a, [wNasuX]
    ld [wVOAM+(8*4) + 1], a
    ld [wVOAM+(8*4) + 9], a
    add a, 8
    ld [wVOAM+(8*4) + 5], a
    ld [wVOAM+(8*4) + 13], a
    ld a, %00000001
.doneFlip
    ld [wVOAM+(8*4) + 3], a
    ld [wVOAM+(8*4) + 7], a
    ld [wVOAM+(8*4) + 11], a
    ld [wVOAM+(8*4) + 15], a

    ld a, [wNasuJumpTimer]
    or a
    jr z, .noJump
    ld a, $0C
    jr .doneFrameCalc
.noJump
    ld a, [wNasuFrame]
    bit 6, a
    jr nz, .still
    and a, %00011111
    cp 12
    ld a, 4
    jr c, .less
    add a, 4
.less
    jr .doneFrameCalc
.still
    xor a
.doneFrameCalc
    add a, $C5
    ld [wVOAM+(8*4) + 2], a
    inc a
    ld [wVOAM+(8*4) + 6], a
    inc a
    ld [wVOAM+(8*4) + 10], a
    inc a
    ld [wVOAM+(8*4) + 14], a
    
    ld a, [wFlags]
    bit 2, a
    call nz, DrawCheaterEggplant    

    ret

DrawCheaterEggplant:

    ld b, 0

    ld a, [wNasuJumpTimer]
    or a
    jr nz, .jump
    ld a, [wNasuFrame]
    bit 6, a
    jr nz, .still
    and a, %00011111
    cp 12
    jr c, .less
.more
    ld b, $01
    ld a, $D7
    ld [wVOAM+(8*4)+14], a
    jr .doneFrameCalc
.jump
    ld b, $01
    ld a, $D8
    ld [wVOAM+(8*4)+10], a
    inc a
    ld [wVOAM+(8*4)+14], a
    jr .doneFrameCalc
.still
    ld a, $D5
    ld [wVOAM+(8*4)+14], a
    jr .doneFrameCalc
.less
    ld a, $D6
    ld [wVOAM+(8*4)+14], a

.doneFrameCalc


    ld a, [wNasuY]
    sub 4
    add b
    ld [wVOAM+(4*4)], a
    ld [wVOAM+(4*4) + 4], a
    add a, 8
    ld [wVOAM+(4*4) + 8], a
    ld [wVOAM+(4*4) + 12], a
    ld a, [wNasuFrame]
    bit 7, a
    jr nz, .noFlip
    ld a, [wNasuX]
    ld [wVOAM+(4*4) + 5], a
    ld [wVOAM+(4*4) + 13], a
    add a, 8
    ld [wVOAM+(4*4) + 1], a
    ld [wVOAM+(4*4) + 9], a
    ld a, %00100010
    jr .doneFlip
.noFlip
    ld a, [wNasuX]
    ld [wVOAM+(4*4) + 1], a
    ld [wVOAM+(4*4) + 9], a
    add a, 8
    ld [wVOAM+(4*4) + 5], a
    ld [wVOAM+(4*4) + 13], a
    ld a, %00000010
.doneFlip
    ld [wVOAM+(4*4) + 3], a
    ld [wVOAM+(4*4) + 7], a
    ld [wVOAM+(4*4) + 11], a
    ld [wVOAM+(4*4) + 15], a
    ld a, $DA
    ld [wVOAM+(4*4) + 2], a
    inc a
    ld [wVOAM+(4*4) + 6], a
    inc a
    ld [wVOAM+(4*4) + 10], a
    inc a
    ld [wVOAM+(4*4) + 14], a
                ;ld a, %00000010
    


    ld hl, wVOAM+(8*4)
    ld de, 4*2
    xor a
    call Fill

    ret
    
    

DrawEggplant:
    ld hl, wVOAM + (4*16)
    ld a, [wEggplantY]
    ld [hli], a
    ld a, [wEggplantX]
    ld [hli], a
    ld a, $E1
    ld [hli], a
    ld a, %00000010
    ld [hli], a
    ret

EggplantCheckBC:
    ld a, [wNasuX]	; b >= a
    dec a
    cp b
    jr nc, .unset
    add 7		; b <= a+6
    cp b
    jr c, .unset

    ld a, [wNasuY]	; b >= a
    dec a
    cp c
    jr nc, .unset
    add 7		; b <= a+6
    cp c
    jr c, .unset
.set


    ; is this best place for this?
    ld a, [wFlags]
    bit 0, a
    jr nz, .bonus1000
    set 0, a
    ld [wFlags], a

    ld bc, SFX_Get
    call PlaySFX

    scf
    ret
.unset
    or a
    ret
.bonus1000
    call Add1000Points

    
    ld bc, SFX_Bonus
    call PlaySFX

    ld a, $FF
    ld [wImportantSFX], a
    
    coord de, 7, 8
    ld hl, String_Bonus
    ld bc, 5
    call APICopyVRAM
    
    coord de, 8, 9
    ld hl, String_1000
    ld bc, 4
    call APICopyVRAM

;    ld a, 8
;    call CopyTwoRowsToScreen
;    			call CopyTilemapToScreen
;
    ;call WaitOneFrame     ; stutter
;    ld a, 9
;    call CopyTileRowToScreen
;    call WaitOneFrame
    
    ld a, 90
    ld [wStartTimer], a

    scf
    ret

EggplantCheck:
    ld a, [wEggplantX]
    ld b, a
    ld a, [wEggplantY]
    ld c, a

    call EggplantCheckBC
    ret nc

    call NewEggplant
    call Add10Points

    ld a, [wFlags]
    bit 2, a
    jr nz, .redEggplant
    call APIRandom
    cp 4
    jr nc, .noRedEggplant
.redEggplant
    call SetNewRedEggplant
.noRedEggplant

    ld a, [wNasuX]
    add 16
    ld [wPts1X], a
    ld a, [wNasuY]
    ld [wPts1Y], a
    ld a, 30
    ld [wPts1Timer], a

    ret
    
NewEggplant:
    ld a, -47 - 4
    ld [wEggplantY], a
    call APIRandom
    res 7, a
    add FIELD_LEFT_EDGE + 11 + 8 - 4	;add 24 - 4
    ld [wEggplantX], a
    ret

DrawSmallPoints:
    ld a, [wPts1Timer]
    or a
    jr z, .three
    dec a
    ld [wPts1Timer], a
;    cp a, 29
;    jr z, .addPtsOne
    or a
    jr z, .three
;.removePtsOne
;    xor a
;    ld hl, wVOAM;+(4*6)
;    ld de, 4
;    call Fill
;    jr .three
.addPtsOne
;    		ld [wPts1Timer], a
    ld a, [wPts1Y]
    ld [wVOAM + (4*0)], a	;6
    ld a, [wPts1X]
    ld [wVOAM + (4*0) + 1], a
    ld a, $DE
    ld [wVOAM + (4*0) + 2], a
    xor a
    ld [wVOAM + (4*0) + 3], a




.three
    ld a, [wPts2Timer]
    or a
    ret z
    dec a
    ld [wPts2Timer], a
;    cp a, 29
;    jr z, .addPtsThree
    or a
    ret z
;.removePtsThree
;    xor a
;    ld hl, wVOAM+(4*1)
;    ld de, 8
;    call Fill
;    ret
.addPtsThree
;    		ld [wPts2Timer], a
    ld a, [wPts2Y]
    ld [wVOAM + (4*1)], a	;6
    ld [wVOAM + (4*2)], a	;6
    ld a, [wPts2X]
    ld [wVOAM + (4*1) + 1], a
    add 8
    ld [wVOAM + (4*2) + 1], a
    ld a, $DF
    ld [wVOAM + (4*1) + 2], a
    inc a
    ld [wVOAM + (4*2) + 2], a
    xor a
    ld [wVOAM + (4*1) + 3], a
    ld [wVOAM + (4*2) + 3], a



    ret

Add10Points:
    ld a, [wScore+1]
    inc a
    ld [wScore+1], a
    ret nc
    ld a, [wScore]
    inc a
    ld [wScore], a
    ret
    
Add300Points:
    ld a, [wScore+1]
    add 30
    ld [wScore+1], a
    ret nc
    ld a, [wScore]
    inc a
    ld [wScore], a
    ret

Add1000Points:
    ld a, [wScore+1]
    add 100
    ld [wScore+1], a
    ret nc
    ld a, [wScore]
    inc a
    ld [wScore], a
    ret

CapScore:
    ld a, [wScore]
    cp 39
    ret c
    ld a, [wScore+1]
    cp 16
    ret c
    ld a, %10000000
    ld [wScore], a
    xor a
    ld [wScore+1], a
    ret

DrawScore:
;    ld a, [hVBGCopyLen]
;    or a
;    ret nz
    
;    ld a, [hVBGPalH]
;    or a
;    ret nz
    
    coord hl, 15, 16
    call DrawScoreAtHL
;    ld a, 16
;    call CopyTileRowToScreen
    ret
    
SetNewRedEggplant:
    ld a, [wFlags]
    set 1, a
    ld [wFlags], a
    ret

NewRedEggplant:
    ld a, [wFlags]
    res 1, a
    ld [wFlags], a
    ld a, FIELD_LEFT_EDGE - 10 + 8 - 4
    ld [wBonusX], a
    ld a, 120 + 8 + 8 - 8
    ld [wBonusY], a
    xor a
    ld [wBonusTimer], a
    ret

UpdateRedEggplant:
    ld a, [wBonusTimer]
    cp $FF
    ret z
    inc a
    cp a, 50
    jr c, .noCap
    xor a
.noCap
    ld [wBonusTimer], a
    and a, %00000011
    or a
    jr nz, .noXMove

    ldh a, [hGlobalTimer]
    and a, %00011100
    or a
    jr z, .noXMove
    
    ld a, [wBonusX]
    inc a
    ld [wBonusX], a
    ;add 10
    cp a, FIELD_RIGHT_EDGE + 16 + 8 - 4 ;- 10
    jr nc, .despawn
.noXMove
    ld a, [wBonusY]
    ld b, a
    ld a, [wBonusTimer]
    bit 0, a
    jr nz, .noYMove
    cp 40
    jr nc, .add2
    cp 34
    jr nc, .add1
    cp 28
    jr z, .add1
    cp 20
    jr z, .sub1
    cp 16
    jr nc, .noYMove
    cp 10
    jr nc, .sub1
.sub2
    dec b
.sub1
    dec b
    jr .btoy
.add2
    inc b
.add1
    inc b
.btoy
    ld a, b
    ld [wBonusY], a
.noYMove
    ret
.despawn
    ld a, $FF
    ld [wBonusTimer], a
    ret

DrawRedEggplant:
    ld hl, wVOAM + (4*17)
    ld a, [wBonusY]
    ld [hli], a
    ld a, [wBonusX]
    ld [hli], a
    ld a, $E1
    ld [hli], a
    ld a, %00010011
    ld [hli], a
    ret

RedEggplantCheck:
    ld a, [wBonusX]
    ld b, a
    ld a, [wBonusY]
    ld c, a

    call EggplantCheckBC
    ret nc

    call Add300Points

    ld a, [wNasuX]
    add 16 - 8
    ld [wPts2X], a
    ld a, [wNasuY]
    ld [wPts2Y], a
    ld a, 30
    ld [wPts2Timer], a

    ld a, $FF
    ld [wBonusY], a
    ld [wBonusTimer], a

    ret

String_Ready:
    db "READY"
    db 0,0,0,0,0
String_Start:
    db "START"
    db 0,0,0,0,0
String_Score:
    db "SCORE 00000"
String_Bonus:
    db "BONUS"
String_1000:
    db "1000"




;GameOver:
;    call NewEggplant
;    jp GameLoop.gameNotOver
