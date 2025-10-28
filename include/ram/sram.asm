SECTION "SRAM Filesystem", SRAM

sFileEntryChecksum:: dw

sFileEntries::
MACRO file_entry_struct
sFileEntry\1::
sFileEntry\1Pointer:: dw
sFileEntry\1Name:: ds 4	
ENDM

DEF _loop_index = 0
REPT 130
file_entry_struct _loop_index
DEF _loop_index += 1
ENDR
PURGE _loop_index

sFileBlocks::
MACRO file_block_struct
sFile\1::
sFile\1Checksum:: dw
sFile\1Name:: ds 4
sFile\1Size:: dw
sFile\1Final:: db
sFile\1Data::
ENDM


file_block_struct SYS0
sTextSpeed:: db
sSYS0Unknown1:: db
sPasswordSaved:: db
sCursorMode:: db
sSoundMode:: db
sHiddenLevel:: db
sPlayerCharacter:: db
sSYS0Unknown2:: db
sRoomLevel:: db
sSYS0Unknown3:: dw
sSavedPassword:: ds 15
sSYS0Unknown4:: ds 22

file_block_struct SYS1
sSYS1Unknown1:: ds 8
sLevel1:: db
sLevel2:: db
sLevel3:: db
sSYS1Unknown2:: db
sEXP1:: db
sEXP2:: db
sEXP3:: db
sSYS1Unknown3:: db
sBox1Name:: ds 15
sBox2Name:: ds 15
sBox3Name:: ds 15
sBox4Name:: ds 15
sBox5Name:: ds 15
sBox6Name:: ds 15
sBox7Name:: ds 15
sGameArrangement::

DEF _loop_index = 0
REPT 128
sGameSlot{d:_loop_index}::
sGameSlot{d:_loop_index}Index:: db
sGameSlot{d:_loop_index}Box:: db
DEF _loop_index += 1
ENDR
PURGE _loop_index

sRecentGame8:: db
sRecentGame7:: db
sRecentGame6:: db
sRecentGame5:: db
sRecentGame4:: db
sRecentGame3:: db
sRecentGame2:: db
sRecentGame1:: db


file_block_struct G000
sG000HighScore:: dw
file_block_struct G001
sG000HighScore:: db
file_block_struct G002
sG002HighScore:: dw
file_block_struct G003
sG003Checkpoint:: db
file_block_struct G004
sG004HighScore:: db
file_block_struct G005
sG005HighScore:: dw
file_block_struct G006
sG006HighScore:: dw
file_block_struct G007
sG007HighScore:: db
file_block_struct G009
sG009HighScore:: db
file_block_struct G012
sG012HighScore:: ds 6
file_block_struct G013
sG013HighScore:: ds 3
