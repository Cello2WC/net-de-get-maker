GamePlaySong_Ptrs:
    dw $0000
    dw GamePlaySong
    dw $0000
    dw $0000
    db 16

GamePlaySong:
    db $C2, 2
    db $C5, DEFAULT_ENV
.loop
    db $02, $00
    db $00, $00
    db $43, $00
    db $73, $00
    db $00, $03
    db $42, $00
    db $00, $00
    db $43, $00
    db $73, $00
    db $00, $03
    db $C0
    dw GamePlaySong.loop