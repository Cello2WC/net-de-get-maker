
SECTION "API Calls", ROM0[$0150]

include "include/api/interrupt.asm"
include "include/api/printnum.asm"
include "include/api/lcd.asm"
include "include/api/palette.asm"
include "include/api/oam.asm"
include "include/api/video.asm"
include "include/api/stubbed.asm"
include "include/api/filesystem.asm"















; ----- Text functions -----




; [$C1AF] = a
; [$C1C2] = 0
; [$C1C0] = 0
; [$C1C1] = 0
; [$C219][0..2] = 0
; hl = $C1B5
; [hl][0..2] = $9800
; a = [$FF4F] & %0000_0001 ; vram bank
; push af
; [$FF4F] = [$C1AF]
; [$C1A3] = [$C1AF] ? 7 | %0000_1000 : 7
; [$C1B0] = [$C1AF] ? 0 | %0000_1000 : 0
; [$C1B1] = [$C1AF] ? 1 | %0000_1000 : 1
; [$C1B2] = [$C1AF] ? 2 | %0000_1000 : 2
; [$C1B7] = [$C1AF] ? 0 | %0000_1000 : 0
; hl = $4EE0
; de = $97E0 ; GFX tile $17E
; bc = $0020 ; 2 tiles
; call APICopyVRAM
; [$C1BF] = 0
; pop af
; [$FF4F] = a
; return

; APILoadDakutenGFX -- 01D4
; 
; Loads GFX for the " ﾞ" and " ﾟ" characters into tiles $7E and $7F of the given VRAM bank
; 
; @param	a	VRAM bank to load graphics into.
APILoadDakutenGFX::
	jp $269c

; $C1C0[0..2] = de
APIFunction2D:: ; 01d7
	jp $271c

; $C219[0..2] = de 
APIFunction2E:: ; 01da
	jp $2723

; $C1AB[0..2] = de 
APIFunction2F:: ; 01dd
	jp $272a

; APILoadCustomMenuGFX -- 01e0
; 
; Load menu tiles from address `hl` in bank [$C21C][0..2].
; 
; @param	hl	Source
APILoadCustomMenuGFX:: ; 01e0
	jp $2731

; hl = de + (a*8)
; [$FF9E] = c
; a = [hl++]
; b = a
; [$C1A4] = ++a
; a = [hl++]
; c = a
; [$C1A7] = ++++a
; push hl
; call APIFunction43
; de = hl + $C1B5[0..2]
; pop hl
; c = [$FF9E]
; [$C1A8] = [hl++]
; a = [hl++]
; if !a
; 	a = c
; endif
; [$C1A9] = a
; [$C1AA] = [hl++]
; [$C1A5][0..2] = de
; hl = de
; return [$C1AA]?
APIFunction31:: ; 01e3
	jp $2753
	
; APITextBox -- 01E6
; 
; Clears a region of the screen, and designates 
; that region as the active Text Box.
; 
; @param	de	pointer to table of 4-byte (x,y,w,h) entries
; @param	a	table index
; @param	c	? (goes to $FF9E)
APITextBox::
	jp $2799
	
; APIScrollText -- 01E9
; 
; ? (untested)
; 
; @param	hl	string pointer
APIScrollText::
	jp $27aa
	
APIFunction34:: ; 01ec
	jp $27c1
	
; APIDrawString -- 01EF
; 
; Prints a string to the screen instantly (no scrolling)
; Position is offset from last text box drawn with APITextBox [01E6]
; 
; @param	hl	string pointer
; @param	b	x offset from text box
; @param	c	y offset from text box
; 
; @see		APITextBox
APIDrawString::
	jp $28be
	
	
APIFunction36:: ; 01f2
	jp $28e3
APIFunction37:: ; 01f5
	jp $2945
APIFunction38:: ; 01f8
	jp $294e
	
	
	
APIFunction39:: ; 01fb
	jp $2bfe
APIFunction3A:: ; 01fe
	jp $2d46
APIFunction3B:: ; 0201
	jp $2d53
APIFunction3C:: ; 0204
	jp $2dc3
APIFunction3D:: ; 0207
	jp $2dd0
APIFunction3E:: ; 020a
	jp $2de7
APIFunction3F:: ; 020d
	jp $2e15
APIFunction40:: ; 0210
	jp $2ee9
APIFunction41:: ; 0213
	jp $2efa
APIFunction42:: ; 0216
	jp $2f1c
APIFunction43:: ; 0219
	jp $2fe0
APIFunction44:: ; 021c
	jp $3031
	
	
; push af
; push bc
; push de
; push hl
; call APIFunction3B
; hl = $C20A[0..2]
; e = ([$C20E] * [$C212]) * [$C210]
; a = 0
; while(True) {
; 	push af
; 	if a < e
; 		do {
; 			while (a = [hl++]) != 0 {}
; 			a = hl[-2]
; 		} while (a == 2)
; 		pop af
; 		a++
; 		continue
; 	else
; 		pop af
; 		push [$C1BD]
; 		[$C1BD] = [$C20E]
; 		d = 0
; 		push [$C1BD]
; 		push de
; 		e = ([$C212] * (([$C20E] - [$C1BD]) <<c 1) + (([$C20E] - [$C1BD]) <<c 1)) >> 1
; 		
; 		
; 		
; 	endif
; }
APIFunction45:: ; 021f
	jp $30bc
	
	
; pop hl
; pop de
; pop bc
; pop af
; ret

; APIPopReturn -- 0222
; 
; Pops all registers and returns.
; You probably want to `jp` to this!
; 
; Registers are popped in the order of hl, de, bc, af.
; So, to use this, you'd want to start your function with:
; ```
; push af
; push bc
; push de
; push hl
; ```
; and end it with:
; ```
; jp APIPopReturn
; ```
APIPopReturn:: ; 0222
	jp $3185





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
; clears Shadow OAM?

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

; APIGetMiniGameBank -- 027f
; 
; Load the bank number for minigame `a` in `e`,
; and the flash flag ($00 or $08) in `d`.
; 
; @param	a	Minigame number
; 
; @return	d	$00 for ROM, $08 for flash
; @return	e	ROM/flash bank number for minigame
APIGetMiniGameBank:: ; 027f
	jp $2685

; APILoadDefaultMenuGFX -- 0282
; 
; Load the default menu graphics.
; 
; @see APILoadDakutenGFX
; @see APILoadCustomMenuGFX
APILoadDefaultMenuGFX:: ; 0282
	jp $1663

; APIRebuildSysFiles -- 0285
; 
; Create SYS0 and SYS1 if they don't already exist,
; and reinitialize SYS1, but not SYS0 due to a bug.
; Due to the same bug, which WRAM bank is loaded after
; this function returns is undefined.
; 
; @return	a	Return state, from [OK, VALIDATE_FS_FAILED, OPEN_FILE_FAILED]
APIRebuildSysFiles:: ; 0285
	jp $1675

; APILoadSys0 -- 0288
; 
; Copy the contents of SYS0 to $C700.
; 
; @return	a	Return state, from [OK, OPEN_FILE_FAILED]
APILoadSys0:: ; 0288
	jp $1689

; APIWriteSys0 -- 028b
; 
; Copy data from $C700 to SYS0.
; 
; @return	a	Return state, from [OK, OPEN_FILE_FAILED]
APIWriteSys0:: ; 028b
	jp $169d

; APIClearSys0 -- 028e
; 
; Zero out 50 bytes (the size of SYS0) at $C700.
APIClearSys0:: ; 028e
	jp $16b1

; APIReadTiles -- 0291
; 
; Read the specified rectangle of tilemap and attribute data to `de`.
; [$C63A] bit 7 specifies which tilemap to copy from,
; while [$C63A] bits 0-2 specify which WRAM bank to load.
; 
; @param	b	left x coordinate
; @param	c	top y coordinate
; @param	h	width
; @param	l	height
; @param	de	destination
APIReadTiles:: ; 0291
	jp $16bf

; APIWriteTiles -- 0294
; 
; Write the specified rectangle of tilemap and attribute data from `de`.
; [$C63A] bit 7 specifies which tilemap to copy from,
; while [$C63A] bits 0-2 specify which WRAM bank to load.
; 
; @param	b	left x coordinate
; @param	c	top y coordinate
; @param	h	width
; @param	l	height
; @param	de	source
APIWriteTiles:: ; 0294
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
	
; APITryCreateFile -- 029a
; 
; Try to create a file with the given name and size.
; If it doesn't exist and can't be created,
; display a warning and ask the player if they want to continue anyway.
; 
; @param	bc	Requested file size
; @param	de	Pointer to filename string
; 
; @return	b	Return state, from [OK, WARNING_YES, WARNING_NO]
APITryCreateFile:: ; 029a
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

; APICopyStringFillNumber -- 02a3
; 
; Copy a string from `de` to `hl`,
; replacing any $FF bytes with digits from the number in `bc`.
; 
; @param	a	Number of digits - 1
; @param	bc	Number to insert
; @param	de	Source
; @param	hl	Destination
APICopyStringFillNumber:: ; 02a3
	jp $3f69
	
; APIFindMiniGame -- 02a6
; 
; Find the minigame with the ID pointed to by `de`,
; returning its number in `a`, or $FF if not found.
; 
; @param	de	Pointer to minigame ID
; 
; @return	a	Minigame number (or $FF)
APIFindMiniGame:: ; 02a6
	jp $3f3a
	
; APIFindAppendMiniGames -- 02a9
; 
; Find all minigames whose two-byte append IDs match the one pointed
; to by `de`, write their numbers at `bc`, and return a count in `b`.
; 
; @param	bc	Pointer to array buffer
; @param	de	Pointer to append ID
; 
; @return	b	Number of minigames found
APIFindAppendMiniGames:: ; 02a9
	jp $3f4c

; APIGetMiniGameBank0 -- 02ac
; 
; Same as APIGetMiniGameBank.
; 
; @param	a	Minigame number
; 
; @return	d	$00 for ROM, $08 for flash
; @return	e	ROM/flash bank number for minigame
; 
; @see	APIGetMiniGameBank
APIGetMiniGameBank0:: ; 02ac
	jp $3f55
	
; APICopyFar -- 02af
; 
; Swap in ROM/flash bank `de`, then copy `bc` bytes
; from the pointer at [$C862] to the pointer at [$C864].
; 
; @param	bc	Length
; @param	d	Source: $00 for ROM, $08 for flash
; @param	e	Source: ROM/flash bank number
; 
; @note	The source bank is always swapped into bank B,
;      	but a source address in bank A will be corrected.
APICopyFar:: ; 02af
	jp $3f60
	
; [$C212] = max(a, [$C20F] - 1) % ([$C20E] * [$C20D])
; [$C215] = max(a, [$C20F] - 1) % ([$C20E] * [$C20D])
; [$C21B] = (max(a, [$C20F] - 1) / ([$C20E] * [$C20D])) / [$C210]
; [$C214] = (max(a, [$C20F] - 1) / ([$C20E] * [$C20D])) % [$C210]
; [$C216] = (max(a, [$C20F] - 1) / ([$C20E] * [$C20D])) % [$C210]
APIFunction76:: ; 02b2
	jp $318a

; APIMobile -- 02b5
; 
; Call a function from the mobile adapter API.
; 
; @param	a	Function index
APIMobile:: ; 02b5
	jp $3560
