DEF SFX_WALK_ENV equ $51	;%01000001
    
SFX_Walk1:
    db $03
    db $C2, 1
    
    db $C5, SFX_WALK_ENV
    db $C4, %00101111
    db $73, $01
.entry

    db $C5, DEFAULT_ENV
    db $C4, %00000000
    ;db $00, $00
    db $C1
    

SFX_Walk2:
    db $03
    db $C2, 1
    
    db $C5, SFX_WALK_ENV
    db $C4, %00101111
    db $A3, $01

    db $C0
    dw SFX_Walk1.entry

SFX_Land:
    db $03
    db $C2, 1
    
    db $C5, SFX_WALK_ENV
    db $C4, %00101111
    db $B3, $01

    db $C0
    dw SFX_Walk1.entry