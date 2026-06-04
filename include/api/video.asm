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

; APIScreenRectAttr -- 01A4
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
