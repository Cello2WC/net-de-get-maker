; APILoadSong - 0246
; 
; Loads song data into the audio engine, but doesn't play it.
; 
; @param	de	song id + 0x20
; @param	hl	default audio engine parameters pointer? (usually 0x6000)
; 
; @see		APIPlaySong
APILoadSong::
	jp $21d7

; [rBankBNum ($37FF)],            [wBankBNumBackup]    = [$C663]
; [rBankBRomFlashSelect ($3800)], [wBankBSelectBackup] = [$C664]
; [rBankANum ($27FF)],            [wBankANumBackup]    = $1E
; [rBankARomFlashSelect ($2800)], [wBankASelectBackup] = $00
; call $4000
; if [$C672] == 0 then:
;     [rBankANum ($27FF)],            [wBankANumBackup]    = [$FFAB]
;     [rBankARomFlashSelect ($2800)], [wBankASelectBackup] = [$FFAC]
;     [rBankBNum ($37FF)],            [wBankBNumBackup]    = [$FFAD]
;     [rBankBRomFlashSelect ($3800)], [wBankBSelectBackup] = [$FFAE]
; else:
;     [rBankANum ($27FF)] =            [$CB81]
;     [rBankARomFlashSelect ($2800)] = [$CB82]
;     [rBankBNum ($37FF)] =            [$CB83]
;     [rBankBRomFlashSelect ($3800)] = [$CB84]
; end
;     

; well this sure does SOMETHING to the music!
APIFunction53:: ; 0249
	jp $2242

; APIPlaySong -- 024C
; 
; Plays song data last loaded by APILoadSong [0246]
; 
; @param	a	? (usually $81) [goes to $CF80, $C66B, $C665]
; 
; @see		APILoadSong
APIPlaySong::
	jp $22a7
	
; APISilenceAudio -- 024F
; 
; silences all currently playing notes,
; but does NOT stop music from continuing to play
;
; @param	a	? (usually $80) [goes to $CF82]
APISilenceAudio::
	jp $230c
	
; APIStopAudio -- 0252
;
; silences all currently playing notes,
; AND stops music from continuing
APIStopAudio::
	jp $235f
	
	
; APIFadeAudio -- 0255
; 
; Fades audio to silence,
; over the course of about a second.
APIFadeAudio:: ; 0255
	jp $23cc
