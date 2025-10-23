SFX_Jump:
    db $08 ; $03
    db $C2, 2
    db $C5, $A1
    db $C3, 0
    
    
    db $C4, %00100110	;%00010111
    db $53, $00

    db $C5, DEFAULT_ENV
    db $C4, %00000000
    ;db $00, $00
    db $C1