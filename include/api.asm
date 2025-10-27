
SECTION "API Calls", ROM0[$0150]

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

; 
; ld a, [$C747]
; ld e, a
; ld a, [$C748]
; ld d, a
; ld hl, $C655
; call $015C
;
; ld a, [$C745]
; ld e, a
; ld a, [$C746]
; ld d, a
; ld hl, $C655
; call $015C
; 
; 
; @param	de	? 
; @param	hl	? [$c655 in both calls present in base game]
APIFunction04:: ; 015c
	jp $06a6

; ?
APIFunction05:: ; 015f
	jp $06df

; APINumString -- 0162
; 
; Converts a byte to a printable decimal string.
; Outputs "NG" if number is greater than 99.
; 
; (calls $2046 to handle conversion. this function seems to be able to handle other bases?)
; 
; @param	a	number to convert to decimal string (up to 99)
; @param	hl	pointer to end of string being built (probably in WRAM)
APINumString::
	jp $0722

; APIDigitString -- 0165
; 
; Converts a digit to a printable decimal character.
; Outputs "N" if digit is greater than 9
; 
; @param	a	digit to convert to decimal char (up to 9)
; @param	hl	pointer to end of string being build (probably in WRAM)
APIDigitString::
	jp $0747

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

; 
; 
; [$0000] = $0A
; [$0400] = $00
; [$0800] = $01
; a = 0
; if APIFunction26()
; 	call APIFunction27
; 	bc = ca
;	f = a?
;	a = 2
;	if !f, 
;		a = 1
;		call APIFunction28
;		a = 0
;		call APIFunction28
;		a = 1
;	endif
; endif
; [$0400] = [$FFAF]
; [$0800] = [$FFB0]
; [$0000] = 0
; 
; 	
; 
; 
APIFunction21:: ; 01b3
	jp $0c6a

; with all 00 args: 
APIFunction22:: ; 01b6
	jp $0ca5

; with all 00 args: 
APIFunction23:: ; 01b9
	jp $0d30

; with all 00 args: 
APIFunction24:: ; 01bc
	jp $0d50

; with all 00 args: 
APIFunction25:: ; 01bf
	jp $0f15

; with all 00 args: 
APIFunction26:: ; 01c2
	jp $106d

; with all 00 args: 
APIFunction27:: ; 01c5
	jp $108e

; with all 00 args: 
APIFunction28:: ; 01c8
	jp $113e

; with all 00 args: 
APIFunction29:: ; 01cb
	jp $114f

; with all 00 args: 
APIFunction2A:: ; 01ce
	jp $1162

; with all 00 args: 
APIFunction2B:: ; 01d1
	jp $1176

; with all 00 args: 
APIFunction2C:: ; 01d4
	jp $269c

; with all 00 args: 
APIFunction2D:: ; 01d7
	jp $271c

; with all 00 args: 
APIFunction2E:: ; 01da
	jp $2723

; with all 00 args: 
APIFunction2F:: ; 01dd
	jp $272a

; with all 00 args: 
APIFunction30:: ; 01e0
	jp $2731

; with all 00 args: 
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
APIFunction4C:: ; 0234
	jp $2046
APIFunction4D:: ; 0237
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
; [$C1C5->$C1C6] = hl (little endian)
; 
; @param	hl	pointer to table of pointers to tables of pointers to # items + 4-byte data table
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
APIFunction62:: ; 0276
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