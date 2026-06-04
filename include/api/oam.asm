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
