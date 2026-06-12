; ----- Filesystem functions -----


; APIValidateFilesystem -- 01B3
; 
; Checks SRAM filesystem for a valid checksum.
; If it's invalid, attempts to rebuild the filesystem.
; If that fails, deletes the filesystem. (?????)
APIValidateFilesystem::
	jp $0c6a


; APIOpenFile -- 01B6
; 
; Retrieves a pointer to a file with the given name,
; creating that file if necessary.
; 
; Returns an error code if the file's header points to the wrong data, 
; or if the filesystem is out of space for the file.
; 
; @param	bc	Requested file size. (Only used if the file is being created)
; @param	de	Pointer to filename string. (Max. 4 bytes)
;               It is standard to name your game's save file after its game ID.
;               
;               Pro-tip: You can set `de` to GameHeader_GameID ($4009) to grab the
;               game ID straight from your game's header!
; 
; @return	b	Return state, from [FOUND_OR_CREATED, ENTRIES_FULL, BAD_FILENAME_OR_NO_SPACE, UNKNOWN_ERROR]
; @return	c	1 if a new file was created, 0 otherwise
; @return	hl and wOpenFileData		Pointer to file data, after block header, 
;                                       or 0 if it could not be found or created.
; @return	a  and wOpenFileIndex		File's index, or $FF if none could be found or created.
APIOpenFile::
	jp $0ca5


; APICloseFile -- 01B9
; 
; Fixes open file's checksum,
; and closes SRAM.
APICloseFile::
	jp $0d30


; APIDeleteFile -- 01BC
; 
; Deletes a file from the SRAM filesystem.
; 
; Returns an error code if the file wasn't found,
; OR IF THE FILE IN QUESTION IS CORRUPTED,
; EITHER BY FILENAME, OR BY CHECKSUM.
; 
; This function CANNOT delete a corrupted file.
; For some reason.
; 
; @param	de	Pointer to filename string. (Max. 4 bytes)
;               
;               Pro-tip: You can set `de` to GameHeader_GameID ($4009) to grab the
;               game ID straight from your game's header!
; 
; @return	a	Return code, from [0 = OK, -1 = NOT_FOUND, -2 = BAD_FILENAME, -3 = BAD_CHECKSUM].
APIDeleteFile::
	jp $0d50


; APIFileBlockChecksum -- 01BF
; 
; Returns the expected checksum for a given file block.
; 
; @param	a	File index.
; 
; @return	bc	Calculated file checksum.
APIFileBlockChecksum::
	jp $0f15


; APIFileSystemChecksum -- 01C2
; 
; Calculates the expected checksum for the SRAM filesystem,
; and returns whether it matches the stored checksum.
; 
; @return	de		Calculated checksum for file system.
; @return	hl		Stored checksum for file system.
; @return	zflag	Whether these checksums are equal.
APIFileSystemChecksum::
	jp $106d


; APIRebuildFileEntries -- 01C5
; 
; Rebuilds the file entry table (0:A000-0:A30D),
; based on the file block table (0:A30E-1:BFFF)
; 
; @return	a	Number of files processed.
; @return	c	0 if table was rebuilt, 1 if it was already valid.
APIRebuildFileEntries::
	jp $108e


; APIEraseSRAMBank -- 01C8
; 
; Zeroes-out bank `a` of SRAM.
; 
; @param	a	SRAM bank to zero out.
APIEraseSRAMBank::
	jp $113e

; APIGetFileEntry -- 01CB
; 
; Returns pointer to the header of a given file in the SRAM filesystem.
; Strictly speaking, just returns `$A002 + (a*6)` in de.
; 
; @param	a	File index to retrieve.
; 
; @return	de	Pointer to a'th file's entry.
APIGetFileEntry::
	jp $114f


; APIGetFileBlock -- 01CE
; 
; Returns pointer to the block data of a given file in the SRAM filesystem.
; 
; @param	a	File index to retrieve.
; 
; @return	de	Pointer to a'th file's block data.
APIGetFileBlock::
	jp $1162


; APISetOpenFile -- 01D1
; 
; Sets wOpenFile to `ahl` in little-endian.
; Preserves all registers.
; 
; @param	hl	File data pointer (after header).
; @param	a	File index, or $FF if the file doesn't exist.
APISetOpenFile::
	jp $1176
