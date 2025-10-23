
DEF wVOAM equ $C000



DEF wTileMap equ $D000
DEF wTempTileBuffer equ $D168


DEF wHighScore equ $D7F0
DEF wCode equ $D7F2
DEF wGlobalTimer equ $DFFF
DEF wStartTimer equ $D800
DEF wScore equ $D801
DEF wNasuX equ $D804
DEF wNasuY equ $D805
DEF wNasuFrame equ $D806
DEF wNasuJumpTimer equ $D807
DEF wEggplantX equ $D808
DEF wEggplantY equ $D809
DEF wBonusX equ $D80A
DEF wBonusY equ $D80B
DEF wBonusTimer equ $D80C
DEF wPts1X equ $D80D
DEF wPts1Y equ $D80E
DEF wPts1Timer equ $D80F
DEF wPts2X equ $D810
DEF wPts2Y equ $D811
DEF wPts2Timer equ $D812
DEF wFlags equ $D813
;      0 - doubleget
;      1 - new red eggplant
;      2 - cheater
DEF wFlashPal equ $D814

DEF wTempDrawNum equ $D900


DEF hVBGPalDest equ $D9A0
DEF hVBGPalW equ $D9A2
DEF hVBGPalH equ $D9A3
DEF hVBGPalI equ $D9A4

DEF hVCopySrc equ $D9B0
DEF hVCopyDest equ $D9B2
DEF hVCopyLen equ $D9B4

DEF hVBGCopySrc equ $D9B8
DEF hVBGCopyDest equ $D9BA
DEF hVBGCopyLen equ $D9BC



DEF hRNG equ $D9C0

DEF hVBlankFlag equ $D9D0
DEF hCopyTo equ $D9D1
DEF hLYCMode equ $D9D2

DEF hHeldButtons equ $D9F0
DEF hPressedButtons equ $D9F1
DEF hPressedButtonCheck equ $D9F2


DEF wSoundData equ $DA00
DEF wMusicStepCount equ $DA00
DEF wMusicFramesPerStep equ $DA01
DEF wSFXStepCount equ $DA02
DEF wSFXFramesPerStep equ $DA03
DEF wImportantSFX equ $DA04
DEF wCh1Ptr equ $DA10
DEF wCh1WaitTicks equ $DA12
DEF wCh1LenAndDuty equ $DA13
DEF wCh1Envelope equ $DA14

		;CHANNEL_DATA_SIZE equ wCh2WaitTicks - wCh1WaitTicks
DEF CHANNEL_DATA_SIZE equ wCh1Envelope - wCh1Ptr + 1
DEF wCh2Ptr equ wCh1Ptr + CHANNEL_DATA_SIZE
DEF wCh3Ptr equ wCh2Ptr + CHANNEL_DATA_SIZE
DEF wCh4Ptr equ wCh3Ptr + CHANNEL_DATA_SIZE
DEF wCh5Ptr equ wCh4Ptr + CHANNEL_DATA_SIZE
DEF wCh6Ptr equ wCh5Ptr + CHANNEL_DATA_SIZE
DEF wCh7Ptr equ wCh6Ptr + CHANNEL_DATA_SIZE
DEF wCh8Ptr equ wCh7Ptr + CHANNEL_DATA_SIZE

;wStack equ $DFFF