SFX_Lose:
    db $01
    db $C5, DEFAULT_ENV
    db $C2, 0
    
    db $31, $01
    
    db $12, $00
    db $C4, %00011111
    db $12, $07

    db $C4, %00000000
    
    db $00, $00
    db $C1