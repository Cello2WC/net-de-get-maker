DEF LYCMODE_NONE equ 0
DEF LYCMODE_TITLE equ 1
DEF LYCMODE_GAME equ 2
DEF LYCMODE_GAMEOVER_1 equ 3
DEF LYCMODE_GAMEOVER_2 equ 4
DEF LYCMODE_READY equ 4


LCDC:
    push af
    push bc
    push de
    push hl

    ld a, [hLYCMode]
    or a
    jp z, .done
    cp LYCMODE_TITLE
    jr nz, .next
    ldh a, [rLY]
    cp 15
    jr nz, .title_lowerline
    ld a, -4
    ldh [rSCX], a
    jp .done
.title_lowerline
    cp 71
    jp nz, .done
    ld a, 0
    ldh [rSCX], a
    jp .done
.next
    cp LYCMODE_GAME
    jp nz, .next2
    ldh a, [rLY]
    cp 7
    jr nz, .game_bonusline_1
    ldh a, [rLCDC]
    set 1, a
    ldh [rLCDC], a
    jp .done
.game_bonusline_1
    cp 63;71
    jr nz, .game_bonusline_2
    ld a, -4
    ldh [rSCX], a
    jp .done
.game_bonusline_2
    cp 71;79
    jr nz, .game_lowerline
    xor a
    ldh [rSCX], a
    jp .done
.game_lowerline
    cp 120
    jp nz, .game_lowestline
    ld a, %10100100
    ldh [rBGP], a
    jp .done
.game_lowestline
    cp 135
    jp nz, .done
    ldh a, [rLCDC]
    res 1, a
    ldh [rLCDC], a
    
    ld a, %11100100
    ldh [rBGP], a
    
    jp .done
.next2
    cp LYCMODE_GAMEOVER_1
    jp nz, .next3
    ldh a, [rLY]
.gameover1_line0
    cp 8
    jp nz, .gameover1_line1
    ld a, [wFlashPal]
    or a
    jp z, .done
    ld a, %01011011
    ld [rBGP], a
    jp .done
.gameover1_line1
    cp 120
    jp nz, .gameover1_line2
    ld a, %10100100
    ldh [rBGP], a
    jp .done
.gameover1_line2
    cp 136
    jp nz, .done
    
    ld a, %11100100
    ldh [rBGP], a
    
    jp .done
.next3
.next4
    cp LYCMODE_READY
    jp nz, .next5
    ldh a, [rLY]
.readyline1
    cp 64;71
    jr nz, .readyline2
    ld a, -4
    ldh [rSCX], a
    jp .done
.readyline2
    cp 72;79
    jr nz, .done
    xor a
    ldh [rSCX], a
    jp .done
.next5
.done
    pop hl
    pop de
    pop bc
    pop af
    reti



; a - mode
SetLYCMode:
    ld [hLYCMode], a
    or a
    jr nz, .enable
.disable
    ldh a, [rSTAT]
    res 3, a    ;6
    ldh [rSTAT], a
    ldh a, [$FFFF]
    res 1, a
    ldh [$FFFF], a
    ret
.enable
    ldh a, [rSTAT]
    set 3, a    ;6
    ldh [rSTAT], a
    ldh a, [$FFFF]
    set 1, a
    ldh [$FFFF], a
    ret


