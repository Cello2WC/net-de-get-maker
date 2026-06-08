include "include/charmap.asm"

include "include/constants/icon_constants.asm"
DEF GAME_CATEGORY EQU CATEGORY_PROGRAM
DEF GAME_GENRE EQU GENRE_PUZZLE
DEF GAME_ID EQUS "G014"
DEF GAME_TITLE EQUS "とんではねてそろえて"
DEF GAME_DESCR EQUS "バラバラになったえを　もとにもどそう"

include "include/header.asm"

MinigameStart:
	ld a, 1
	ld [$d000], a
	call Function4c93
	ld a, [$c214]
	cp $ff
	ret z
	call Function423f
	ld a,$fb
	ldh [$ff06],a
	ld a,$04
	ldh [$ff07],a
.bigLoop
	call Function40e1
	ld a, 1
	call Function417b
	ld a, 0
	ld [$ff4f],a
	call Function41e3
	call Function42aa
	ld a,$04
	call APIUnpackAllPalettes
	call Function4c7f
	call APIStopAudio
.loop
	call APIJoypadFrameCount
	call APIFunction34
	call APIFunction5B
	call APIApplyAllPalettes
	call Function42b7
	ld a, [$d000]
	cp $f0
	jr z, .skip1
	ld a, [$d000]
	cp $00
	jr nz, Function40D2
	call Function4a0b
.skip1
	call APIFunction5B
	call Function4157
	xor a
	ldh [$ff07],a
	call Function4252
	ret 

Function40D2:
	push af
	call Function430b
	pop af
	cp $ff
	jr nz, MinigameStart.loop
	call Function4157
	jp MinigameStart.bigLoop
	
Function40e1:
	ld a,[$d07f]
	cp $ff
	jr nz,.skip1
	ld a,$03
	call APIRandomRange
	ld [$d07f],a
	call APIStopAudio
	ld hl,$6000
	ld de,$002f
	call APILoadSong
	ld a,$01
	ld [$d000],a
	ld hl,$d002
	ld bc,$0008
.loop1
	xor a
	ld [hli],a
	dec bc
	ld a,c
	or b
	jr nz, .loop1
	ld hl,$c84b
	ld bc,$0005
.loop2
	xor a
	ld [hli],a
	dec bc
	ld a,c
	or b
	jr nz, .loop2
	call Function4466
.skip1
	ld a,$00
	ldh [$ff70],a
	ld a,$00
	ld [$d006],a
	di 
	xor a
	ldh [$ff4f],a
	ldh [$ff70],a
	ld a,$56
	ld [wC21C],a
	ld a,$00
	ld [wC21D],a
	ld hl,$5122
	call APIFunction58
	ld de,$0000
	call APISetTimer
	ld de, VBlankRoutine
	call APISetVBlank
	ld de,$0000
	call APISetLCDC
	ld de,$0000
	call APISetSerial
	ei 
	ret 

Function4157:
	di 
	ld de,$0000
	call APISetTimer
	ld de,$0000
	call APISetVBlank
	ld de,$0000
	call APISetLCDC
	ld de,$0000
	call APISetSerial
	ei 
	ret 

Function4172:
	di 
	ld de, VBlankRoutine
	call APISetVBlank
	ei 
	ret 

Function417b:
	push af
	call Function41e3
	ld a,$00
	ldh [$ff4f],a
	xor a
	call APISetLYC
	di 
	ld de,$0000
	call APISetLCDC
	ei 
	xor a
	ld [$c221],a
	ld [$c21f],a
	ld [$c220],a
	call Function4261
	ld a,$57
	ld [rBankBNum],a
	ldh [$ffad],a
	ld a,$00
	ld [rBankBSelect],a
	ldh [$ffae],a
	ld a,$00
	ldh [$ff4f],a
	ld hl,$7450
	ld de,$8000
	ld bc,$0740
	call APICopyVRAM
	ld a,$01
	ldh [$ff4f],a
	ld hl,$7350
	ld de,$8b00
	ld bc,$0100
	call APICopyVRAM
	call Function41e3
	pop af
	or a
	ret z

	ld de,$6080
	ld a,[$d07f]
	cp $03
	jr c,$016e
	ld de,$6120
	ld a,$00
	call Function48b9
	ret 

Function41e3:
	ld a,[$d07f]
	cp $03
	jr nc, Function422a
	ld hl, .jumptable
	push hl
	jp $05f5 ; Jumptable
.jumptable
	dw Function41F7 ; 41F7
	dw Function4208 ; 4208
	dw Function4219 ; 4219

Function41F7:
	di 
	ld a,$57
	ld [rBankBNum],a
	ldh [$ffad],a
	ld a,$00
	ld [rBankBSelect],a
	ldh [$ffae],a
	ei 
	ret 
	
Function4208:
	di 
	ld a,$58
	ld [rBankBNum],a
	ldh [$ffad],a
	ld a,$00
	ld [rBankBSelect],a
	ldh [$ffae],a
	ei 
	ret 

Function4219:
	di 
	ld a,$59
	ld [rBankBNum],a
	ldh [$ffad],a
	ld a,$00
	ld [rBankBSelect],a
	ldh [$ffae],a
	ei 
	ret 

Function422a:
	ld a,[$d9b7]
	call APIFunction74
	di 
	ld a,e
	ld [rBankBNum],a
	ldh [$ffad],a
	ld a,d
	ld [rBankBSelect],a
	ldh [$ffae],a
	ei 
	ret 

Function423f:
	push af
	ld a,[$d07f]
	cp $03
	jr c, .return
	cp $ff
	jr z, .return
	push hl
	call $1362
	pop hl
.return
	pop af
	ret 

Function4252:
	push af
	ld a,[$d07f]
	cp $03
	jr c, .return
	push hl
	call $1359
	pop hl
.return
	pop af
	ret 

Function4261:
	ld a,[$d07f]
	cp $03
	jr nc, .skip1
	ld a,$00
	ldh [$ff4f],a
	ld hl,$6350
	ld de,$8800
	ld bc,$1000
	call APICopyVRAM
	ld a,$01
	ldh [$ff4f],a
	ld hl,$7350
	ld de,$8800
	ld bc,$0800
	call APICopyVRAM
	ret 
.skip1
	ld a,$00
	ldh [$ff4f],a
	ld hl,$63f0
	ld de,$8800
	ld bc,$1000
	call APICopyVRAM
	ld a,$01
	ldh [$ff4f],a
	ld hl,$73f0
	ld de,$8800
	ld bc,$0800
	call APICopyVRAM
	ret 

Function42aa:
	ld hl,$6000
	ld a,[$d07f]
	cp $03
	ret c

	ld hl,$60a0
	ret 
	
Function42b7:
	ld a,[$c220]
	or a
	jr nz, .skip1
	ld a,[$d006]
	cp $01
	jr nz, .skip1
	ld a,$00
	ld [$d000],a
	ret 
.skip1
	ld a,[$d001]
	inc a
	ld [$d001],a
	ld a,[$d000]
	ld hl, .jumptable
	push hl
	jp Jumptable
	
.jumptable
	dw 0
	dw Function4316
	dw Function4365
	dw Function43ec
	
Function42e3:
	ld a,$44
VBlankRoutine:
	call hAPIOAMDMA
	call APIUpdatePalettesVBlank
	call Function49e1
	ld a,[$d000]
	cp $03
	ret nz

	ld a,[$d080]
	inc a
	ld [$d080],a
	cp $05
	jr c, .skip1
	ld a,$00
	ld [$d080],a
.skip1
	and $01
	ret nz

	call Function49e1
	ret 

Function430b:
	halt 
	nop 
.loop
	ld a,[$ff8a]
	and a
	jr z, .loop
	xor a
	ld [$ff8a],a
	ret 

Function4316:
	ld a,$81
	ld [$cf80],a
	ld [$c66b],a
	ld [$c665],a
	ld a,[$002f]
	ld [$c666],a
	ld a,[$0030]
	ld [$c667],a
	call Function48dc
	ld a,[$ff8b]
	and $1f
	cp $0f
	jr nc,.skip1
	ld b,$01
	ld c,$05
	ld d,$30
	ld e,$90
	call Function4f50
.skip1
	ld a,[$ff97]
	and $01
	ret z

	ld a,$00
	call Function4957
	ld a,$00
	ld de,$505a
	call Function48b9
	ld a,$02
	ld [$d000],a
	ld a,$00
	call Function4933
	ld a,$81
	call APISilenceAudio
	ret 

Function4365:
	ld a,$81
	ld [$cf80],a
	ld [$c66b],a
	ld [$c665],a
	ld a,[$002f]
	ld [$c666],a
	ld a,[$0030]
	ld [$c667],a
	ld a,[$d018]
	or a
	jr z, .loop
	call Function45a0
	ld a,$00
	ld [$d018],a
	jr .almostReturn
.loop
	ld a,[$d001]
	and $0d
	jr nz, .skip2
	ld a,$01
	jr .noRandom
.skip2
	ld a,[$d001]
	and $0e
	jr nz,.doRandom
	ld a,$03
	jr .noRandom
.doRandom
	ld a,$04
	call APIRandomRange
.noRandom
	push af
	ld b,a
	ld a,[$d019]
	ld c,a
	ld a,b
	srl a
	ld d,a
	ld a,c
	srl a
	cp d
	jr z, .skip3
	pop af
	ld [$d019],a
	call Function452c
	jr .almostReturn
.skip3
	pop af
	ld a,[$d010]
	dec a
	ld [$d010],a
	cp $02
	jr nz,.skip4
	ld a,$82
	call APISilenceAudio
	jr .almostReturn
.skip4
	or a
	jr nz,.almostReturn
	ld a,[$d01b]
	call Function46fb
	ld a,$03
	ld [$d000],a
	ld a,$81
	call APIPlaySong
	jr .loop
.almostReturn
	call Function48dc
	ret 

Function43ec:
	ld a,[$d018]
	or a
	jr z, .skip1
	call Function45a0
	call Function47be
	ld a,[$d001]
	and $01
	jr nz, .skip2
	ld a,[$d018]
	dec a
	ld [$d018],a
	cp $00
	jr nz, .skip2
	call Function44db
	cp $01
	jr nz, .skip2
	ld a,$04
	ld [$d000],a
	jr nz, .skip2
	ld a,$00
	ld de,$505a
	call Function48b9
.skip1
	call Function4755
	call Function44f8
	ld a,[$d001]
	srl a
	srl a
	srl a
	and $01
	ld [$d01d],a
.skip2
	ld a,[$d000]
	cp $ff
	ret z

	call Function497b
	ret 

Function443e: ; unreferenced?? maybe??
	ld a,[$d001]
	srl a
	srl a
	srl a
	and $01
	ld [$d01d],a
	call Function47cf
	call Function48dc
	ld a,[$d01a]
	dec a
	ld [$d01a],a
	or a
	ret nz

	ld a,$01
	call Function4957
	ld a,$00
	ld [$d000],a
	ret 
	
Function4466:
	ld a,$01
	ld [$d000],a
	ld a,$17
	ld [$d01b],a
	ld a,$00
	ld [$d016],a
	ld a,$00
	ld [$d017],a
	ld a,$00
	ld [$d018],a
	ld a,$00
	ld [$d015],a
	ld a,$00
	ld [$d019],a
	ld a,$00
	ld [$d01d],a
	ld a,$40
	ld [$d010],a
	ld a,$80
	ld [$d01a],a
	ld a,$00
	ld [$d080],a
	
	ld hl,$d008
	ld bc,$0008
.loop1
	xor a
	ld [hli],a
	dec bc
	ld a,c
	or b
	jr nz, .loop1
	
	ld hl,$d002
	ld bc,$0008
.loop2
	xor a
	ld [hli],a
	dec bc
	ld a,c
	or b
	jr nz, .loop2
	
	ld d,$00
.bigloop
	ld a,$02
	ld c,a
	ld a,d
	call APISmallMultiply
	ld [$d011],a
	ld a,[$d011]
	add a,$1f
	ld l,a
	ld a,$d0
	adc a,$00
	ld h,a
	ld a,[hl]
	ld a,d
	ld [hl],a
	inc hl
	ld a,d
	ld [hl],a
	inc d
	ld a,d
	cp $18
	jr c, .bigloop
	ret 

Function44db:
	ld a,$16
	ld hl,$d01f
	cp $ff
	jr z, .skip1
	push af
	ld a,[hl]
	ld b,a
	inc hl
	ld a,[hl]
	inc hl
	cp b
	jr z, .skip2
	pop af
	ld a,$00
	ret 
.skip2
	pop af
	dec a
	jr $0471
.skip1
	ld a,$01
	ret 

Function44f8:
	ld a,[$ff98]
	and $10
	jr z, .skip1
	ld a,$00
	call Function452c
	ret 
.skip1
	ld a,[$ff98]
	and $20
	jr z, .skip2
	ld a,$01
	call Function452c
	ret 
.skip2
	ld a,[$ff98]
	and $80
	jr z, .skip3
	ld a,$02
	call Function452c
	ret 
.skip3
	ld a,[$ff98]
	and $40
	jr z, .skip4
	ld a,$03
	call Function452c
	ret 
.skip4
	call Function48dc
	ret 

Function452c:
	ld hl,.jumptable
	push hl
	jp Jumptable
.jumptable
	dw Function453b
	dw Function4551
	dw Function4567
	dw Function457d
	
Function453b:
	call Function4593
	cp $05
	ret z

	ld a,$04
	ld [$d018],a
	ld a,$00
	ld [$d015],a
	ld a,$01
	call Function463e
	ret 

Function4551:
	call Function4593
	cp $00
	ret z

	ld a,$04
	ld [$d018],a
	ld a,$01
	ld [$d015],a
	ld a,$ff
	call Function463e
	ret 

Function4567:
	ld a,[$d01b]
	cp $12
	ret nc

	ld a,$05
	ld [$d018],a
	ld a,$02
	ld [$d015],a
	ld a,$06
	call Function463e
	ret 

Function457d:
	ld a,[$d01b]
	cp $06
	ret c

	ld a,$05
	ld [$d018],a
	ld a,$03
	ld [$d015],a
	ld a,$fa
	call Function463e
	ret 

Function4593:
	ld a,$06
	ld c,a
	ld a,[$d01b]
	push de
	call APIByteDivide
	pop de
	ld h,a
	ret 

Function45a0:
	push af
	ld a,[$d01b]
	call Function46fb
	pop af
	ld a,$02
	ld c,a
	ld a,[$d01c]
	call APISmallMultiply
	ld [$d011],a
	ld a,[$d011]
	add a,$1f
	ld l,a
	ld a,$d0
	adc a,$00
	ld h,a
	ld a,[hl]
	call Function461a
	push hl
	ld a,[$d011]
	add a,$20
	ld l,a
	ld a,$d0
	adc a,$00
	ld h,a
	ld a,[hl]
	call Function473c
	ld a,[$d015]
	call Function45e2
	pop hl
	ld b,$03
	ld c,$04
	call Function4f1e
	ret 

Function45e2:
	push de
	pop bc
	ld hl, .jumptable
	push hl
	jp Jumptable
.jumptable
	dw Function45F3
	dw Function45FB
	dw Function4605
	dw Function460D
	
	
	
	db $FA, $18, $D0, $3D, $80, $47, $18, $1C, $FA, $18, $D0, $57, $15, $78, $92, $47, $18, $12, $FA, $18, $D0, $3D, $81, $4F, $18, $0A, $FA, $18, $D0, $57, $15, $79, $92, $4F, $18, $00, $C5, $D1, $C9, $F5, $21, $10, $61, $FA, $7F, $D0, $FE, $03, $38, $03, $21, $B0, $61, $E5, $E1, $F1, $B7, $28, $0D, $F5, $3E, $18, $85, $6F, $3E, $00, $8C, $67, $F1, $3D, $18, $F0, $E5, $E1, $C9, $EA, $12, $D0, $FA, $00, $D0, $FE, $03, $20, $05, $3E, $83, $CD, $4F, $02, $3E, $02, $4F, $FA, $1B, $D0, $EA, $1C, $D0, $CD, $2B, $02, $EA, $11, $D0, $FA, $11, $D0, $C6, $1F, $6F, $3E, $D0, $CE, $00, $67, $7E, $EA, $13, $D0, $E5, $FA, $12, $D0, $47, $FA, $1B, $D0, $80, $CD, $2B, $02, $EA, $11, $D0, $FA, $11, $D0, $C6, $1F, $6F, $3E, $D0, $CE, $00, $67, $7E, $EA, $14, $D0, $FA, $13, $D0, $77, $E1, $FA, $14, $D0, $77, $FA, $12, $D0, $47, $FA, $1B, $D0, $80, $EA, $1B, $D0, $FA, $00, $D0, $FE, $02, $C0, $FA, $1C, $D0, $CD, $09, $47, $FA, $1B, $D0, $CD, $FB, $46, $C9, $E5, $06, $14, $0E, $01, $16, $00, $1E, $00, $CD, $1E, $4F, $E1, $3E, $28, $85, $6F, $3E, $00, $8C, $67, $E5, $06, $14, $0E, $01, $16, $00, $1E, $11, $CD, $1E, $4F, $E1, $3E, $28, $85, $6F, $3E, $00, $8C, $67, $E5, $06, $01, $0E, $10, $16, $00, $1E, $01, $CD, $1E, $4F, $E1, $3E, $20, $85, $6F, $3E, $00, $8C, $67, $06, $01, $0E, $10, $16, $13, $1E, $01, $CD, $1E, $4F, $C9, $CD, $3C, $47, $06, $03, $0E, $04, $21, $EA, $50, $CD, $1E, $4F, $C9, $F5, $3E, $02, $4F, $F1, $CD, $2B, $02, $EA, $11, $D0, $FA, $11, $D0, $C6, $1F, $6F, $3E, $D0, $CE, $00, $67, $7E, $CD, $1A, $46, $E5, $FA, $11, $D0, $C6, $20, $6F, $3E, $D0, $CE, $00, $67, $7E, $CD, $3C, $47, $E1, $06, $03, $0E, $04, $CD, $1E, $4F, $C9, $47, $21, $42, $54, $85, $6F, $3E, $00, $8C, $67, $7E, $57, $78, $21, $5A, $54, $85, $6F, $3E, $00, $8C, $67, $7E, $5F, $C9, $CD, $FC, $47, $06, $00, $FA, $1D, $D0, $4F, $D5, $CD, $50, $4F, $D1, $7A, $C6, $04, $57, $CD, $93, $45, $FE, $05, $28, $0E, $D5, $CD, $AF, $48, $82, $57, $06, $01, $0E, $00, $CD, $50, $4F, $D1, $CD, $93, $45, $FE, $00, $28, $10, $D5, $CD, $AF, $48, $47, $7A, $90, $57, $06, $01, $0E, $01, $CD, $50, $4F, $D1, $FA, $1B, $D0, $FE, $12, $30, $0E, $D5, $CD, $AF, $48, $83, $5F, $06, $01, $0E, $02, $CD, $50, $4F, $D1, $FA, $1B, $D0, $FE, $06, $38, $0E, $CD, $AF, $48, $47, $7B, $90, $5F, $06, $01, $0E, $03, $CD, $50, $4F, $C9, $CD, $FC, $47, $FA, $15, $D0, $CD, $12, $48, $7E, $4F, $06, $00, $CD, $50, $4F, $C9, $CD, $FC, $47, $FA, $01, $D0, $CB, $3F, $CB, $3F, $E6, $03, $21, $8C, $54, $85, $6F, $3E, $00, $8C, $67, $7E, $83, $5F, $FA, $1D, $D0, $4F, $06, $00, $CD, $50, $4F, $16, $34, $1E, $48, $06, $01, $0E, $04, $CD, $50, $4F, $C9, $FA, $1B, $D0, $CD, $3C, $47, $14, $7A, $07, $07, $07, $D6, $04, $57, $1C, $1C, $7B, $07, $07, $07, $5F, $C9, $D5, $C1, $21, $1B, $48, $E5, $C3, $F5, $05, $42, $48, $23, $48, $82, $48, $63, $48, $FA, $18, $D0, $3D, $F5, $CB, $27, $CB, $27, $CB, $27, $80, $47, $21, $86, $54, $F1, $85, $6F, $3E, $00, $8C, $67, $7E, $81, $4F, $21, $72, $54, $18, $61, $FA, $18, $D0, $57, $15, $D5, $78, $CB, $22, $CB, $22, $CB, $22, $92, $47, $21, $86, $54, $F1, $85, $6F, $3E, $00, $8C, $67, $7E, $81, $4F, $21, $77, $54, $18, $40, $FA, $18, $D0, $3D, $F5, $CB, $27, $CB, $27, $CB, $27, $81, $4F, $21, $8C, $54, $F1, $85, $6F, $3E, $00, $8C, $67, $7E, $81, $4F, $21, $7C, $54, $18, $21, $FA, $18, $D0, $57, $15, $F5, $79, $CB, $22, $CB, $22, $CB, $22, $92, $4F, $21, $8C, $54, $F1, $85, $6F, $3E, $00, $8C, $67, $7E, $81, $4F, $21, $81, $54, $18, $00, $C5, $D1, $FA, $18, $D0, $85, $6F, $3E, $00, $8C, $67, $C9, $FA, $01, $D0, $CB, $3F, $CB, $3F, $E6, $03, $C9, $F5, $D5, $E5, $E1, $3E, $17, $FE, $FF, $28, $08, $F5, $CD, $09, $47, $F1, $3D, $18, $F4, $E1, $CD, $B0, $46, $F1, $B7, $28, $06, $FA, $1B, $D0, $CD, $FB, $46, $E5, $E1, $C9, $F0, $97, $E6, $08, $C8, $3E, $84, $CD, $4F, $02, $CD, $0B, $43, $3E, $86, $CD, $4F, $02, $CD, $0B, $43, $3E, $01, $CD, $57, $49, $FA, $00, $D0, $EA, $BA, $D9, $3E, $05, $EA, $00, $D0, $CD, $3A, $4D, $FA, $BA, $D9, $EA, $00, $D0, $21, $00, $60, $11, $2F, $00, $CD, $46, $02, $FA, $00, $D0, $FE, $02, $C0, $FA, $10, $D0, $FE, $03, $D8, $3E, $81, $CD, $4F, $02, $C9, $CD, $55, $02, $FA, $20, $C2, $4F, $FA, $86, $CF, $B1, $20, $F6, $C9, $F5, $CD, $AA, $42, $3E, $04, $CD, $77, $01, $F1, $F5, $CD, $7D, $01, $F1, $B7, $F5, $28, $06, $CD, $61, $02, $CD, $55, $47, $CD, $0B, $43, $FA, $1F, $C2, $B7, $20, $E9, $F1, $C9, $EA, $06, $D0, $3E, $00, $EA, $B8, $C1, $CD, $AA, $42, $3E, $04, $CD, $7A, $01, $CD, $7D, $01, $CD, $61, $02, $CD, $0B, $43, $FA, $20, $C2, $4F, $FA, $86, $CF, $B1, $20, $ED, $C9, $FA, $00, $D0, $FE, $01, $C8, $21, $02, $D0, $3E, $BE, $77, $23, $3E, $0F, $77, $16, $08, $1E, $00, $06, $01, $0E, $01, $21, $02, $D0, $C5, $D5, $E5, $CD, $1E, $4F, $E1, $D1, $C1, $14, $14, $14, $CD, $1E, $4F, $21, $08, $D0, $16, $06, $E5, $7E, $C6, $B4, $21, $02, $D0, $77, $23, $3E, $0F, $77, $D5, $7A, $FE, $05, $38, $04, $14, $14, $18, $08, $7A, $FE, $03, $38, $03, $14, $18, $00, $3E, $05, $82, $57, $1E, $00, $06, $01, $0E, $01, $21, $02, $D0, $CD, $1E, $4F, $D1, $E1, $23, $15, $7A, $B7, $20, $CA, $C9, $21, $08, $D0, $16, $06, $7E, $3C, $77, $F5, $7A, $E6, $01, $EE, $01, $CB, $27, $CB, $27, $C6, $06, $47, $7A, $FE, $04, $38, $02, $06, $0A, $F1, $B8, $38, $09, $3E, $00, $77, $23, $15, $7A, $B7, $20, $DC, $C9, $21, $1B, $C8, $11, $7B, $4A, $CD, $7A, $4F, $21, $33, $C8, $11, $89, $4A, $CD, $7A, $4F, $3E, $03, $11, $0D, $D0, $F5, $1A, $C6, $20, $77, $23, $1B, $1A, $C6, $20, $77, $23, $1B, $3E, $2A, $77, $23, $F1, $3D, $B7, $20, $EA, $2B, $3E, $00, $77, $3E, $00, $EA, $4B, $C8, $3E, $00, $EA, $4B, $C8, $3E, $00, $EA, $4D, $C8, $FA, $0D, $D0, $B7, $28, $05, $3E, $01, $EA, $4C, $C8, $FA, $0C, $D0, $47, $3E, $0A, $90, $0E, $0C, $CD, $2B, $02, $CB, $3F, $CB, $3F, $CB, $3F, $EA, $4C, $C8, $CB, $3F, $CB, $3F, $EA, $4B, $C8, $CB, $3F, $EA, $4D, $C8, $CD, $12, $50, $C9, $10, $10, $10, $10, $FE, $94, $83, $92, $83, $8E, $85, $11, $11, $00, $8A, $B7, $92, $83, $FE, $90, $8A, $B7, $10, $00, $CD, $AE, $4B, $FA, $7F, $D0, $EA, $BB, $D9, $3E, $01, $EA, $7F, $D0, $3E, $01, $EA, $82, $D1, $3E, $00, $EA, $83, $D1, $CD, $65, $4C, $3E, $03, $21, $96, $D1, $11, $99, $4B, $F5, $CD, $7A, $4F, $23, $13, $F1, $3D, $20, $F6, $3E, $03, $EA, $96, $D9, $E5, $FA, $0D, $40, $EA, $75, $C8, $FA, $0E, $40, $EA, $76, $C8, $11, $75, $C8, $01, $81, $D0, $CD, $A9, $02, $05, $78, $EA, $81, $D1, $FE, $FF, $28, $44, $B7, $28, $41, $E1, $11, $82, $D0, $FA, $81, $D1, $F5, $D5, $E5, $1A, $CD, $AC, $02, $21, $F0, $5B, $7D, $EA, $62, $C8, $7C, $EA, $63, $C8, $21, $97, $D9, $7D, $EA, $64, $C8, $7C, $EA, $65, $C8, $01, $18, $00, $CD, $AF, $02, $11, $97, $D9, $E1, $CD, $7A, $4F, $23, $FA, $96, $D9, $3C, $EA, $96, $D9, $D1, $13, $F1, $3D, $B7, $20, $C7, $E5, $E1, $CD, $F1, $4B, $CD, $0B, $43, $CD, $79, $02, $CD, $EC, $01, $CD, $61, $02, $CD, $7D, $01, $CD, $F8, $01, $F0, $97, $E6, $01, $28, $10, $3E, $01, $F5, $3E, $9D, $CD, $4F, $02, $CD, $40, $4C, $EA, $7F, $D0, $18, $14, $F0, $97, $E6, $02, $28, $D2, $3E, $00, $F5, $3E, $9D, $CD, $4F, $02, $FA, $BB, $D9, $EA, $7F, $D0, $FA, $7F, $D0, $FE, $03, $38, $0F, $D6, $03, $21, $82, $D0, $85, $6F, $3E, $00, $8C, $67, $7E, $EA, $B7, $D9, $3E, $40, $EA, $FF, $37, $E0, $AD, $3E, $00, $EA, $00, $38, $E0, $AE, $21, $00, $60, $3E, $04, $CD, $7A, $01, $CD, $7F, $4C, $F1, $C9, $89, $99, $A8, $FE, $94, $95, $00, $89, $8F, $B7, $FF, $A3, $00, $9F, $83, $D5, $3C, $FE, $D1, $11, $00, $CD, $57, $41, $CD, $82, $02, $CD, $1E, $41, $CD, $7B, $41, $3E, $02, $11, $02, $51, $CD, $E6, $01, $01, $10, $06, $21, $92, $54, $CD, $EF, $01, $3E, $40, $EA, $FF, $37, $E0, $AD, $3E, $00, $EA, $00, $38, $E0, $AE, $21, $00, $60, $3E, $04, $CD, $77, $01, $CD, $7D, $01, $CD, $0B, $43, $FA, $1F, $C2, $B7, $20, $F4, $CD, $57, $41, $C9, $CD, $72, $41, $21, $00, $60, $3E, $04, $CD, $7A, $01, $CD, $7F, $4C, $AF, $EA, $C2, $C1, $3E, $02, $11, $02, $51, $CD, $E6, $01, $21, $35, $4C, $01, $02, $06, $CD, $EF, $01, $3E, $03, $11, $02, $51, $CD, $E6, $01, $FA, $96, $D9, $06, $03, $0E, $0A, $21, $96, $D1, $CD, $44, $4C, $21, $00, $60, $3E, $04, $CD, $77, $01, $CD, $7F, $4C, $C9, $D1, $D8, $3C, $FE, $D0, $D2, $F2, $CC, $D9, $01, $00, $FA, $14, $C2, $C9, $F5, $E5, $79, $EA, $C2, $C1, $78, $0E, $00, $11, $02, $51, $CD, $E3, $01, $E1, $F1, $57, $3E, $01, $06, $12, $0E, $04, $1E, $01, $CD, $F2, $01, $CD, $F5, $01, $C9, $AF, $EA, $11, $C2, $EA, $12, $C2, $EA, $13, $C2, $EA, $15, $C2, $EA, $14, $C2, $EA, $16, $C2, $EA, $17, $C2, $EA, $1B, $C2, $C9, $CD, $7D, $01, $CD, $61, $02, $CD, $0B, $43, $FA, $20, $C2, $4F, $FA, $86, $CF, $B1, $20, $ED, $C9, $3E, $FF, $EA, $7F, $D0, $3E, $03, $4F, $21, $25, $4D, $CD, $97, $02, $FA, $14, $C2, $FE, $FF, $28, $69, $21, $1F, $4D, $E5, $C3, $F5, $05, $CD, $25, $49, $C9, $CD, $93, $4A, $B7, $28, $3A, $CD, $B7, $44, $3E, $01, $CD, $7B, $41, $3E, $01, $EA, $00, $D0, $21, $02, $D0, $01, $08, $00, $AF, $22, $0B, $79, $B0, $20, $F9, $21, $4B, $C8, $01, $05, $00, $AF, $22, $0B, $79, $B0, $20, $F9, $CD, $66, $44, $CD, $52, $02, $21, $00, $60, $11, $2F, $00, $CD, $46, $02, $CD, $57, $41, $C9, $18, $9E, $3E, $19, $E0, $9D, $3E, $00, $E0, $9E, $3E, $E9, $E0, $9F, $3E, $66, $E0, $A0, $3E, $05, $06, $00, $CD, $64, $02, $CD, $57, $49, $18, $82, $3E, $10, $EA, $71, $C6, $CD, $57, $41, $3E, $FF, $EA, $14, $C2, $C9, $AF, $4C, $B3, $4C, $F5, $4C, $9F, $FE, $90, $A7, $B1, $00, $D1, $D8, $3C, $FE, $D0, $D2, $F2, $CC, $D9, $00, $92, $97, $A7, $83, $00, $F0, $40, $F5, $F0, $40, $E6, $B7, $E0, $40, $F0, $43, $F5, $3E, $00, $E0, $43, $F0, $42, $F5, $3E, $00, $E0, $42, $CD, $57, $41, $3E, $05, $01, $00, $00, $21, $12, $14, $11, $00, $D0, $CD, $91, $02, $3E, $04, $4F, $21, $FE, $4E, $CD, $97, $02, $FA, $14, $C2, $3C, $21, $76, $4D, $E5, $C3, $F5, $05, $C1, $4E, $80, $4D, $BB, $4D, $1B, $4E, $46, $4E, $CD, $57, $41, $3E, $56, $EA, $1C, $C2, $3E, $00, $EA, $1D, $C2, $21, $22, $51, $CD, $58, $02, $3E, $01, $CD, $7B, $41, $3E, $06, $CD, $68, $01, $F5, $C5, $D5, $E5, $3E, $05, $01, $00, $00, $21, $12, $14, $11, $00, $D0, $CD, $94, $02, $E1, $D1, $C1, $F1, $3E, $00, $EA, $06, $D0, $C3, $CE, $4E, $CD, $93, $4A, $F5, $CD, $62, $13, $F1, $B7, $20, $25, $CD, $57, $41, $F5, $C5, $D5, $E5, $3E, $05, $01, $00, $00, $21, $12, $14, $11, $00, $D0, $CD, $94, $02, $E1, $D1, $C1, $F1, $F1, $E0, $42, $F1, $E0, $43, $F1, $E0, $40, $C3, $3A, $4D, $CD, $55, $02, $3E, $01, $EA, $BA, $D9, $CD, $B7, $44, $3E, $01, $CD, $7B, $41, $3E, $06, $CD, $68, $01, $CD, $52, $02, $21, $00, $60, $11, $2F, $00, $CD, $46, $02, $CD, $57, $41, $CD, $66, $44, $AF, $E0, $97, $CD, $33, $49, $C3, $CE, $4E, $3E, $19, $E0, $9D, $3E, $00, $E0, $9E, $3E, $E9, $E0, $9F, $3E, $66, $E0, $A0, $3E, $05, $06, $00, $CD, $64, $02, $3E, $04, $4F, $21, $FE, $4E, $CD, $97, $02, $FA, $14, $C2, $3C, $21, $76, $4D, $E5, $C3, $F5, $05, $3E, $30, $11, $1F, $D0, $21, $4F, $D0, $CD, $84, $4F, $F3, $3E, $56, $EA, $1C, $C2, $3E, $00, $EA, $1D, $C2, $21, $22, $51, $CD, $58, $02, $FB, $CD, $72, $41, $CD, $B7, $44, $3E, $01, $CD, $7B, $41, $3E, $06, $CD, $68, $01, $3E, $00, $CD, $33, $49, $CD, $79, $02, $CD, $61, $02, $F0, $8B, $E6, $FF, $FE, $0F, $30, $0E, $06, $01, $0E, $05, $16, $30, $1E, $90, $CD, $50, $4F, $CD, $0B, $43, $F0, $97, $E6, $01, $28, $DE, $3E, $00, $CD, $57, $49, $CD, $57, $41, $3E, $30, $11, $4F, $D0, $21, $1F, $D0, $CD, $84, $4F, $3E, $04, $4F, $21, $FE, $4E, $CD, $97, $02, $FA, $14, $C2, $3C, $21, $76, $4D, $E5, $C3, $F5, $05, $CD, $55, $02, $3E, $10, $EA, $71, $C6, $3E, $F0, $EA, $BA, $D9, $CD, $72, $41, $FA, $14, $C2, $B7, $28, $18, $FE, $02, $28, $14, $FA, $20, $C2, $4F, $FA, $86, $CF, $B1, $20, $F6, $F1, $E0, $42, $F1, $E0, $43, $F1, $E0, $40, $C9, $F1, $E0, $42, $F1, $E0, $43, $F1, $E0, $40, $3E, $00, $CD, $33, $49, $C9, $97, $FE, $97, $8D, $B1, $00, $D1, $D8, $3C, $FE, $D0, $D2, $F2, $CC, $D9, $00, $92, $97, $A7, $83, $00, $A8, $99, $9E, $87, $B6, $A0, $AD, $85, $FE, $90, $00, $F0, $70, $F5, $C5, $E5, $7A, $E0, $9D, $16, $00, $01, $20, $00, $CD, $31, $02, $F0, $9D, $06, $00, $4F, $09, $01, $00, $98, $F0, $40, $E6, $08, $28, $03, $01, $00, $9C, $09, $E5, $D1, $3E, $00, $E0, $4F, $E1, $C1, $CD, $A4, $01, $F1, $E0, $70, $C9, $F0, $70, $F5, $78, $41, $4F, $7A, $53, $5F, $CD, $5E, $02, $F1, $E0, $70, $C9, $D5, $E5, $4F, $1A, $47, $7E, $B8, $20, $0C, $13, $23, $0D, $79, $B7, $20, $F3, $3E, $01, $E1, $D1, $C9, $3E, $00, $E1, $D1, $C9, $1A, $77, $B7, $28, $04, $13, $23, $18, $F7, $C9, $B7, $28, $0A, $F5, $1A, $77, $13, $23, $F1, $3D, $B7, $20, $F6, $C9, $B7, $28, $15, $F5, $79, $E0, $70, $1A, $F5, $78, $E0, $70, $F1, $77, $B7, $28, $07, $13, $23, $F1, $3D, $B7, $20, $E8, $C9, $B7, $28, $12, $F5, $79, $E0, $70, $1A, $F5, $78, $E0, $70, $F1, $77, $13, $23, $F1, $3D, $B7, $20, $EB, $C9, $E0, $9E, $FA, $3C, $C7, $A7, $20, $0F, $CD, $88, $02, $21, $05, $C7, $34, $CD, $8B, $02, $3E, $01, $EA, $3C, $C7, $01, $A3, $02, $11, $56, $50, $CD, $B6, $01, $E5, $7D, $C6, $08, $6F, $7C, $CE, $00, $67, $11, $3D, $C7, $01, $08, $00, $CD, $76, $02, $E1, $7D, $C6, $10, $6F, $7C, $CE, $00, $67, $2A, $12, $13, $2A, $12, $13, $F0, $9E, $07, $4F, $06, $00, $09, $2A, $12, $13, $7E, $12, $CD, $B9, $01, $C9, $CD, $C1, $4F, $FA, $3D, $C7, $CB, $3F, $B7, $20, $02, $3E, $01, $4F, $FA, $4B, $C8, $CD, $34, $02, $7D, $EA, $4B, $C8, $FA, $3E, $C7, $CB, $3F, $B7, $20, $02, $3E, $01, $4F, $FA, $4C, $C8, $CD, $34, $02, $7D, $EA, $4C, $C8, $FA, $3F, $C7, $CB, $3F, $CB, $3F, $B7, $20, $02, $3E, $01, $FA, $4D, $C8, $CD, $34, $02, $7D, $EA, $4D, $C8, $C9, $53, $59, $53, $31, $B2, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B2, $0F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $4F, $0F, $B2, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B2, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $B1, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $BF, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $00, $00, $12, $05, $01, $00, $00, $00, $00, $0A, $12, $03, $02, $00, $00, $00, $FF, $FF, $14, $16, $00, $00, $00, $00, $01, $05, $10, $04, $01, $00, $00, $00, $26, $51, $96, $53, $3C, $51, $7D, $51, $BE, $51, $FF, $51, $30, $52, $69, $52, $AA, $52, $DB, $52, $14, $53, $55, $53, $00, $00, $10, $00, $00, $00, $02, $00, $08, $01, $02, $00, $10, $01, $22, $00, $18, $00, $22, $08, $00, $10, $02, $08, $08, $11, $02, $08, $10, $24, $02, $08, $18, $10, $22, $10, $00, $20, $02, $10, $08, $21, $02, $10, $10, $21, $22, $10, $18, $20, $22, $18, $00, $30, $02, $18, $08, $31, $02, $18, $10, $31, $22, $18, $18, $30, $22, $10, $00, $00, $02, $02, $00, $08, $03, $02, $00, $10, $03, $22, $00, $18, $02, $22, $08, $00, $12, $02, $08, $08, $13, $02, $08, $10, $34, $02, $08, $18, $12, $22, $10, $00, $22, $02, $10, $08, $23, $02, $10, $10, $23, $22, $10, $18, $22, $22, $18, $00, $32, $02, $18, $08, $33, $02, $18, $10, $33, $22, $18, $18, $32, $22, $10, $00, $18, $0C, $22, $00, $10, $0D, $22, $00, $08, $0E, $22, $00, $00, $0F, $22, $08, $18, $1C, $22, $08, $10, $1D, $22, $08, $08, $3E, $22, $08, $00, $1F, $22, $10, $18, $2C, $22, $10, $10, $2D, $22, $10, $08, $2E, $22, $10, $00, $2F, $22, $18, $18, $3C, $22, $18, $10, $3D, $22, $18, $08, $3E, $22, $18, $00, $3F, $22, $0C, $08, $18, $08, $22, $08, $10, $09, $22, $08, $08, $0A, $22, $08, $00, $0B, $22, $10, $18, $18, $22, $10, $10, $19, $22, $10, $08, $1A, $22, $10, $00, $1B, $22, $18, $18, $28, $22, $18, $10, $29, $22, $18, $08, $2A, $22, $18, $00, $2B, $22, $0E, $00, $00, $04, $02, $00, $08, $05, $02, $00, $10, $06, $02, $00, $18, $07, $02, $08, $00, $14, $02, $08, $08, $15, $02, $08, $10, $16, $02, $08, $18, $17, $02, $10, $08, $25, $02, $10, $10, $26, $22, $10, $18, $27, $02, $18, $08, $35, $02, $18, $10, $36, $02, $18, $18, $37, $02, $10, $00, $00, $0C, $02, $00, $08, $0D, $02, $00, $10, $0E, $02, $00, $18, $0F, $02, $08, $00, $1C, $02, $08, $08, $1D, $02, $08, $10, $3E, $02, $08, $18, $1F, $02, $10, $00, $2C, $02, $10, $08, $2D, $02, $10, $10, $2E, $02, $10, $18, $2F, $02, $18, $00, $3C, $02, $18, $08, $3D, $02, $18, $10, $3E, $02, $18, $18, $3F, $02, $0C, $08, $00, $08, $02, $08, $08, $09, $02, $08, $10, $0A, $02, $08, $18, $0B, $02, $10, $00, $18, $02, $10, $08, $19, $02, $10, $10, $1A, $02, $10, $18, $1B, $02, $18, $00, $28, $02, $18, $08, $29, $02, $18, $10, $2A, $02, $18, $18, $2B, $02, $0E, $00, $18, $04, $22, $00, $10, $05, $22, $00, $08, $06, $22, $00, $00, $07, $22, $08, $18, $14, $22, $08, $10, $15, $22, $08, $08, $16, $22, $08, $00, $17, $22, $10, $10, $25, $22, $10, $08, $26, $22, $10, $00, $27, $22, $18, $10, $35, $22, $18, $08, $36, $22, $18, $00, $37, $22, $10, $00, $00, $40, $02, $00, $08, $41, $02, $00, $10, $41, $22, $00, $18, $40, $22, $08, $00, $42, $02, $08, $08, $43, $02, $08, $10, $3A, $02, $08, $18, $42, $22, $10, $00, $44, $02, $10, $08, $45, $02, $10, $10, $45, $22, $10, $18, $44, $22, $18, $00, $46, $02, $18, $08, $47, $02, $18, $10, $47, $22, $18, $18, $46, $22, $10, $00, $00, $48, $02, $00, $08, $49, $02, $00, $10, $4A, $02, $00, $18, $48, $22, $08, $00, $4B, $02, $08, $08, $4C, $02, $08, $10, $4D, $02, $08, $18, $4B, $22, $10, $00, $4E, $02, $10, $08, $4F, $02, $10, $10, $4F, $22, $10, $18, $4E, $22, $18, $00, $50, $02, $18, $08, $51, $02, $18, $10, $51, $22, $18, $18, $50, $22, $A4, $53, $A9, $53, $AE, $53, $B3, $53, $B8, $53, $19, $54, $00, $00, $01, $10, $20, $38, $03, $01, $10, $F0, $38, $23, $01, $20, $08, $39, $03, $01, $F8, $08, $39, $43, $18, $00, $00, $52, $04, $00, $08, $53, $04, $00, $10, $54, $04, $00, $18, $55, $04, $00, $20, $56, $04, $00, $28, $57, $04, $00, $30, $58, $04, $00, $38, $59, $04, $08, $00, $5A, $04, $08, $08, $5B, $04, $08, $10, $5C, $04, $08, $18, $5D, $04, $08, $20, $5E, $04, $08, $28, $5F, $04, $08, $30, $60, $04, $08, $38, $61, $04, $10, $00, $62, $04, $10, $08, $63, $04, $10, $10, $64, $04, $10, $18, $65, $04, $10, $20, $66, $04, $10, $28, $67, $04, $10, $30, $68, $04, $10, $38, $69, $04, $0A, $00, $00, $6A, $05, $00, $08, $6B, $05, $00, $10, $6C, $05, $00, $18, $6D, $05, $00, $20, $6E, $05, $00, $28, $6F, $05, $00, $30, $70, $05, $00, $38, $71, $05, $00, $40, $72, $05, $00, $48, $73, $05, $01, $04, $07, $0A, $0D, $10, $01, $04, $07, $0A, $0D, $10, $01, $04, $07, $0A, $0D, $10, $01, $04, $07, $0A, $0D, $10, $01, $01, $01, $01, $01, $01, $05, $05, $05, $05, $05, $05, $09, $09, $09, $09, $09, $09, $0D, $0D, $0D, $0D, $0D, $0D, $06, $07, $07, $06, $05, $03, $04, $04, $03, $02, $09, $08, $08, $09, $08, $00, $01, $01, $00, $01, $00, $F8, $F0, $F8, $00, $00, $00, $F0, $E8, $F0, $00, $00, $97, $83, $8A, $FE, $D8, $3C, $D4, $10, $8D, $B7, $8F, $8C, $95, $AB, $85
