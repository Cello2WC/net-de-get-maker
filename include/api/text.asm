; ----- Text functions -----

; APIInitTextEngine -- 01D4
; 
; Initialize the text engine with default values.
; 
; @param	a	VRAM bank to load text graphics into.
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
; Position is offset from last text box drawn with APISetTextBox [01E3]
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
; $FF8B is the global timer. Is this for blinking the prompt triangle?
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
