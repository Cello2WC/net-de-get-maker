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
