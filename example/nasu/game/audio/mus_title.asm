TitleSong_Ptrs:
    dw TitleSong_Ch2
    dw TitleSong_Ch1
    dw $0000
    dw $0000
    db 19

TitleSong_Ch1:
    db $C2, 2
    db $C5, DEFAULT_ENV
.loop
    db $03, $03
    db $53, $03
    db $73, $03
    db $53, $03
    db $03, $03
    db $53, $03
    db $73, $01
    db $23, $01
    db $03, $03
    db $C0
    dw TitleSong_Ch1.loop

TitleSong_Ch2:
    db $C2, 2
    db $C5, DEFAULT_ENV
.loop
    db $C3, 1
    db $00, $00
    db $44, $00
    db $24, $00
    db $44, $00
    db $C3, 0
    db $54, $01
    db $C3, 1
    db $44, $00
    db $24, $00
    db $C3, 0
    db $04, $00
    db $B3, $00
    db $04, $00
    db $C3, 1
    db $24, $00
    db $C3, 0
    db $04, $01
    db $C3, 1
    db $B3, $00
    db $04, $00

    db $00, $00
    db $44, $00
    db $24, $00
    db $44, $00
    db $C3, 0
    db $54, $01
    db $C3, 1
    db $44, $00
    db $24, $00
    db $C3, 0
    db $04, $00
    db $C3, 1
    db $B3, $00
    db $C3, 0
    db $04, $00
    db $C3, 1
    db $24, $00
    db $C3, 0
    db $04, $03
    db $C0
    dw TitleSong_Ch2.loop