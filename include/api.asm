
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

; APIInitTextEngine -- 01D4
; 
; Initialize the text engine with default values.
; 
; @param	a	VRAM bank to load graphics into.
APIInitTextEngine::
	jp $269c

; APISetParamStringFunc -- 01D7
; 
; Sets the text engine's parameter-string function to `de`.
; The parameter-string function receives a parameter in `a`,
; and should call APISetTextPointer with the appropriate string
; 
; @param	de	Function pointer
APISetParamStringFunc:: ; 01d7
	jp $271c

; $C219[0..2] = de 
APIFunction2E:: ; 01da
	jp $2723

; APISetTextPointer -- 01DD
; 
; Set the text engine's text pointer to `de`.
; 
; @param	de	String pointer
APISetTextPointer:: ; 01dd
	jp $272a

; APILoadCustomMenuGFX -- 01e0
; 
; Load menu tiles from address `hl` in bank [$C21C][0..2].
; 
; @param	hl	Source
; @param	$C21C	ROM/flash bank number
; @param	$C21D	$00 for ROM, $08 for flash
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

; APISetTextBox -- 01E3
; 
; Set the current text box region.
; 
; @param	de	Pointer to 8-byte entries (X,Y,C,L,T,0,0,0)
; @param	a	Index into `de`
; @param	c	Default height (if `H` is zero)
; @param	X	X coordinate of left border
; @param	Y	Y coordinate of top border
; @param	C	Characters per line
; @param	L	Lines per page
; @param	T	Border type, from [NO_BORDER, NORMAL_SHADOW, FULL_SHADOW]
APISetTextBox:: ; 01e3
	jp $2753
	
; APIOpenTextBox -- 01E6
; 
; Set and clear the current text box.
; 
; @param	de	Pointer to 8-byte entries (X,Y,C,L,T,0,0,0)
; @param	a	Index into `de`
; @param	c	Default height (if `H` is zero)
; 
; @see	APISetTextBox
APIOpenTextBox::
	jp $2799
	
; APISetDialog -- 01E9
; 
; Set the current dialog message to `hl`.
; 
; @param	hl	string pointer
APISetDialog::
	jp $27aa
	
; APIDialogLoop -- 01EC
; 
; Non-blocking loop function to update the current dialog.
; 
; @return	$C1B8	Machine state, from [NO_DIALOG, WRITING, CLEAR, NULL, WAIT]
APIDialogLoop:: ; 01ec
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
	
; APIInitMenu -- 01F2
; 
; Initialize the menu engine using the current text box.
; 
; @param	hl	Pointer to list of null-terminated options
; @param	b	Width of each option
; @param	c	Rows per page
; @param	d	Total number of options
; @param	e	Options per row
APIInitMenu:: ; 01f2
	jp $28e3

; APIDrawMenu2 -- 01F5
; 
; Set [$C213] to 1 and draw the current menu page.
APIDrawMenu2:: ; 01f5
	jp $2945

; APIMenuLoop -- 01F8
; 
; Non-blocking function to handle input for the current menu.
; 
; @return	$C214	Selected option, or $FF if none.
APIMenuLoop:: ; 01f8
	jp $294e
	
; APIDrawTextBox -- 01FB
; 
; Draw the current text box on screen.
; 
; @param	hl	Tilemap/attribute map pointer
APIDrawTextBox:: ; 01fb
	jp $2bfe

; APIFillTextBox -- 01FE
; 
; Fill the current text box with tile number `a`.
; 
; @param	a	Tile number
APIFillTextBox:: ; 01fe
	jp $2d46

; APITextClear -- 0201
; 
; Clear the current text box.
APITextClear:: ; 0201
	jp $2d53

; a = 1 - (([$FF8B] / 4) % 4)
APIFunction3C:: ; 0204
	jp $2dc3

; APIAddTextTriangleSprite -- 0207
; 
; Add a prompt triangle for the current text box to the sprite table.
APIAddTextTriangleSprite:: ; 0207
	jp $2dd0

; APITextSpriteCoordinates -- 020A
; 
; Return the OAM coordinates for the bottom-right corner of the current text box.
; 
; @return	e	X coordinate
; @return	d	Y coordinate
APITextSpriteCoordinates:: ; 020a
	jp $2de7

; APIDrawNextChar -- 020D
; 
; Of the current dialog, draw a character or handle a control code.
; If the character drawn is a dakuten or handakuten, repeat.
APIDrawNextChar:: ; 020d
	jp $2e15

; APITextSpace -- 0210
; 
; Advance the text engine's cursor without writing a character.
APITextSpace:: ; 0210
	jp $2ee9

; APITextLine -- 0213
; 
; Return the text engine's cursor to the beginning of the next line.
APITextLine:: ; 0213
	jp $2efa

; APIDrawChar -- 0216
; 
; Load a character tile and draw it in the current text box.
; 
; @param	a	Character code
; @param	b	X coordinate
; @param	c	Y coordinate
APIDrawChar:: ; 0216
	jp $2f1c

; APITileMapOffset -- 0219
; 
; Return a tilemap/attribute map offset in `hl`.
; 
; @param	b	X coordinate
; @param	c	Y coordinate
; 
; @return	hl	Tilemap offset
APITileMapOffset:: ; 0219
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

; APIDrawMenu -- 021F
; 
; Draw the current menu page.
APIDrawMenu:: ; 021f
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

	

	
; APISetMegaSprites -- 0258
; 
; Set the megasprite array pointer.
; The megasprite array is an array of pointers to megasprites.
; Each megasprite is an array of pointers to frames.
; Each frame consists of a length byte followed by a series of 4-byte entries in OAM format.
; 
; @param	hl	Megasprite array pointer
APISetMegaSprites:: ; 0258
	jp $1186
	
; APIAddSprite -- 025B
; 
; Add an entry to the sprite table.
; 
; @param	e	Y coordinate
; @param	d	X coordinate
; @param	c	Megasprite index, or 0xFF for single tile
; @param	b	Megasprite frame index, or tile number
APIAddSprite:: ; 025b
	jp $118f
	
; APIAddSprite0 -- 025E
; 
; Add an entry to the sprite table.
; 
; @param	e	Y coordinate
; @param	d	X coordinate
; @param	c	Megasprite index, or 0xFF for single tile
; @param	b	Megasprite frame index, or tile number
APIAddSprite0:: ; 025e
	jp $118f
	
; APIDrawSprites -- 0261
; 
; Convert the sprite table to the OAM DMA buffer.
APIDrawSprites:: ; 0261 
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
