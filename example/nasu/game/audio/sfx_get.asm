SFX_Get:
    db $02
    db $C2, 2
    db $C5, DEFAULT_ENV
    db $C3, 60

    db $44, $00
    db $74, $00
    db $B4, $00
    db $05, $00
    db $25, $00
    db $45, $00

    db $00, $00
    db $C3, 0
    db $C1