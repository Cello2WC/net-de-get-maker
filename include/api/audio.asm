; APILoadSoundBank - 0246
; 
; Loads song data into the audio engine, but doesn't play it.
; 
; @param	d	Sound Bank Select
; @param	e	Sound Bank ID
; @param	hl	Sound Data Pointer (From bank B, so 0x6000 - 0x7FFF)
; 
; @see		APIPlaySong
APILoadSoundBank::
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
; Maybe APIPlaySFX?
APIFunction53:: ; 0249
	jp $2242

; APIPlaySong -- 024C
; 
; Plays song from data loaded by APILoadSoundBank [0246]
; 
; @param	a	Song ID in this sound bank, with bit 7 set.
; 
; @see		APILoadSoundBank
APIPlaySong::
	jp $22a7
	
; APIPlaySFX -- 024F
; 
; Plays sound effect from data loaded by APILoadSoundBank [0246]
;
; @param	a	SFX ID in this sound bank, with bit 7 set.
;
; @see		APILoadSoundBank
APIPlaySFX::
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
