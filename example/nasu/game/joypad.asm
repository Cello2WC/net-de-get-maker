ReadJoypadRegister:
    ld a, %00100000
    ldh [$FF00], a
    ldh a, [$FF00]
    rla
    rla
    rla
    rla
    xor a, %11111111
    and a, %11110000
    ld b, a
    xor a
    ldh [$FF00], a
    ld a, %00010000
    ldh [$FF00], a
    ldh a, [$FF00]
    xor a, %11111111
    and a, %00001111
    or b
    ld [hHeldButtons], a
    ret

UpdateButtons:
    call ReadJoypadRegister

    ld a, [hPressedButtonCheck]
    xor a, %11111111
    ld b, a
    ld a, [hHeldButtons]
    and b
    ld [hPressedButtons], a

    ld a, [hHeldButtons]
    ld [hPressedButtonCheck], a
    ret
