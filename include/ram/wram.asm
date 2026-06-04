SECTION "WRAM", WRAM0
wShadowOAM:: ds 4*40 ; $C000

ds $60 ; C0A0

SECTION "WRAM Page 1", WRAM0[$C100]
wC100: db ; C100
wC101: db ; C101
wC102: db ; C102
wC103: db ; C103
wC104: db ; C104
wC105: db ; C105
wC106: db ; C106
wC107: db ; C107
wC108: db ; C108
wC109: db ; C109
wC10A: db ; C10A
wC10B: db ; C10B
wC10C: db ; C10C
wC10D: db ; C10D
wC10E: db ; C10E
wC10F: db ; C10F
wC110: db ; C110
wC111: db ; C111
wC112: db ; C112

wBankANumBackup:    db ; C113
wBankASelectBackup: db ; C114

wBankBNumBackup:    db ; C115
wBankBSelectBackup: db ; C116

ds $AD

wC1C4: db ; C1C4
wC1C5: dw ; C1C5..6
wC1C7: db ; C1C7
wC1C8: dw ; C1C8..9
wC1CA: ; C1CA

ds $36


SECTION "WRAM Page 2", WRAM0[$C200]

wC200: db ; C200
wC201: db ; C201
wC202: db ; C202
wC203: db ; C203
wC204: db ; C204
wC205: db ; C205
wC206: db ; C206
wC207: db ; C207
wC208: db ; C208
wC209: db ; C209
wC20A: db ; C20A
wC20B: db ; C20B
wC20C: db ; C20C
wC20D: db ; C20D
wC20E: db ; C20E
wC20F: db ; C20F
wC210: db ; C210
wC211: db ; C211
wC212: db ; C212
wC213: db ; C213
wMenuChoice: db ; C214
wC215: db ; C215
wC216: db ; C216
wC217: db ; C217
wC218: db ; C218
wC219: db ; C219
wC21A: db ; C21A
wC21B: db ; C21B
wC21C: db ; C21C
wC21D: db ; C21D
wC21E: db ; C21E

wPalUnpackScale:: db ; C21F
wPalPackScale:: db ; C220
; 1 if palettes to update, 0 otherwise
wPalUpdate:: db ; C221
wBGPals1:: ds 8*4*2 ; C222
wOBPals1:: ds 8*4*2
wIntermediatePals:: ds 16*4*2*3 ; C2A2
wUnpackedPalettes:: ds 8*4*2*3 ; C422

ds $173	; C4E2

ds $20 ; C655

dw ; C675
wOpenFile::
wOpenFileData:: dw ; C677
wOpenFileIndex:: db ; C679


SECTION "WRAM Page 8", WRAM0[$C800]

wC800: db ; C800
wC801: db ; C801
wC802: db ; C802
wC803: db ; C803
wC804: db ; C804
wC805: db ; C805
wC806: db ; C806
wC807: db ; C807
wC808: db ; C808
wC809: db ; C809
wC80A: db ; C80A
wC80B: db ; C80B
wC80C: db ; C80C
wC80D: db ; C80D
wC80E: db ; C80E
wC80F: db ; C80F
wC810: db ; C810
wC811: db ; C811
wC812: db ; C812
wC813: db ; C813
wC814: db ; C814
wC815: db ; C815
wC816: db ; C816
wC817: db ; C817
wC818: db ; C818
wC819: db ; C819
wC81A: db ; C81A
wGameOverLine1: ds 24 ; C81B
wGameOverLine2: ds 24 ; C833
wReactPointReward: db ; C84B
wSmartPointReward: db ; C84C
wSensePointReward: db ; C84D
wC84E: db ; C84E
wC84F: db ; C84F


















