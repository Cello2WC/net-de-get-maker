VBlank:
    call hAPIOAMDMA
    call UpdateSFX
    call UpdateMusic
    ret



WaitOneFrame:
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
