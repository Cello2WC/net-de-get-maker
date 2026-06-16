include "include/api.asm"
include "include/charmap.asm"
include "include/constants/icon_constants.asm"
include "include/macros.asm"
include "include/ram.asm"
include "include/hardware.inc"

; Affects minigame's primary icon
; Accepted values:
; CATEGORY_PROGRAM
;  - Standalone minigame
; CATEGORY_APPEND
;  - Add-on to another minigame
DEF GAME_CATEGORY EQU CATEGORY_PROGRAM

; Affects minigame's secondary icon
; Accepted values:
; GENRE_MISC
; GENRE_ACTION
; GENRE_PUZZLE
; GENRE_PLATFORMER
; GENRE_RPG
; GENRE_SIMULATION
; GENRE_SHOOTER
; GENRE_ADVENTURE
DEF GAME_GENRE EQU GENRE_SHOOTER

; String
; Max. 10 characters (20 bytes)
game_title "NASU"

; String
; Max. 18 characters
; Max. 31 bytes
;  - Characters with dakuten are two bytes
game_description "From Yume Nikki"

include "include/header.asm"




MinigameStart:
	; This is the menu at the beginning of the game,
	; with "Start" and "Info" as options.
	call BeginMenu
	; If the player backed out of the initial menu,
	; then I can return early.
	ld a, [wMenuChoice]
	cp $ff
	ret z

		; I mess with these, so I'm backing them up to restore later.
	ldh a, [rSTAT]
	ld b, a
	ldh a, [$FFFF]
	ld c, a
	; I'm trying to avoid using too much of the stack,
	; because Net de Get puts its stack in HRAM, which is tiny.
	push bc

	; This is where I put the majority of my game.
	call GameBody
	
	; Prepare memory for the 
	; Net de Get game over screen.
	call PrepareGameOver
	
	; Don't forget to change the interrupt vectors
	; back to 0000 before returning from your game!
	call ResetInterrupts
	
	; Reset the X scroll value, because I mess with it
	xor a
	ldh [rSCX], a
	
	; Remember when I backed these up to restore later?
	; It's later!
	pop bc
	ld a, c
	ldh [$FFFF], a
	ld a, b
	ldh [rSTAT], a
	
	; And now I can return control of execution
	; back to Net de Get!
	ret
	
ResetInterrupts:
	di
	ld de, 0
	call APISetVBlank
	call APISetTimer
	call APISetLCDC
	call APISetSerial
	ei
	ret

PrepareGameOver:
	; Set the text to be displayed on Net de Get's Game Over screen
	ld hl, wGameOverLine1
	ld de, .string1 ; "  SCORE <NULL>"
	call StringCopy
	
	; Loading the player's score into `de` to be displayed
	; No, I don't remember why I stored the scores in big-endian.
	; This demo is based on some old homebrew of mine. Blame past me.
	ld a, [wScore+1]
	ld e, a
	ld a, [wScore]
	ld d, a
	; Convert `de` into a max-4-digit printable number
	call APINumString4
	; The final 0 of this game's scores is decorative.
	; Points are only ever given in multiples of 10.
	ld a, CHARVAL("0")
	ld [hli], a
	; Don't forget the null terminator!
	xor a
	ld [hl], a
	
	; Now we do the same for the Hi-Score.
	ld hl, wGameOverLine2
	ld de, .string2 ; "  HIGH  <NULL>"
	call StringCopy
	
	ld a, [wHighScore+1]
	ld e, a
	ld a, [wHighScore]
	ld d, a
	; Convert `de` into a max-4-digit printable number
	call APINumString4
	; Decorative 0
	ld a, CHARVAL("0")
	ld [hli], a
	; Null-terminator
	xor a
	ld [hl], a
	
	; TODO: better point reward calculation
	; NASU hardly ever gives any points currently.
	ld a, [wScore] 
	ld h, a
	ld a, [wScore+1]
	ld l, a
	ld c, 10
	call APIWordDivide
	
	ld a, l
	ld [wReactPointReward], a ; reaction point reward
	xor a
	ld [wSmartPointReward], a ; smarts point reward
	ld [wTastePointReward], a ; taste point reward
	ret
.string1
	db "  SCORE <NULL>"
.string2
	db "  HIGH  <NULL>"
	
WaitFade:
	ld hl, BGPals
	ld a, 4
	call APIPackAllPalettes
.loop
	call APIApplyAllPalettes
	call APIDrawSprites
	call WaitOneFrame
	ld a, [wPalPackScale]
	or a
	jr nz, .loop
	ret
	
GameInfo:
	ld a, [wMinigameFlashBank]
	ldh [$FF9D], a ; Bank B Num
	ld a, $08
	ldh [$FF9E], a ; Bank B Rom/Flash Select
	
	ld a, LOW(GameInfoData+$2000)
	ldh [$FF9F], a ; Pointer Lo
	ld a, HIGH(GameInfoData+$2000)
	ldh [$FFA0], a ; Pointer Hi
	ld a, 5
	ld b, 0
	call APIPredef
	call WaitFade
	
	; Fall through to BeginMenu.
	
BeginMenu:
	ld a, $FF
	ld [$D07F], a
	ld a, 2
	ld c, a
	ld hl, .Options
	call APIDoMenu
	ld a, [wMenuChoice]
	cp $FF
	jr z, .backedOut
	; There's a restart vector for the jumptable function,
	; but for some reason I've not seen it be used in
	; Net de Get's own code...
	rst 0 ; Jumptable
.OptionFuncs
	dw .Start
	dw GameInfo
.Start
	call WaitFade
	ret
.backedOut
	ld a, $10
	ld [wGameReturnState], a
	
	call ResetInterrupts
	
	ld a, $FF
	ld [wMenuChoice], a
	ret

	
.Options
	db "Start<NULL>"
	db "Info<NULL>"
	
GameInfoData:
.palettes
	dw $0000, $35AD, $6C1F, $7FFF
	dw $001F, $210D, $0000, $7FFF
	dw $7C00, $3D8C, $0000, $7FFF
	dw $7FFF, $0000, $001F, $497E
	dw $7FFF, $0000, $7E68, $7FFF
	dw $0260, $338D, $0000, $7FFF
	dw $6C1F, $6C1F, $6C1F, $6C1F
	dw $4401, $7CC8, $7E8A, $7FFF
	dw $0000, $0000, $56B5, $7FFF
	dw $001F, $210D, $56B5, $7FFF
	dw $7C00, $3D8C, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $0000, $294A, $56B5, $7FFF
	dw $4401, $7CC8, $7E8A, $7FFF
.header
	db 2 ; Number of pages
	dw .page1+$2000
	dw .page2+$2000
	dw 5 ; ???
	dw 6 ; ???
.page1
	db "RULES(1)<LINE>"
	db "A game where the   <LINE>"
	db "bird-like-creature <LINE>"
	db "jumps to catch the <LINE>"
	db "falling eggplants.<NULL>"
.page2
	db "RULES(2)<LINE>"
	db "Use the ✜ to move  <LINE>"
	db "left and right.    <LINE>"
	db "Use the Ⓐ button   <LINE>"
	db "to jump.<NULL>"

	
	
pushc
newcharmap nasu

INCLUDE "game/constants.asm"

GameBody:
	
	; Silence Net de Get's audio engine...
	ld hl, $6000
	ld de, 0 ; Silence
	call APILoadSong
	ld a, $81
	call APIPlaySong

	; ... so that I can use my own!
	; (As far as I know, this is the only way to have custom music.)
	call InitSound

	; initialize minigame-specific memory
	xor a
	ld hl, $D000
	ld de, $1000
	call Fill

	; My game has few enough unique GFX tiles
	; that they all fit in VRAM at once.
	; So, I just disable the screen and
	; load them all in at the same time.
	call APIDisableLCD
	call APIClearVRAM
	
	xor a
	ld hl, BGPals
	call APISetBGPal ; Set palette 0
	call APISetBGPal ; Set palette 1
	call APISetBGPal ; Set palette 2
	call APISetBGPal ; Set palette 3
	call APISetBGPal ; Set palette 4
	
	xor a
	ld hl, OBPals
	call APISetOBPal ; Set palette 0
	call APISetOBPal ; Set palette 1
	call APISetOBPal ; Set palette 2
	call APISetOBPal ; Set palette 3

	xor a
	ld [rVBK], a
	ld hl, GfxTile
	ld de, $8800
	ld bc, GfxEnd - GfxTile
	call APICopyVRAM

	call APIEnableLCD
	
	; Play silence in my own audio engine, too
	ld bc, Silence_Ptrs
	call PlaySong
	
	
	di
	
	; Set up the MegaSprite table
    ld a, [wMinigameFlashBank]
    ld [wSpriteDataBank], a
    ld a, $08
    ld [wSpriteDataSelect], a
	ld hl, MEGASPRITE_NASU
	call APISetMegaSprites
	
	; Set the interrupt vectors.
	; Don't forget to set these back to 0000
	; before returning from your minigame!
	ld de, VBlank
	call APISetVBlank
	ld de, LCDC
	call APISetLCDC
	ld de, 0
	call APISetTimer
	call APISetSerial
	ei
	

	
	; Load Hi-Score from file
	ld bc, 2
	ld de, GameHeader_GameID
	call APIOpenFile
	
	ld a, [hli]
	ld [wHighScore], a
	ld a, [hl]
	ld [wHighScore+1], a
	
	call APICloseFile
	
	; Set return state to "backed out".
	; this is changed to "game-over-ed" when the player loses,
	; so that backing out of the title screen is not counted
	; as a game over.
	ld a, $10
	ld [wGameReturnState], a
	
	; And now I can render NASU's title screen!
	; Really, this is only still here so that
	; the player has an opportunity to enter
	; the cheat code.
	jp TitleScreen
	
AddATimes:
	or a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
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

StringCopy:
	ld a, [de]
	ld [hl], a
	or a
	ret z
	inc de
	inc hl
	jr StringCopy
	
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

INCLUDE "game/megasprites.asm"

INCLUDE "game/vblank.asm"
INCLUDE "game/hblank.asm"
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
