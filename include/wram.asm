SECTION "WRAM", WRAM0
wShadowOAM:: ds 4*40 ; $C000

ds $17F

wPalUnpackScale:: db ; C21F
wPalPackScale:: db ; C220
; 1 if palettes to update, 0 otherwise
wPalUpdate:: db ; $C221
wBGPals1:: ds 8*4*2 ; $C222
wOBPals1:: ds 8*4*2
wIntermediatePals:: ds 16*4*2*3 ; $C2A2
wUnpackedPalettes:: ds 8*4*2*3 ; $C422


