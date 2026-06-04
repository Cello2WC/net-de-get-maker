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
