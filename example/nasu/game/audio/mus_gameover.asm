GameOverSong_Ptrs:
    dw GameOverSong_Ch1
    dw GameOverSong_Ch2
    dw $0000
    dw $0000
    db 21

GameOverSong_Ch1:
    db $C5, DEFAULT_ENV
    db $C2, 2
    db $22, $03
    db $42, $03
    db $72, $01
    db $92, $01
    db $22, $03
    db $00, $00
    db $C1;0, $00, $00

GameOverSong_Ch2:
    db $C5, DEFAULT_ENV
    db $C2, 2
    db $23, $01
    db $43, $00
    db $63, $00
    db $73, $01
    db $63, $00
    db $73, $00
    db $B3, $00
    db $93, $00
    db $B3, $00
    db $14, $00
    db $24, $03
    db $00, $00
    db $C1;0, $00, $00
