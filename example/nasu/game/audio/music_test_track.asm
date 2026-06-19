
Music_Test_Track:
;LOAD "Music", ROMX[Music_Test_Track | $2000]
	dw .pointer1        | $2000 ; $617B  ; goes to CF92..3
	dw .Track_List      | $2000 ; $660E  ; goes to CF90..1 ; Track list
	dw .PU1_Instruments | $2000 ; $600C  ; goes to CF94..5 ; PU1 instruments
	dw .PU2_Instruments | $2000 ; $603F  ; goes to CF96..7 ; PU2 instruments
	dw .WAV_Instruments | $2000 ; $6061  ; goes to CF98..9 ; WAV instruments
	dw .NOI_Instruments | $2000 ; $614B  ; goes to CF9A..B ; NOI instruments



.PU1_Instruments ; max of 0x20 values
	; values here go to CF07..9 based on value of byte at `bc` when 1E:44C6 is called
	db $00, $00, $00, ; always skipped???
	db $00, $E0, $07, 
	db $00, $00, $01, 
	db $00, $83, $05, 
	db $00, $00, $01, 
	db $7F, $80, $03, 
	db $67, $00, $07, 
	db $00, $E0, $07, 
	db $00, $83, $01, 
	db $00, $80, $02, 
	db $07, $00, $05, 
	db $71, $00, $04, 
	db $67, $00, $07, 
	db $00, $E0, $07, 
	db $00, $80, $03, 
	db $00, $40, $02, 
	db $00, $83, $01
	; next two bytes in music command(?) are processed and affect CF04..5
	; 



.PU2_Instruments ; max of 0x20 values
	; values here go to CF17..8 based on value of byte at `bc` when 1E:4682 is called
	db $00, $00, ; always skipped???
	db $E0, $02, 
	db $80, $02, 
	db $40, $01, 
	db $00, $03, 
	db $80, $05, 
	db $00, $03, 
	db $40, $07, 
	db $00, $03, 
	db $E0, $01, 
	db $83, $05, 
	db $40, $01, 
	db $00, $03, 
	db $40, $01, 
	db $00, $01, 
	db $40, $01, 
	db $00, $03, 
	; next two bytes in music command(?) are processed and affect CF14..5
	; 


; Waveforms
.WAV_Instruments ; max of 0x20 values
	; 0x10 bytes from one of these pointers is copied into FF30 Wave Pattern RAM when 1E:4825 is called
	dw .label607B | $2000
	dw .label608B | $2000
	dw .label609B | $2000
	dw .label60AB | $2000
	dw .label60BB | $2000
	dw .label60CB | $2000
	dw .label60DB | $2000
	dw .label60EB | $2000
	dw .label60FB | $2000
	dw .label610B | $2000
	dw .label611B | $2000
	dw .label612B | $2000
	dw .label613B | $2000

.label607B
	db $01, $23, $45, $67, $89, $AB, $CD, $EF, $ED, $CB, $A9, $87, $65, $43, $21, $00, 
.label608B
	db $01, $23, $45, $67, $89, $AB, $CD, $EF, $ED, $CB, $A9, $87, $65, $43, $21, $00, 
.label609B
	db $ED, $CB, $A9, $87, $65, $43, $21, $00, $ED, $CB, $A9, $87, $65, $43, $21, $00, 
.label60AB
	db $04, $79, $BC, $DE, $ED, $CB, $97, $40, $04, $79, $BC, $DE, $ED, $CB, $97, $40, 
.label60BB
	db $FF, $FF, $00, $00, $99, $99, $00, $00, $CC, $CC, $00, $00, $FF, $FF, $00, $00, 
.label60CB
	db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FC, $CC, $AA, $99, $55, $33, $21, $00, 
.label60DB
	db $FF, $F0, $00, $09, $99, $90, $00, $0F, $FF, $F7, $77, $7E, $EE, $E0, $00, $0F, 
.label60EB
	db $00, $10, $50, $80, $A0, $C0, $E0, $FF, $EE, $DD, $AA, $88, $55, $43, $21, $00, 
.label60FB
	db $00, $10, $50, $80, $A0, $C0, $E0, $FF, $EE, $DD, $AA, $88, $55, $43, $21, $00, 
.label610B
	db $89, $AB, $CD, $EF, $FF, $ED, $CB, $A9, $87, $65, $43, $21, $01, $23, $45, $67, 
.label611B
	db $01, $24, $56, $89, $AB, $CD, $DE, $EF, $FE, $ED, $DC, $BA, $98, $65, $42, $10, 
.label612B
	db $00, $FF, $00, $FF, $FF, $00, $FF, $00, $00, $FF, $00, $FF, $FF, $00, $FF, $00, 
.label613B
	db $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, $EE, 



.NOI_Instruments ; max of 0x20 values
	; first byte goes to CF32, second goes to CF37
	; CF32 goes to NR43
	db $52, $01, 
	db $12, $01, 
	db $43, $01, 
	db $42, $01, 
	db $41, $01, 
	db $52, $00, 
	db $31, $01, 
	db $30, $01, 
	db $32, $01, 
	db $22, $07, 
	db $16, $01, 
	db $13, $01, 
	db $53, $01, 
	db $52, $01, 
	db $51, $01, 
	db $50, $01, 
	db $43, $01, 
	db $42, $01, 
	db $01, $01, 
	db $40, $01, 
	db $33, $01, 
	db $32, $01, 
	db $12, $01, 
	db $22, $07, 


	; [$CF82]'th pointer picked from this list
.pointer1
	dw .label7029 | $2000
	dw .label61B9 | $2000
	dw .label61DD | $2000
	dw .label6283 | $2000
	dw .label6357 | $2000
	dw .label6371 | $2000
	dw .label63A9 | $2000
	dw .label6422 | $2000
	dw .label643C | $2000
	dw .label6460 | $2000
	dw .label6484 | $2000
	dw .label64B2 | $2000
	dw .label64CC | $2000
	dw .label6518 | $2000
	dw .label6532 | $2000
	dw .label654C | $2000
	dw .label658E | $2000
	dw .label65B7 | $2000
	dw .label65D6 | $2000
	dw .label700D | $2000
	dw .label7014 | $2000
	dw .label701B | $2000
	dw .label7022 | $2000
	dw .label7036 | $2000
	dw .label7036 | $2000
	dw .label7036 | $2000
	dw .label703A | $2000
	dw .label7086 | $2000
	dw .label70A0 | $2000
	dw .label70BA | $2000
	dw .label70FC | $2000

.label61B9
	db $03, $00, $00, $00, $00, 
	dw .label61C0 | $2000
.label61C0
	db $00, 
	db $C0, $03, $00, 
	db $B1, $40, $02, 
	db $9F, $4F, $02, 
	db $80, $03, 
	db $9B, $56, $01, 
	db $80, $01, 
	db $98, $53, $04, 
	db $80, $01, 
	db $94, $4C, $02, 
	db $80, $03, 
	db $FF, $2F, 
	
.label61DD
	db $02, $00, $00, $00, $00, 
	dw .label61E4 | $2000
.label61E4
	db $00, 
	db $C0, $01, $00, 
	db $B1, $40, $00, 
	db $9F, $29, $02, 
	db $80, $02, 
	db $9F, $29, $03, 
	db $80, $00, 
	db $9F, $20, $04, 
	db $80, $00, 
	db $9F, $15, $03, 
	db $80, $00, 
	db $9F, $34, $01, 
	db $80, $00, 
	db $9F, $15, $02, $80, $00, $9D, $14, $01, $80, $00, $98, $26, $05, $80, $00, $95, $15, $03, $80, $00, $92, $1F, $03, $80, $00, $9F, $2E, $01, $80, $01, $9F, $2E, $01, $80, $00, $9F, $26, $02, $80, $00, $9F, $1A, $01, $80, $00, $9F, $39, $01, $80, $00, $9F, $1B, $02, $80, $00, $9D, $19, $01, $80, $00, $98, $2B, $02, $80, $00, $95, $1A, $01, $80, $00, $92, $24, $01, $80, $00, $9F, $3E, $02, $80, $01, $9F, $3E, $02, $80, $00, $9F, $35, $01, $80, $00, $9F, $2A, $03, $80, $00, $9F, $49, $01, $80, $00, $9F, $2A, $02, $80, $00, $9D, $29, $01, $80, $00, $98, $3B, $02, $80, $00, $95, $2A, $03, $80, $00, 
	db $92, $34, $03, 
	db $80, $03, 
	db $FF, $2F, 
	
.label6283
	db $02, $04, $00, $00, $00, 
	dw .label628C | $2000, .label62D1 | $2000
.label628C
	db $00, 
	db $C0, $00, $00, 
	db $B1, $40, $02, 
	db $98, $15, $01, 
	db $80, $02, 
	db $98, $25, $01, 
	db $80, $03, 
	db $98, $30, $01, 
	db $80, $01, 
	db $98, $2C, $01, $80, $00, $96, $2F, $02, $80, $00, $95, $20, $01, $80, $00, $97, $32, $01, $80, $00, $96, $35, $01, $80, $00, $95, $38, $01, $80, $00, $97, $40, $01, $80, $00, $96, $30, $01, $80, $00, $95, $15, $01, $80, $03, $FF, $2F, 
.label62D1
	db $02, 
	db $C0, $01, $00, 
	db $B1, $40, $01, 
	db $9C, $40, $00, 
	db $80, $01, 
	db $9C, $35, $00, 
	db $80, $01, $9C, $40, $00, $80, $01, $9C, $30, $00, $80, $01, $9C, $40, $00, $80, $01, $9A, $30, $00, $80, $01, $98, $30, $00, $80, $01, $97, $35, $00, $80, $01, $96, $30, $00, $80, $01, $95, $30, $01, $80, $05, $9A, $50, $00, $80, $01, $99, $30, $00, $80, $01, $98, $35, $00, $80, $01, $98, $30, $00, $80, $01, $98, $30, $00, $80, $01, $97, $30, $00, $80, $01, $97, $35, $00, $80, $01, $96, $30, $00, $80, $01, $95, $35, $00, $80, $01, $95, $35, $01, $80, $03, $98, $30, $00, $80, $00, $97, $35, $00, $80, $00, $96, $35, $00, $80, $00, $95, $30, $00, $80, $00, $95, $30, $01, $80, $03, $FF, $2F, 
	
.label6357
	db $04, $00, $00, $00, $00, 
	dw .label635E | $2000
.label635E
	db $00, $C0, $01, $00, $B1, $40, $01, $9A, $41, $01, $80, $01, $92, $4A, $01, $80, $03, $FF, $2F, 
	
.label6371
	db $03, $00, $00, $00, $00, 
	dw .label6378 | $2000
.label6378 
	db $00, $C0, $03, $00, $B1, $40, $02, $9F, $55, $0A, $80, $02, $9F, $5A, $09, $80, $02, $9F, $5A, $09, $80, $02, $9F, $53, $09, $80, $02, $9F, $50, $09, $80, $02, $9F, $57, $09, $80, $02, $9F, $57, $08, $80, $02, $9F, $4E, $05, $80, $03, $FF, $2F, 
	
.label63A9
	db $02, $00, $00, $00, $00, 
	dw .label63B0 | $2000
.label63B0 
	db $00, $FD, $00, $00, $C0, $0E, $00, $B1, $40, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $9B, $4E, $02, $80, $02, $9B, $55, $02, $80, $02, $99, $4E, $02, $80, $02, $96, $55, $02, $80, $02, $92, $4E, $02, $80, $02, $92, $55, $02, $80, $02, $91, $4E, $02, $80, $4F, $FE, $7F, $FF, $2F, 
	
.label6422
	db $04, $00, $00, $00, $00, 
	dw .label6429 | $2000
.label6429
	db $00, $C0, $00, $00, $B1, $01, $01, $9F, $24, $01, $80, $03, $9F, $25, $01, $80, $01, $FF, $2F, 
	
.label643C
	db $03, $00, $00, $00, $00, 
	dw .label6443 | $2000
.label6443
	db $00, $FD, $FE, $00, $C0, $09, $00, $B1, $40, $01, $9E, $57, $1F, $80, $3A, $9E, $57, $1F, $80, $3A, $9E, $57, $1F, $80, $3A, $FE, $7F, $FF, $2F, 
	
.label6460
	db $04, $00, $00, $00, $00
	dw .label6467 | $2000
.label6467
	db $00, $C0, $01, $00, $B1, $40, $01, $98, $43, $01, $80, $01, $92, $48, $01, $80, $04, $9B, $40, $01, $80, $01, $93, $49, $01, $80, $03, $FF, $2F, 
	
.label6484
	db $02, $00, $00, $00, $00
	dw .label648B | $2000
.label648B
	db $00, $C0, $06, $00, $B1, $40, $01, $9E, $48, $04, $80, $02, $9E, $44, $04, $80, $01, $9E, $48, $04, $80, $02, $9E, $44, $04, $80, $01, $9E, $48, $04, $80, $02, $9E, $44, $04, $80, $03, $FF, $2F, 
	
	
.label64B2
	db $02, $00, $00, $00, $00
	dw .label64B9 | $2000
.label64B9
	db $00, $C0, $06, $00, $B1, $40, $01, $9C, $3A, $02, $80, $09, $9F, $3A, $0B, $80, $03, $FF, $2F, 
	
.label64CC
	db $02, $00, $00, $00, $00
	dw .label64D3 | $2000
.label64D3
	db $00, $C0, $01, $00, $B1, $40, $00, $98, $3F, $02, $80, $01, $96, $3F, $02, $80, $00, $98, $37, $01, $80, $00, $96, $2C, $03, $80, $00, $98, $4B, $01, $80, $00, $96, $2C, $02, $80, $00, $98, $2B, $01, $80, $00, $9C, $3D, $02, $80, $00, $9B, $2C, $01, $80, $00, $99, $34, $02, $80, $00, $98, $47, $01, $80, $00, $97, $4F, $03, $80, $03, $FF, $2F, 
	
.label6518
	db $03, $00, $00, $00, $00
	dw .label651F | $2000
.label651F
	db $00, $C0, $09, $00, $B1, $40, $01, $9F, $5E, $01, $80, $01, $9F, $5F, $01, $80, $02, $FF, $2F, 
	
.label6532
	db $02, $00, $00, $00, $00
	dw .label6539 | $2000
.label6539
	db $00, $C0, $07, $00, $B1, $40, $01, $99, $5E, $01, $80, $01, $99, $5F, $01, $80, $02, $FF, $2F, 
	
.label654C
	db $02, $00, $00, $00, $00
	dw .label6553 | $2000
.label6553
	db $00, $C0, $05, $00, $B1, $40, $01, $9F, $55, $01, $80, $01, $9E, $56, $01, $80, $01, $9D, $57, $01, $80, $01, $9B, $58, $01, $80, $01, $99, $49, $01, $80, $01, $97, $4A, $01, $80, $01, $95, $4B, $01, $80, $01, $93, $4C, $01, $80, $01, $92, $5D, $01, $80, $01, $91, $5E, $03, $80, $03, $FF, $2F, 
	
.label658E
	db $02, $00, $00, $00, $00
	dw .label6595 | $2000
.label6595
	db $00, $C0, $05, $00, $B1, $40, $01, $9F, $34, $01, $80, $02, $9E, $39, $01, $80, $01, $9D, $35, $01, $80, $01, $9C, $31, $01, $80, $01, $92, $31, $02, $80, $03, $FF, $2F, 
	
.label65B7
	db $04, $00, $00, $00, $00
	dw .label65BE | $2000
.label65BE
	db $00, $C0, $01, $00, $B1, $40, $01, $9F, $55, $04, $80, $02, $9A, $50, $01, $80, $02, $94, $4C, $01, $80, $03, $FF, $2F, 
	
.label65D6
	db $01, $00, $00, $00, $00
	dw .label65DD | $2000
.label65DD
	db $00, 
	db $C0, $01, $00, 
	db $B1, $40, $09, 
	db $9F, $16, $09, 
	db $E0, $01, $09, 
	db $E0, $02, $09, 
	db $E0, $03, $09, 
	db $E0, $04, $02, 
	db $80, $09, 
	db $FF, $2F, 
	
	
	db $00, $C0, $03, $02, $80, $03, $9B, $56, $01, $80, $01, $98, $53, $04, $80, $01, $94, $4C, $02, $80, $03, $FF, $2F, 


; track list
.Track_List ; [CF80]'th pointer is selected
	dw .Music0 | $2000
	dw .Music1 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000
	dw .Music0 | $2000



; commands:
;  < $80: 
; 
; 
;  < $90: 1E:5177
; 
;  < $A0: 1E:50FB
;         9× ×× ×× ××
; == $B1: 1E:50D5 (control flags of $cf89)
;         B1 ×× 
; == $E0: 1E:506F (control rNR43)
;         E0 ××
; == $E1: 1E:5095 (control rNR43)
;         E1 ××
; == $C0: 1E:50F3 (store param at $cf77)
;         C0 ××
; 
; set loop point (param = # of loops)
; == $FD: 1E:50AD (param to $cf7c, pointer to next command to $cf7a..b)
;         FD ××
; 
; loop
; == $FE: 1E:50BD
;         FE
; == $FF: 1E:51C7 -> 1E:5256 -> 1E:525E
;   ELSE: nop







.Music1
	db $04, ; number of affected channels
	db $00, ; skipped
	bigdw .Music1_Channel1 - .Music1 ; big-endian relative pointer from 662E
	bigdw .Music1_Channel2 - .Music1 ; big-endian relative pointer from 662E
	bigdw .Music1_Channel3 - .Music1 ; big-endian relative pointer from 662E
	bigdw .Music1_Channel4 - .Music1 ; big-endian relative pointer from 662E
.Music1_Channel3
.Music1_Channel2
	db $00, ; this+1 goes to CF14
	; pointer to this goes to CF10..1
	db $C0, $07, $00, 
	mus_set_loop_point
	note $F, D_3, 11
	db $80, 11
	note $F, E_3, 10
	db $80, 10
	note $F, F_3, 9
	db $80, 9
	note $F, G_3, 8
	db $80, 8
	note $F, A_3, 7
	db $80, 7
	note $F, B_3, 6
	db $80, 6
	note $F, C_4, 5
	db $80, 5
	note $F, D_4, 4
	db $80, 4
	note $F, E_4, 3
	db $80, 3
	note $F, F_4, 2
	db $80, 2
	note $F, G_4, 1
	db $80, 1
	note $F, A_4, 0
	mus_loop
	mus_end
.Music1_Channel1
.Music1_Channel4
	db $00, ; this+1 goes to CF04, CF14, CF24, CF34
	; pointer to this goes to CF00..1, CF10..1, CF20..1, CF30..1
	mus_end
.Music0
	db $04, ; number of affected channels
	db $00, ; skipped
	bigdw .Music0_Channel1 - .Music0 ; big-endian relative pointer from 7000
	bigdw .Music0_Channel2 - .Music0 ; big-endian relative pointer from 7000
	bigdw .Music0_Channel3 - .Music0 ; big-endian relative pointer from 7000
	bigdw .Music0_Channel4 - .Music0 ; big-endian relative pointer from 7000
.Music0_Channel1
.Music0_Channel2
.Music0_Channel3
.Music0_Channel4
	db $00, ; this+1 goes to CF04, CF14, CF24, CF34
	; pointer to this goes to CF00..1, CF10..1, CF20..1, CF30..1
	mus_end
.label700D
	; null-terminated 5-byte list. controls branch at 1E:41ED. decides which channel(s) to initialize
	db $01, $00, $00, $00, $00,
	dw $7037 
.label7014
	db $02, $00, $00, $00, $00, 
	dw $7037, 
.label701B
	db $03, $00, $00, $00, $00, 
	dw $7037, 
.label7022
	db $04, $00, $00, $00, $00, 
	dw $7037, 
.label7029
	db $01, $02, $03, $04, $00, 
	dw $7037, 
	dw $7037, 
	dw $7037, 
	dw $7037, 
.label7036
	db $00, 
.label7037
	db $00, 
	db $FF, $2F, 
.label703A
	db $02, $00, $00, $00, $00, 
	dw $7041, 
.label7041	
	db $00, 
	db $C0, $01, $00, 
	db $B1, $40, $00, 
	db $98, $3F, $02, 
	db $80, $01, 
	db $96, $3F, $02, 
	db $80, $00, 
	db $98, $37, $01, 
	db $80, $00, 
	db $96, $2C, $03, 
	db $80, $00, 
	db $98, $4B, $01, 
	db $80, $00, 
	db $96, $2C, $02, 
	db $80, $00, 
	db $98, $2B, $01, 
	db $80, $00, 
	db $9C, $3D, $02, 
	db $80, $00, 
	db $9B, $2C, $01, 
	db $80, $00, 
	db $99, $34, $02, 
	db $80, $00, 
	db $98, $47, $01, 
	db $80, $00, 
	db $97, $4F, $03, 
	db $80, $03, 
	db $FF, $2F, 
.label7086
	db $03, $00, $00, $00, $00, 
	db $8D, $70, $00, $C0, $09, $00, $B1, $40, $01, $9F, $5E, $01, $80, $01, $9F, $5F, $01, $80, $02, 
	db $FF, $2F, 
.label70A0
	db $02, $00, $00, $00, $00, 
	db $A7, $70, $00, $C0, $0F, $00, $B1, $40, $01, $99, $5E, $01, $80, $01, $99, $5F, $01, $80, $02, 
	db $FF, $2F, 
.label70BA
	db $02, $00, $00, $00, $00, 
	db $C1, $70, $00, $C0, $0F, $00, $B1, $40, $01, $9F, $55, $01, $80, $01, $9E, $56, $01, $80, $01, $9D, $57, $01, $80, $01, $9B, $58, $01, $80, $01, $99, $49, $01, $80, $01, $97, $4A, $01, $80, $01, $95, $4B, $01, $80, $01, $93, $4C, $01, $80, $01, $92, $5D, $01, $80, $01, $91, $5E, $03, $80, $03, 
	db $FF, $2F, 
.label70FC
	db $02, $00, $00, $00, $00, 
	db $03, $71, $00, $C0, $0F, $00, $B1, $40, $01, $9F, $34, $01, $80, $02, $9E, $39, $01, $80, $01, $9D, $35, $01, $80, $01, $9C, $31, $01, $80, $01, $92, $31, $02, $80, $03, 
	db $FF, $2F
