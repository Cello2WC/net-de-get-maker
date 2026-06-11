SECTION "HRAM", HRAM
hAPIOAMDMA:: ds 10 ; $FF80

hFF8A:: db ; $FF8A
hGlobalTimer:: db ; $FF8B: Incremented by APIJoypadFrameCount, read by APIRandom
hFF8C:: db ; $FF8C
hFF8D:: db ; $FF8D
hFF8E:: db ; $FF8E
hFF8F:: db ; $FF8F

hFF90:: db ; $FF90
hFF91:: db ; $FF91
hFF92:: db ; $FF92
hFF93:: db ; $FF93
hFF94:: db ; $FF94
hFF95:: db ; $FF95

hJoyDown::    db ; $FF96: Held inputs this frame
hJoyPressed:: db ; $FF97: Inputs newly pressed this frame
hJoypad::     db ; $FF98: ???
hJoyCheck::   db ; $FF99: Checks for change in input minus Start and Select???
hJoyCount::   db ; $FF9A: ???
hJoyType::    db ; $FF9B: 0 or 1 depending on joypad changes(?)

hCGB:: db ; $FF9C: 0 if DMG, MGB, or SGB. 1 if CGB or AGB

hBankNum::    db ; $FF9D
hBankSelect:: db ; $FF9E

hFF9F:: db ; $FF9F
hFFA0:: db ; $FFA0
hFFA1:: db ; $FFA1
hFFA2:: db ; $FFA2
hFFA3:: db ; $FFA3
hFFA4:: db ; $FFA4
hFFA5:: db ; $FFA5
hFFA6:: db ; $FFA6

hRandomAdd:: db ; $FFA7
hRandomSub:: db ; $FFA8

hFFA9:: db ; $FFA9
hFFAA:: db ; $FFAA

hBankANum::    db ; $FFAB
hBankASelect:: db ; $FFAC
hBankBNum::    db ; $FFAD
hBankBSelect:: db ; $FFAE

hStackBottom:: ds $50 - 1 ; $FFAF
hStackTop::    ds 1       ; $FFFE

