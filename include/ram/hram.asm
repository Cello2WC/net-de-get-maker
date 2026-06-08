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

hFF9C:: db ; $FF9C

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

hFFAF:: db ; $FFAF

hFFB0:: db ; $FFB0
hFFB1:: db ; $FFB1
hFFB2:: db ; $FFB2
hFFB3:: db ; $FFB3
hFFB4:: db ; $FFB4
hFFB5:: db ; $FFB5
hFFB6:: db ; $FFB6
hFFB7:: db ; $FFB7
hFFB8:: db ; $FFB8
hFFB9:: db ; $FFB9
hFFBA:: db ; $FFBA
hFFBB:: db ; $FFBB
hFFBC:: db ; $FFBC
hFFBD:: db ; $FFBD
hFFBE:: db ; $FFBE
hFFBF:: db ; $FFBF

hFFC0:: db ; $FFC0
hFFC1:: db ; $FFC1
hFFC2:: db ; $FFC2
hFFC3:: db ; $FFC3
hFFC4:: db ; $FFC4
hFFC5:: db ; $FFC5
hFFC6:: db ; $FFC6
hFFC7:: db ; $FFC7
hFFC8:: db ; $FFC8
hFFC9:: db ; $FFC9
hFFCA:: db ; $FFCA
hFFCB:: db ; $FFCB
hFFCC:: db ; $FFCC
hFFCD:: db ; $FFCD
hFFCE:: db ; $FFCE
hFFCF:: db ; $FFCF

hFFD0:: db ; $FFD0
hFFD1:: db ; $FFD1
hFFD2:: db ; $FFD2
hFFD3:: db ; $FFD3
hFFD4:: db ; $FFD4
hFFD5:: db ; $FFD5
hFFD6:: db ; $FFD6
hFFD7:: db ; $FFD7
hFFD8:: db ; $FFD8
hFFD9:: db ; $FFD9
hFFDA:: db ; $FFDA
hFFDB:: db ; $FFDB
hFFDC:: db ; $FFDC
hFFDD:: db ; $FFDD
hFFDE:: db ; $FFDE
hFFDF:: db ; $FFDF

hFFE0:: db ; $FFE0
hFFE1:: db ; $FFE1
hFFE2:: db ; $FFE2
hFFE3:: db ; $FFE3
hFFE4:: db ; $FFE4
hFFE5:: db ; $FFE5
hFFE6:: db ; $FFE6
hFFE7:: db ; $FFE7
hFFE8:: db ; $FFE8
hFFE9:: db ; $FFE9
hFFEA:: db ; $FFEA
hFFEB:: db ; $FFEB
hFFEC:: db ; $FFEC
hFFED:: db ; $FFED
hFFEE:: db ; $FFEE
hFFEF:: db ; $FFEF

hFFF0:: db ; $FFF0
hFFF1:: db ; $FFF1
hFFF2:: db ; $FFF2
hFFF3:: db ; $FFF3
hFFF4:: db ; $FFF4
hFFF5:: db ; $FFF5
hFFF6:: db ; $FFF6
hFFF7:: db ; $FFF7
hFFF8:: db ; $FFF8
hFFF9:: db ; $FFF9
hFFFA:: db ; $FFFA
hFFFB:: db ; $FFFB
hFFFC:: db ; $FFFC
hFFFD:: db ; $FFFD
hFFFE:: db ; $FFFE

