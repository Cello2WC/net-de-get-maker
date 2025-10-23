include "include/charmap.asm"

include "include/constants/icon_constants.asm"
DEF GAME_CATEGORY EQU  CATEGORY_PROGRAM
DEF GAME_GENRE    EQU  GENRE_SHOOTER
DEF GAME_TITLE    EQUS "NASU"
DEF GAME_DESCR    EQUS "Family Gaming"

include "include/header.asm"

pushc
newcharmap nasu


INCLUDE "game/constants.asm"

DisableLCD::
	xor a
	ld [rIF], a
	ld a, [rIE]
	ld b, a
	res 0, a
	ld [rIE], a

.wait
	ld a, [rLY]
	cp LY_VBLANK
	jr nz, .wait

	ld a, [rLCDC]
	and $ff ^ rLCDC_ENABLE_MASK
	ld [rLCDC], a
	ld a, b
	ld [rIE], a
	ret

EnableLCD::
	ld a, [rLCDC]
	set rLCDC_ENABLE, a
	ld [rLCDC], a
	ret
	
	
	



MinigameStart:
	call Start
	
	xor a
	ldh [$FF8E], a
	ldh [$FF8F], a
	ldh [$FF92], a
	ldh [$FF93], a
	
	ret



Start:
	
	;xor a
	;ld [hLYCMode], a
	
	call $0246

    call InitSound

    ld hl, wTempTileBuffer
    ld de, 3*16
    ld a, $83
    call Fill

    call DisableLCD
    call SetPalettes

    bgcoord hl, $1F, $02
    ld bc, $20
    ld d, 8
   		 ;call WaitOneFrame
    ld a, $83
.specialTileLoop
    ld [hl], a
    add hl, bc
    dec d
    jr nz, .specialTileLoop

    ld [$9D1F], a

    ld hl, $8800
    ld bc, GfxFlat
    ;ld d, ($8EC0 - $8800) / 16	; ld de, $8EC0 - $8800	;ld d, $7B
    ld e, 0;LOW($8EC0 - $8800)
REPT HIGH($8EC0 - $8800)
    call Copy
ENDR
    call Copy
    ;call CopyToVram

    call EnableLCD
    ;ld a, ((($8EC0 - $8800) / 16) / 10) + 1	; TILES_PER_FRAME
    ;call WaitAFrames

    
    

	ld a, LOW(VBlank)
	ldh [$FF8E], a
	ld a, HIGH(VBlank)
	ldh [$FF8F], a
	
	;ld a, LOW(LCDC)
	;ldh [$FF92], a
	;ld a, HIGH(LCDC)
	;ldh [$FF93], a
    
    
    ld bc, Silence_Ptrs
    call PlaySong
    

    jp TitleScreen
    
AddATimes:
    or a
    ret z
.loop
    add hl, bc
    dec a
    jr nz, .loop
    ret
    


SetPalettes:
.GBCPal
    ;call WaitOneFrame
    ld a, 1 << rBGPI_AUTO_INCREMENT
    ldh [rBGPI], a
    ld hl, BGPals
    ld b, 8 * 5
.gbcbgploop
    ld a, [hli]
    ldh [rBGPD], a
    dec b
    jr nz, .gbcbgploop

    ld a, 1 << rBGPI_AUTO_INCREMENT
    ldh [rOBPI], a
    ld b, 8 * 4
.gbcobploop
    ld a, [hli]
    ldh [rOBPD], a
    dec b
    jr nz, .gbcobploop
    ret





ClearVOAM:
    ld hl, wVOAM
    ld de, 160
    xor a
    jp Fill

Random:
    ld a, [hRNG+3]
    ld d, a
    
    ld a, [hRNG+2]
    ld [hRNG+3], a
    ld a, [hRNG+1]
    ld [hRNG+2], a
    ld a, [hRNG]
    ld [hRNG+1], a
    ld b, a

    ld a, d
    rra
    rra
    xor d
    ld d, a
    rla
    xor d
    ld d, a
    ld a, b
    rla
    rla
    rla
    rla
    xor b
    xor d
    ld [hRNG], a

    ld b, a
    ld a, [hRNG+5]
    add $CF
    ld [hRNG+5], a
    add b
    ret

    
; hl - string 1
; bc - string 2
; e  - len
;
; return in carry
StringCompare:
.loop
    ld a, [hli]
    ld d, a
    ld a, [bc]
    inc bc
    cp d
    jr nz, .unset
    dec e
    jr nz, .loop
.set
    scf
    ret
.unset
    or a
    ret



INCLUDE "game/vblank.asm"
INCLUDE "game/hblank.asm"
INCLUDE "game/copy.asm"
INCLUDE "game/joypad.asm"
INCLUDE "game/tilemap.asm"
INCLUDE "game/audio.asm"

INCLUDE "game/screens/title.asm"
INCLUDE "game/screens/game.asm"
INCLUDE "game/screens/gameover.asm"

INCLUDE "game/gfx/palettes.asm"

GfxTile:
GfxFlat:     INCBIN "game/gfx/flat.2bpp"
GfxFont:     INCBIN "game/gfx/font.2bpp"
GfxBorder:   INCBIN "game/gfx/border.2bpp"
GfxTitle:    INCBIN "game/gfx/title.2bpp"
GfxCloud:    INCBIN "game/gfx/cloud.2bpp"

GfxSprite:
GfxPlayer:   INCBIN "game/gfx/player.2bpp"
GfxSecret:   INCBIN "game/gfx/secret.2bpp"
GfxPoints:   INCBIN "game/gfx/points.2bpp"
GfxEggplant: INCBIN "game/gfx/eggplant.2bpp"
GfxEnd:

INCLUDE "game/audio_includes.asm"

popc

include "include/footer.asm"
