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
