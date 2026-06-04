; ----- Number printing functions -----
		
	
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
