
SECTION "API Calls", ROM0[$0150]

; ----- Interrupt functions -----

; APISetVBlank -- 0150
; 
; Sets VBlank interrupt handler.
; Please call with interrupts disabled.
; 
; @param	de	function pointer, or $0000 for none
APISetVBlank::
	jp $0661

; APISetTimer -- 0153
; 
; Sets Timer interrupt handler.
; Please call with interrupts disabled.
; 
; @param	de	function pointer, or $0000 for none
APISetTimer::
	jp $0668

; APISetLCDC -- 0156
; 
; Sets LCDC interrupt handler.
; Please call with interrupts disabled.
; 
; @param	de	function pointer, or $0000 for none
APISetLCDC::
	jp $067d

; APISetSerial -- 0159
; 
; Sets Serial interrupt handler.
; Please call with interrupts disabled.
; 
; @param	de	function pointer, or $0000 for none
APISetSerial::
	jp $0684








; ----- Number printing functions -----





; push hl
; push hl
; hl = de
; c = 100
; call APIDivideWord
; da = hl ; not a typo
; pop hl
; push de
; call APINumString2
; pop af
; call APINumString2
; pop hl
; c = 0
; for b in range(4, 0, b--)
; 	if [hl] == $10
; 		if c
; 			[hl] = $20
; 		endif
; 	else if [hl] == $20
; 		if !c
; 			[hl] = $10
; 		endif
; 	else
; 		c = 1
; 	endif
; 	hl++
; endfor
	
	
	
	
; APINumString4 -- 015C
; 
; Converts a 4-digit value to a printable decimal string.
; Has no error handling, despite it being perfectly possible for
; the input to be 5 digits long.
; 
; @param	de	Value to convert to decimal string. (Valid up to 9999)
; @param	hl	Pointer to end of string being built. (in WRAM)
APINumString4:: ; 015c
	jp $06a6

; push hl
; ld c, 10
; call APIDivideByte
; e = h + $20 ; e =     FLOOR(a / 10)
; a = l       ; a = REMAINDER(a / 10)
; c = 10
; call APIDivideByte
; d = l + $20 ; d = REMAINDER(REMAINDER(a / 10) / 10)
; a = h + $20 ; a =     FLOOR(REMAINDER(a / 10) / 10)
; pop hl
; push hl
; [hl] = d, a, e, ..
; pop hl
; c = 0
; for b in range(2, 0, b--)
;	 if [hl] == $10 and c
; 		[hl] = $20
; 	else if [hl] == $20 and !c
; 		[hl] = $10
; 	else
; 		c = 1
; 	endif
; 	hl++
; endfor

; APINumString3 -- 015F
; 
; Converts a 3-digit value to a printable decimal string.
; Has no error handling, as it's not needed.
; 
; @param	a	Value to convert to decimal string. (Valid up to 255)
; @param	hl	Pointer to end of string being built. (in WRAM)
; 
APINumString3:: ; 015f
	jp $06df

; APINumString2 -- 0162
; 
; Converts a 2-digit value to a printable decimal string.
; Outputs "NG" if value is greater than 99.
; 
; @param	a	Value to convert to decimal string. (Valid up to 99)
; @param	hl	Pointer to end of string being built. (in WRAM)
APINumString2::
	jp $0722

; APINumString1 -- 0165
; 
; Converts a 1-digit value to a printable decimal string.
; Outputs "N" if value is greater than 9
; 
; @param	a	Value to convert to decimal string. (Valid up to 9)
; @param	hl	Pointer to end of string being built. (in WRAM)
APINumString1::
	jp $0747






; ----- LCD functions -----

; APISetLYC -- 0168
; 
; sets rLYC, and configures the STAT interrupt appropriately
; 
; @param	a	value to set rLYC to, or 0 to disable the interrupt
APISetLYC:: ; 0168
	jp $0756

; APIEnableLCD -- 016B
; 
; Clears pending interrupts and sets LCD to default settings.
; 
; rIF = 0 ; clear interrupts
; APISetLYC(0)
; rLCDC = %1100_0011
; - 1 - LCD enabled
; - 1 - Window map = 9C00
; - 0 - Window off
; - 0 - Tile data = 8800
; - 0 - BG map = 9800
; - 0 - 8×8 OBJs
; - 1 - OBJs on
; - 1 - Priority enabled
APIEnableLCD::
	jp $0777

; APIDisableLCD -- 016E
; 
; Safely disables the LCD
APIDisableLCD::
	jp $0782






; ----- Palette functions -----

; APISetBGPal -- 0171
; 
; Sets one BG palette.
; Can be called repeatedly to copy over consecutive
; palette data to consecutive palette indices.
; 
; @param	a	palette # (0-7)
; @param	hl	pointer to 8 bytes of palette data
APISetBGPal::
	jp $0799

; APISetOBPal -- 0174
; 
; Sets one OBJ palette.
; Can be called repeatedly to copy over consecutive
; palette data to consecutive palette indices.
; 
; @param	a	palette # (0-7)
; @param	hl	pointer to 8 bytes of palette data
APISetOBPal::
	jp $07c0

; APIUnpackAllPalettes -- 0177
; 
; Unpacks palette data to wUnpackedPalettes
; 
; [little endian]
; 0bbb_bbgg_gggr_rrrr -> 0000_0bbb_bb00_0000, 0000_0ggg_gg00_0000, 0000_0rrr_rr00_0000
; 
; [wPalUnpackScale] = APIScaleAllPalettes(a)
; 
; @param	a	scale, as index of [0.25, 0.5, 1, 2, 4, 8, 16, 32]
; @param	hl	pointer to packed palette data
APIUnpackAllPalettes:: ; 0177
	jp $07e7

; APIPackAllPalettes -- 017A
; 
; Packs palette data to wIntermediatePals
; [wPalPackScale] = APIScaleAllPalettes(a)
; 
; @param	a	scale, as index of [0.25, 0.5, 1, 2, 4, 8, 16, 32] 
; @param	hl	pointer to unpacked palette data
APIPackAllPalettes:: ; 017a
	jp $0805


; APIApplyAllPalettes -- 017D
; 
; Sets up any palettes that were 
; unpacked by [APIUnpackPalettes] or packed by [APIPackPalettes]
; to be applied during VBlank by [APIUpdatePalettesVBlank].
; 
; Calls [APIResolveAllPalettes] as part of its operation.
; 
; @see	APIUnpackPalettes
; @see	APIUnpackAllPalettes
; @see	APIPackPalettes
; @see	APIPackAllPalettes
; @see	APIUpdatePalettesVBlank
APIApplyAllPalettes:: ; 017d
	jp $0830


; APIScaleAllPalettes -- 0180
; 
; Bit-shifts unpacked palette data at wUnpackedPalettes
; 
; @param	a	Denotes number of bits to shift palettes left by, as index of [-2, -1, 0, 1, 2, 3, 4, 5]
;
; @return	a	Scale value as one of [$80, $40, $20, $10, $08, $04, $02, $01]
APIScaleAllPalettes:: ; 0180
	jp $088d

; APIPackPalettes -- 0183
; 
; Packs c palettes from hl to de
; 
; @param	c	Number of unpacked palettes to process
; @param	hl	Pointer to unpacked palette data
; @param	de	Pointer to packed palette destination
APIPackPalettes:: ; 0183
	jp $08fb

; APIUnpackPalettes -- 0186
; 
; Unpacks c palettes from hl to de
; 
; @param	c	Number of packed palettes to process
; @param	hl	Pointer to packed palette data
; @param	de	Pointer to unpacked palette destination
APIUnpackPalettes:: ; 0186
	jp $0925
	
; APIResolveAllPalettes -- 0189
; 
; @param	hl	Pointer to unresolved palettes
; @param	de	Pointer to palette data destination
APIResolveAllPalettes:: ; 0189
	jp $096f

; APIUpdatePalettesVBlank -- 018C
; 
; Updates palettes from wBGPals and wOBPals,
; only if wPalUpdate set to TRUE.
APIUpdatePalettesVBlank:: ; 018c
	jp $0995






; ----- OAM functions -----

; APILoadOAMDMARoutine -- 018F
; 
; Loads the default OAM DMA routine to $FF80
APILoadOAMDMARoutine::
	jp $09eb

; APIClearOAM -- 0192
; 
; Fills $FE00 through $FEFF with $00
APIClearOAM::
	jp $0a03






; ----- VRAM functions -----

; APIClearVRAM -- 0195
; 
; Fills both banks of VRAM from $8000 through $9FFF with $00,
; while dealing with inaccessibility.
APIClearVRAM::
	jp $0a0e

; APICopyVRAM -- 0198
; 
; Copies data into VRAM,
; while dealing with inaccessibility.
; 
; @param	hl	source
; @param	de	destination
; @param	bc	length
APICopyVRAM::
	jp $0a50

; 
; if h < $60
; 	[$FF9D][0..2] = [$FFAB][0..2]
; 	di
; 	[$27FF][0..2], [$FFAB][0..2], [$C113][0..2] = [$C21C][0..2]
; 	ei
; 	call APICopyVRAM
; 	di
; 	[$27FF][0..2], [$FFAB][0..2], [$C113][0..2] = [$FF9D][0..2]
;	ei
; else
; 	[$FF9D][0..2] = [$FFAD][0..2]
; 	di
; 	[$37FF][0..2], [$FFAD][0..2], [$C115][0..2] = [$C21C][0..2]
; 	ei
; 	call APICopyVRAM
; 	di
; 	[$37FF][0..2], [$FFAD][0..2], [$C115][0..2] = [$FF9D][0..2]
; 	ei
; endif
; 
; @param	hl	source
; @param	de	destination
; @param	bc	length
APIFunction19:: ; 019b
	jp $0a68

; Duplicate of APIFunction19
APIFunction1A:: ; 019e
	jp $0a68

; APIScreenRect -- 01A1
; 
; Copies data into a rectangle of screen space,
; while dealing with inaccessibility.
; 
; @param	b	width
; @param	c	height
; @param	hl	source
; @param	de	destination (probably an address within either tilemap)
APIScreenRect:: ; 01a1
	jp $0ae4

; APIScreenRect -- 01A4
; 
; Copies data into a rectangle of screen space,
; first to bank 0, then to bank 1
; while dealing with inaccessibility.
; 
; @param	b	width
; @param	c	height
; @param	hl	source (tiles, then attributes)
; @param	de	destination (probably an address within either tilemap)
APIScreenRectAttr:: ; 01a4
	jp $0b15

; ?
; looks kinda like APIFunction19
; this code makes my eyes go fuzzy
APIFunction1D:: ; 01a7
	jp $0b5f






; ----- Stubbed functions -----

; APIStub1 -- 01AA
; 
; A single `ret` instruction.
APIStub1::
	jp $0c5c

; APIStub2 -- 01AD
; 
; A single `ret` instruction.
APIStub2::
	jp $0c5d

; APIStub3 -- 01B0
; 
; A single `ret` instruction.
APIStub3::
	jp $0c5e






; ----- Filesystem functions -----


; APIValidateFilesystem -- 01B3
; 
; Checks SRAM filesystem for a valid checksum.
; If it's invalid, attempts to rebuild the filesystem.
; If that fails, deletes the filesystem. (?????)
APIValidateFilesystem::
	jp $0c6a


; APIOpenFile -- 01B6
; 
; Retrieves a pointer to a file with the given name,
; creating that file if necessary.
; 
; Returns an error code if the file's header points to the wrong data, 
; or if the filesystem is out of space for the file.
; 
; @param	bc	Requested file size. (Only used if the file is being created)
; @param	de	Pointer to filename string. (Max. 4 bytes)
;               It is standard to name your game's save file after its game ID.
; 
; @return	b	Return state, from [FOUND_OR_CREATED, ENTRIES_FULL, BAD_FILENAME_OR_NO_SPACE, UNKNOWN_ERROR]
; @return	c	1 if a new file was created, 0 otherwise
; @return	hl and wOpenFileData		Pointer to file data, after block header.
; @return	a  and wOpenFileIndex		File's index, or $FF if none could be found or created.
APIOpenFile::
	jp $0ca5


; APICloseFile -- 01B9
; 
; Fixes open file's checksum,
; and closes SRAM.
APICloseFile::
	jp $0d30


; APIDeleteFile -- 01BC
; 
; Deletes a file from the SRAM filesystem.
; 
; Returns an error code if the file wasn't found,
; OR IF THE FILE IN QUESTION IS CORRUPTED,
; EITHER BY FILENAME, OR BY CHECKSUM.
; 
; This function CANNOT delete a corrupted file.
; For some reason.
; 
; @param	de	Pointer to filename string. (Max. 4 bytes)
; 
; @return	a	Return code, from [0 = OK, -1 = NOT_FOUND, -2 = BAD_FILENAME, -3 = BAD_CHECKSUM].
APIDeleteFile::
	jp $0d50


; APIFileBlockChecksum -- 01BF
; 
; Returns the expected checksum for a given file block.
; 
; @param	a	File index.
; 
; @return	bc	Calculated file checksum.
APIFileBlockChecksum::
	jp $0f15


; APIFileSystemChecksum -- 01C2
; 
; Calculates the expected checksum for the SRAM filesystem,
; and returns whether it matches the stored checksum.
; 
; @return	de		Calculated checksum for file system.
; @return	hl		Stored checksum for file system.
; @return	zflag	Whether these checksums are equal.
APIFileSystemChecksum::
	jp $106d


; APIRebuildFileEntries -- 01C5
; 
; Rebuilds the file entry table (0:A000-0:A30D),
; based on the file block table (0:A30E-1:BFFF)
; 
; @return	a	Number of files processed.
; @return	c	0 if table was rebuilt, 1 if it was already valid.
APIRebuildFileEntries::
	jp $108e


; APIEraseSRAMBank -- 01C8
; 
; Zeroes-out bank `a` of SRAM.
; 
; @param	a	SRAM bank to zero out.
APIEraseSRAMBank::
	jp $113e

; APIGetFileEntry -- 01CB
; 
; Returns pointer to the header of a given file in the SRAM filesystem.
; Strictly speaking, just returns `$A002 + (a*6)` in de.
; 
; @param	a	File index to retrieve.
; 
; @return	de	Pointer to a'th file's entry.
APIGetFileEntry::
	jp $114f


; APIGetFileBlock -- 01CE
; 
; Returns pointer to the block data of a given file in the SRAM filesystem.
; 
; @param	a	File index to retrieve.
; 
; @return	de	Pointer to a'th file's block data.
APIGetFileBlock::
	jp $1162


; APISetOpenFile -- 01D1
; 
; Sets wOpenFile to `ahl` in little-endian.
; Preserves all registers.
; 
; @param	hl	File data pointer (after header).
; @param	a	File index, or $FF if the file doesn't exist.
APISetOpenFile::
	jp $1176






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

; push [$FF4F] & %0000_0001
; [$FF4F] = [$C1AF]
; de = $96C0 ; GFX tile $16C
; bc = $120  ; 18 tiles
; call APIFunction19
; a = [$FF9D]
; de = $8760 ; GFX tile $076
; bc = $00A0 ; 10 tiles
; call APIFunction19
; pop [$FF4F]
; return
APIFunction30:: ; 01e0
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
	
; APIDrawString -- 01ef
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
APIFunction45:: ; 021f
	jp $30bc
APIFunction46:: ; 0222
	jp $3185
APIFunction47:: ; 0225
	jp $2000
APIFunction48:: ; 0228
	jp $200a
APIFunction49:: ; 022b
	jp $2012
APIFunction4A:: ; 022e
	jp $2023
APIFunction4B:: ; 0231
	jp $2035
	
	
; hl = a
; for b in range(8, 0, b--)
; 	hl *= 2
; 	if h >= c
; 		h -= c
; 		l++
; 	endif
; endfor

; APIDivideByte
; 
; Returns `a` / `c` as `h` R `l`.
; 
; @param	a	Dividend
; @param	c	Divisor
; 
; @return	h	Quotient
; @return	l	Remainder
APIDivideByte:: ; 0234
	jp $2046
	
; e = 0
; b = 16
; for b in range(16, 0, b--)
; 	ehl *= 2
; 	if e >= c
; 		e -= c
; 		l++
; 	endif
; endfor
; h = e

; APIDivideWord
; 
; Returns `hl` / `c` as `h` R `l`.
; 
; @param	hl	Dividend
; @param	c	Divisor
; 
; @return	h	Quotient
; @return	l	Remainder
APIDivideWord:: ; 0237
	jp $2057
	
	
APIFunction4E:: ; 023a
	jp $206a
APIFunction4F:: ; 023d
	jp $206c
APIFunction50:: ; 0240
	jp $218f
APIFunction51:: ; 0243
	jp $2198
	
; APILoadSong - 0246
; 
; Loads song data into the audio engine, but doesn't play it.
; 
; @param	de	song id + 0x20
; @param	hl	default audio engine parameters pointer? (usually 0x6000)
; 
; @see		APIPlaySong
APILoadSong::
	jp $21d7

APIFunction53:: ; 0249
	jp $2242

; APIPlaySong -- 024C
; 
; Plays song data last loaded by APILoadSong [0246]
; 
; @param	a	? (usually $81) [goes to $CF80, $C66B, $C665]
; 
; @see		APILoadSong
APIPlaySong::
	jp $22a7
	
; APISilenceAudio -- 024F
; 
; silences all currently playing notes,
; but does NOT stop music from continuing to play
;
; @param	a	? (usually $80) [goes to $CF82]
APISilenceAudio::
	jp $230c
	
; APIStopAudio -- 0252
;
; silences all currently playing notes,
; AND stops music from continuing
APIStopAudio::
	jp $235f
	
	
APIFunction57:: ; 0255
	jp $23cc
	
; 
; 
; 
; 
; # items + 4-byte data table
;  
; 
; 
; 
; [$C1C5->$C1C6] = hl (little endian)
; 
; @param	hl	pointer to table of pointers to tables of pointers to tables of 4-byte values starting with length byte
; 				[G010 has table $01,$57, $75,$59, $83,$59, $00]
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
APIFunction58:: ; 0258
	jp $1186
	
	
APIFunction59:: ; 025b
	jp $118f
APIFunction5A:: ; 025e
	jp $118f
	
	
; 
; 
; clears Shadow OAM?
; 
APIFunction5B:: ; 0261 
	jp $11aa
APIFunction5C:: ; 0264
	jp $23e4
APIFunction5D:: ; 0267
	jp $24b8
APIFunction5E:: ; 026a
	jp $24b9
APIFunction5F:: ; 026d
	jp $254e
APIFunction60:: ; 0270
	jp $25cb
APIFunction61:: ; 0273
	jp $25ef
	
; APICopy
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
	
APIFunction63:: ; 0279
	jp $261c
	
APIFunction64:: ; 027c
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
APIFunction6A:: ; 028e
	jp $16b1
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
APIFunction70:: ; 02a0
	jp $3edc
APIFunction71:: ; 02a3
	jp $3f69
APIFunction72:: ; 02a6
	jp $3f3a
APIFunction73:: ; 02a9
	jp $3f4c
APIFunction74:: ; 02ac
	jp $3f55
APIFunction75:: ; 02af
	jp $3f60
APIFunction76:: ; 02b2
	jp $318a
APIFunction77:: ; 02b5
	jp $3560
	
	
DEF APIOAMDMA EQU $FF80