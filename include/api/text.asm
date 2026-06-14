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
; Initializes text engine variables, and
; loads GFX for the " ﾞ" and " ﾟ" characters 
; into tiles $7E and $7F of the given VRAM bank
; 
; @param	a	VRAM bank to load text graphics into.
APIInitTextEngine:: ; 01d4
	jp $269c

; $C1C0[0..2] = de

; APISetTextFunction -- 01D7
; 
; Sets `wTextFunctionPointer` to `de`.
; 
; @param	de	Function pointer
APISetTextFunction:: ; 01d7
	jp $271c

; $C219[0..2] = de 

; APIFunction2E -- 01DA
; 
; Sets `C219` & `C21A` to `de`.
; 
; @param	de	Unknown callback address
APIFunction2E:: ; 01da
	jp $2723

; $C1AB[0..2] = de 

; APISetNextCharPointer -- 01DD
; 
; Sets `wNextCharPointer` to `de`.
; 
; @param	de	Character pointer
APISetNextCharPointer:: ; 01dd
	jp $272a

; push [$FF4F] & %0000_0001
; [$FF4F] = [$C1AF]
; de = $96C0 ; GFX tile $16C
; bc = $120  ; 18 tiles
; call APICopyVRAMFar
; a = [$FF9D]
; de = $8760 ; GFX tile $076
; bc = $00A0 ; 10 tiles
; call APICopyVRAMFar
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
; 

; APITextRegion -- 01E3
; 
; Designates a region of the screen 
; as the active Text Region.
; 
; @param	de	pointer to table of 8-byte (x,y,w,h,border,?,?,?) entries
; @param	a	table index
; @param	c	? (goes to $FF9E (hBankSelect?)) 
APITextRegion:: ; 01e3
	jp $2753
	
; APITextBox -- 01E6
; 
; Designates a region of the screen 
; as the active Text Region,
; and draws a box around that region.
; 
; Calls APITextRegion as part of its operation (to designate the region)
; Calls either APIFunction39 or APIFunction3B as part of its operation (to draw the border)
; 
; @param	de	pointer to table of 8-byte (x,y,w,h,border,?,?,?) entries
; @param	a	table index
; @param	c	? (goes to $FF9E (hBankSelect?)) 
; 
; @see		APITextRegion
APITextBox:: ; 01e6
	jp $2799
	
; APIScrollText -- 01E9
; 
; Sets the current scrolling text to that pointed to by `hl`.
; 
; You can know that the text is done being read
; when wTextCond is equal to 0.
; 
; @param	hl	string pointer
APIScrollText::
	jp $27aa
	
; APIUpdateTextEngine -- 01EC
; 
; To be called once per frame in order to display scrolling text.
APIUpdateTextEngine::
	jp $27c1
	
; APIDrawString -- 01EF
; 
; Prints a string to the screen instantly (no scrolling)
; Position is offset from last text box drawn with APITextRegion [01E3]
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
APIMenuLoop:: ; 01f8
	jp $294e
	
	

APIFunction39:: ; 01fb
	jp $2bfe
APIFunction3A:: ; 01fe
	jp $2d46
	

APIClearTextField:: ; 0201
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

