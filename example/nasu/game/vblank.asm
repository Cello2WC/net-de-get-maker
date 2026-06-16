VBlank:
    call hAPIOAMDMA
    jp APIJoypadFrameCount
    
    ; For some reason, I end up with flickering sprites when
    ; I try to update the sound engine in the VBlank handler...
    
;    call UpdateSFX
;    call UpdateMusic
;    ret



WaitOneFrame:
    ; Since I'm already waiting around, I
    ; might as well update the sound engine!
    push bc
    call UpdateSFX
    call UpdateMusic
    pop bc

    halt
    nop

.delayLoop
    ldh a, [hVBlankFlag]
    and a
    jr z, .delayLoop

    xor a
    ldh [hVBlankFlag], a
    ret

WaitAFrames:
    ld b, a
WaitBFrames:
.loop
    call WaitOneFrame
    dec b
    jr nz, .loop
    ret
