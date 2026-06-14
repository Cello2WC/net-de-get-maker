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
