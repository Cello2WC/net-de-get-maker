
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
; 
; It's literally just:
; pop hl
; pop de
; pop bc
; pop af
; ret
APIPopReturn:: ; 0222
	jp $3185

include "include/api/math.asm"
include "include/api/audio.asm"
include "include/api/sprites.asm"

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

; APISkillPoint -- 029d
; 
; Give the player the specified number of points in each skill.
; 
; @param	a	Minigame number
; @param	$C84B	Reflex points
; @param	$C84C	Intelligence points
; @param	$C84D	Sense points
; @param	$C84E	Hidden points (global)
; @param	$C84F	Hidden points (this minigame)
; 
; @note	If this is one of the last 8 minigames played, $C84E is skipped.
APISkillPoint:: ; 029d
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
	
; [$C212] = max(a, [$C20F] - 1) / ([$C20E] * [$C20D])
; [$C215] = max(a, [$C20F] - 1) / ([$C20E] * [$C20D])
; [$C21B] = (max(a, [$C20F] - 1) % ([$C20E] * [$C20D])) % [$C210]
; [$C214] = (max(a, [$C20F] - 1) % ([$C20E] * [$C20D])) / [$C210]
; [$C216] = (max(a, [$C20F] - 1) % ([$C20E] * [$C20D])) / [$C210]
APIFunction76:: ; 02b2
	jp $318a

; APIMobile -- 02b5
; 
; Call a function from the mobile adapter API.
; 
; @param	a	Function index
APIMobile:: ; 02b5
	jp $3560
