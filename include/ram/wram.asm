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

ds $89

wC1A0: db ; C1A0
wC1A1: db ; C1A1
wC1A2: db ; C1A2


wTextAttribute: db ; C1A3
wTextX: db ; C1A4
wC1A5: dw ; C1A5..6 ; output of APIFunction43, set to hl + wC1B5[0..2]
wTextY: db ; C1A7
wTextWidth: db ; C1A8
wTextHeight: db ; C1A9
wTextBoxBorder: db ; C1AA
wNextCharPointer: dw ; C1AB..C
wNextCharPointerBackup: dw ; C1AD..E
wTextVRAMBank: db ; C1AF

wC1B0: db ; C1B0
wC1B1: db ; C1B1
wC1B2: db ; C1B2
wC1B3: db ; C1B3
wC1B4: db ; C1B4
wC1B5: dw ; C1B5..6
wC1B7: db ; C1B7
wTextCond: db ; C1B8
wTextDepth: db ; C1B9
wC1BA: db ; C1BA
wC1BB: db ; C1BB
wC1BC: db ; C1BC
wC1BD: db ; C1BD
wC1BE: db ; C1BE
wC1BF: db ; C1BF

wTextCallbackAddress: dw ; C1C0..1
wC1C2: db ; C1C2
wC1C3: db ; C1C3
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
wC20A: dw ; C20A
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
wC219: dw ; C219
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

wC655: db ; C655
wC656: db
wC657: db
wC658: db
wC659: db
wC65A: db
wC65B: db
wC65C: db
wC65D: db
wC65E: db
wC65F: db
wC660: db
wC661: db
wC662: db
wC663: db
wC664: db
wC665: db
wC666: db
wC667: db
wC668: db
wC669: db
wC66A: db
wC66B: db
wMinigameFlashBank: db
wC66D: db
wC66E: db
wC66F: db
wC670: db
wC671: db
wC672: db
wC673: db
wC674: db
wC675: dw ; C675
wOpenFile::
wOpenFileData:: dw ; C677
wOpenFileIndex:: db ; C679

SECTION "WRAM Page 7", WRAM0[$C700]
wSYS0Copy::
wSYS0TextSpeed:: db
wSYS0Unknown1:: db
wSYS0PasswordSaved:: db
wSYS0CursorMode:: db
wSYS0SoundMode:: db
wSYS0HiddenLevel:: db
wSYS0PlayerCharacter:: db
wSYS0Unknown2:: db
wSYS0RoomLevel:: db
wSYS0Unknown3:: dw
wSYS0SavedPassword:: ds 15
wSYS0Unknown4:: ds 22


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
wTastePointReward: db ; C84D
wC84E: db ; C84E
wC84F: db ; C84F


















