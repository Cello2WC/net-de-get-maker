
SECTION "API Calls", ROM0[$0150]

include "include/api/interrupt.asm"
include "include/api/printnum.asm"
include "include/api/lcd.asm"
include "include/api/palette.asm"
include "include/api/oam.asm"
include "include/api/video.asm"
include "include/api/stubbed.asm"
include "include/api/filesystem.asm"
include "include/api/text.asm"
include "include/api/math.asm"
include "include/api/audio.asm"

	

	
; 
; something to do with metasprites i think????
; 
; 
; # items + 4-byte data table
;  
; 
; hl[Sprite?][Frame?][Object][Y,X,T,A]
; 
; [$C1C5->$C1C6] = hl (little endian)
; 
; @param	hl	pointer to table of 11(?) pointers to tables of pointers to tables of 4-byte values starting with length byte
; 				[G010 has table $01,$57, $75,$59, $83,$59, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00, $00,$00]
				; $5701 - $0F,$57, $84,$57, $ED,$57, $56,$58, $AB,$58, $14,$59, $75,$59, $1D,$00
				; $570F - $1D, 
				;         $00, $10, $00, $01, 
				;         $00, $18, $01, $04, 
				;         $00, $20, $02, $01, 
				;         $00, $28, $03, $01,
				;         $08, $00, $04, $01,
				;         $08, $08, $05, $04,
				;         $08, $10, $06, $04,
				;         $08, $18, $07, $04,
				;         $08, $20, $08, $04,
				;         $08, $28, $09, $01,
				;         $10, $00, $0A, $01,
				;         $10, $08, $0B, $04,
				;         $10, $10, $0C, $01,
				;         $10, $18, $0D, $01,
				;         $10, $20, $0E, $01,
				;         $10, $28, $0F, $01,
				;         $18, $08, $10, $00,
				;         $18, $10, $11, $00,
				;         $18, $18, $12, $00,
				;         $18, $20, $13, $00,
				;         $20, $08, $14, $00,
				;         $20, $10, $15, $00,
				;         $20, $18, $16, $00,
				;         $20, $20, $17, $00,
				;         $20, $28, $18, $05,
				;         $28, $10, $19, $00,
				;         $28, $18, $1A, $00,
				;         $28, $20, $1B, $05,
				;         $28, $28, $1C, $05
				; $5784 - $1A,
				;         $00, $28, $1D, $01, 
				;         $08, $08, $1E, $01, 
				;         $08, $10, $1F, $04, 
				;         $08, $18, $20, $04, 
				;         $08, $20, $21, $04, 
				;         $08, $28, $22, $01, 
				;         $10, $00, $23, $01, 
				;         $10, $08, $24, $04, 
				;         $10, $10, $25, $04, 
				;         $10, $18, $26, $01, 
				;         $10, $20, $27, $01, 
				;         $10, $28, $28, $01, 
				;         $18, $08, $29, $00, 
				;         $18, $10, $2A, $00, 
				;         $18, $18, $2B, $00, 
				;         $18, $20, $2C, $00, 
				;         $18, $28, $2D, $01, 
				;         $20, $08, $2E, $00, 
				;         $20, $10, $2F, $00, 
				;         $20, $18, $30, $00, 
				;         $20, $20, $31, $00, 
				;         $20, $28, $32, $05, 
				;         $28, $10, $33, $00, 
				;         $28, $18, $34, $00, 
				;         $28, $20, $35, $05, 
				;         $28, $28, $36, $05
				; ...
				;
				; $5975 - $79,$59,$7E,$59
				; $5979 - $01,
				;         $00,$00,$B4,$00
				; $597E - $01,
				;         $00,$00,$B5,$00
				;
				; $5983 - $87,$59,$B8,$59
				; $5987 - $0C,
				;         $00,$00,$98,$02,
				;         $00,$08,$99,$02,
				;         $00,$10,$9A,$02,
				;         $00,$18,$9B,$02,
				;         $08,$00,$9C,$02,
				;         $08,$18,$9D,$02,
				;         $10,$00,$9E,$02,
				;         $10,$18,$9F,$02,
				;         $18,$00,$A0,$02,
				;         $18,$08,$A1,$02,
				;         $18,$10,$A2,$02,
				;         $18,$18,$A3,$02,
				; $59B8 - $10,
				;         $00,$00,$A4,$02,
				;         $00,$08,$A5,$02,
				;         $00,$10,$A6,$02,
				;         $00,$18,$A7,$02,
				;         $08,$00,$A8,$02,
				;         $08,$08,$A9,$02,
				;         $08,$10,$AA,$02,
				;         $08,$18,$AB,$02,
				;         $10,$00,$AC,$02,
				;         $10,$08,$AD,$02,
				;         $10,$10,$AE,$02,
				;         $10,$18,$AF,$02,
				;         $18,$00,$B0,$02,
				;         $18,$08,$B1,$02,
				;         $18,$10,$B2,$02,
				;         $18,$18,$B3,$02,
				
				
				
				
				
APIFunction58:: ; 0258
	jp $1186
	
; if [$C1C4] >= 16 then return
; [$C1C4]++
; [$C1CA + [$C1C4]*4] = edcb
APIFunction59:: ; 025b
	jp $118f
	
; identical jump ptr to Function59
APIFunction5A:: ; 025e
	jp $118f
	
	
; 
; 
; clears Shadow OAM....
; 
; update sprite engine??? maybe????

; $C000[0..$A0] = 0
; if [$C1C4] != 0 then
;     b = [$C1C4]
;     [$C1C4] = 0
;     di
;     if [$C1C6] < $60 then:
;         [rBankANum ($27FF)], [wBankANumBackup] = [$C21C]
;         [rBankARomFlashSelect ($2800)], [wBankASelectBackup] = [$C21D]
;     else:
;         [rBankBNum ($37FF)], [wBankBNumBackup] = [$C21C]
;         [rBankBRomFlashSelect ($3800)], [wBankBSelectBackup] = [$C21D]
;     end
;     [$C1C7] = $28
;     
;     hl = $C1CA
;     de = $C000
;     while(something):
;         push bc, hl, de
;         [$C1C8][0..2] = hl++++[0..2]
;         if [hl] == $FF
; ...
APIFunction5B:: ; 0261 
	jp $11aa
	
; APIPredef -- 0264
; 
; Call predefined function `a` from the table
; at ROM address 00:05C8.
; 
; Functions are defined in include/constants/predef_constants.asm
; 
; @param	a	Function to call
; @param	b	Swap into Bank A if 0, Bank B if nonzero.
; 				I think this should always be 0?
APIPredef:: ; 0264
	jp $23e4

; APIStub4 -- 0267
; 
; A single `ret` instruction.
APIStub4:: ; 0267
    jp $24b8

; APIFarCall -- 026a
; 
; Call the routine at address `hl` in flash bank `a`.
; The bank is swapped into the appropriate region based on `hl`.
; 
; @param    a    Flash bank to swap in
; @param    hl    Address to call
APIFarCall:: ; 026a
    jp $24b9

; APIStartMiniGame -- 026d
; 
; Start minigame number `a`. $00-$0E are in predefined ROM banks,
; while $10-$8F represent a flash bank + $10.
; In the latter case, the bank number is written to wMinigameFlashBank [$C66C].
; 
; @param    a    Minigame to play
APIStartMiniGame:: ; 026d
    jp $254e

; APIFastModeOn -- 0270
; 
; Enable CPU double-speed mode.
APIFastModeOn:: ; 0270
    jp $25cb

; APIFastModeOff -- 0273
; 
; Disable CPU double-speed mode.
APIFastModeOff:: ; 0273
    jp $25ef
	
; APICopy -- 0276
; 
; Copies data from one location to another.
; Simple as that!
; 
; *(Does nothing about VRAM inaccessibility.
; If you're looking to copy to VRAM, see [APICopyVRAM].)
; 
; **(Does nothing to prepare SRAM to be in the proper state.
; If you're looking to copy to your game's save file,
; see [APIOpenFile] and [APICloseFile] first.)
; 
; @param	hl	Source
; @param	de	Destination
; @param	bc	Length
; 
; @see	APICopyVRAM
; @see	APIOpenFile
; @see	APICloseFile
APICopy:: ; 0276
	jp $2613

; APIJoypadFrameCount -- 0279
; 
; Increments [$FF8B],
; And falls through to APIJoypad.
APIJoypadFrameCount:: ; 0279
	jp $261c
; [$FF00] = $20
; a = [$FF00]
; a = [$FF00]
; cpl
; a &= %0000_1111
; swap a
; b = a
; [$FF00] = $10
; a = [$FF00]
; a = [$FF00]
; a = [$FF00]
; a = [$FF00]
; a = [$FF00]
; a = [$FF00]
; cpl
; a &= %0000_1111
; a |= b
; c = a
; [$FF97] = ([$FF96] ^ c) & c ; pressed inputs this frame
; [$FF96] = c                 ; held inputs this frame
; 
; [$FF00] = $30
; hl = $FF9A
; 
; ; if held inputs from last frame that ??? dont match current held inputs minus start and select
; if [$FF99] != ([$FF96] & %1111_0011)
; 	[hl] = 0
; 	[$FF99] = [$FF96] & %1111_0011  ; held inputs this frame minus start and select
; 	[$FF98] = [$FF97]               ; pressed inputs this frame
; 	[$FF9B] = 1                     ; return value...?
; else
; 	a = ([hl] + 1) & %1001_1111
; 	if !a
; 		a = $80
; 	endif
; 	if (bit 7, a)
; 		a &= %0000_0011
; 		if !a
; 			[$FF98] = [$FF97] | c    ; pressed | held
; 			[$FF9B] = 0              ; return value...?
; 		else
; 			[$FF98] = [$FF97]   ; pressed
; 			[$FF9B] = 1         ; return value...?
; 		endif
; 	else
; 		[$FF98] = [$FF97]   ; pressed
; 		[$FF9B] = 1         ; return value...?
; 	endif
; endif
; 
; 
	
APIJoypad:: ; 027c
	jp $2620
APIFunction65:: ; 027f
	jp $2685
	
	
	
	
APIFunction66:: ; 0282
	jp $1663
APIFunction67:: ; 0285
	jp $1675
APIFunction68:: ; 0288
	jp $1689
APIFunction69:: ; 028b
	jp $169d
	
; fills 50 (0x32) bytes from wC700 with 00
APIFunction6A:: ; 028e
	jp $16b1
	
; di
; [$C63A] = a
; push de
; de = $C649
; call Function1783 ; back up bank A to de, swap bank A to 0x16
; pop de
; call 16:4312
; de = $C649
; call Function179F ; restore bank A from de
; ei
; ret
APIFunction6B:: ; 0291
	jp $16bf
APIFunction6C:: ; 0294
	jp $16d6

; APIDoMenu -- 0297
; 
; Draws a menu with origin at the top-left of the screen,
; and handles input for this menu.
; 
; @param	hl		pointer to list of null-terminated options (max 9 char each)
; @param	a		same as c?????
; @param	c		num options
; 
; @return	$C214	selected option, or FF if backed out.
APIDoMenu::
	jp $16ed
	
	
APIFunction6E:: ; 029a
	jp $172d
APIFunction6F:: ; 029d
	jp $176f
	
	
; Temporarily disables VBlank handler,
; Calls 10:4E90,
; and re-enables the VBlank handler.	

; 10:4E90 --
; jp ([$C67E] * 2) + $4EA2

; 10:4EA2
; $516C
; $50BA
; $4FD6
; $5639
; $568B
; $51FE
; $5334
; $545B
; $5472
; $4FB3
; $4F32
; $4EC0
; $55AA
; $54EC
; $52F8
	
APIFunction70:: ; 02a0
	jp $3edc
APIFunction71:: ; 02a3
	jp $3f69
	
	
; Calls APIFunction70's 5th function (10:51FE)
APIFunction72:: ; 02a6
	jp $3f3a
	
; Calls APIFunction70's 6th function (10:5334)

; 10:5334 --
; 
; [$C866][0..2] = de
; [$C86A][0..2] = bc
; [$C864][0..2] = [$FFAD][0..2]
; [$C870] = [$FFAE] | [$FFAC]
; 
; b = $0F
; hl = $3CD8 ; [$3CD8] = $54
; do {
;     e = [hl++]
;     d = 0
;     call Function35D7 ; swap bank B to num `e`, select `d`
;     push hl
;     [$C862] = e
;     hl = $600D ; maybe GameHeader_Unk2?
;     de = [$C866][0..2]
;     c = 2
;     call Function5599 ; compare `c` bytes between `de` and `hl`. [$C862] = $FF if they're not equal
;     pop hl
;     
;     if [$C862] != $FF:
;         de = [$C86A][0..2]
;         [de++] = $0F - b
;         [$C86A][0..2] = de
; } while(--b != 0)
; 
; with open('SYS1'):
;     [$C863] = [SYS1:007]
; 
; [$C868] = swap([$C863])
; [$C862] = $FF
; 
; 
APIFindAppendMiniGames:: ; 02a9
	jp $3f4c

; Calls APIFunction70's 7th function (10:545B)
; 
; @return	d	Bank ROM/Flash select for this minigame
; @return	e	Bank number for this minigame
APIGetMiniGameBankDuplicate:: ; 02ac
	jp $3f55
	
; Calls APIFunction70's 8th function (10:5472)
APIFarCopy:: ; 02af
	jp $3f60
	
APIFunction76:: ; 02b2
	jp $318a
APIFunction77:: ; 02b5
	jp $3560