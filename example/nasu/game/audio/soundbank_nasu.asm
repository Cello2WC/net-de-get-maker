
Soundbank_NASU:
;LOAD "Soundbank_NASU", ROMX[Soundbank_NASU | $2000]
	dw SFX_List        | $2000 ; $617B  ; goes to CF92..3
	dw Track_List      | $2000 ; $660E  ; goes to CF90..1 ; Track list
	dw PU1_Instruments | $2000 ; $600C  ; goes to CF94..5 ; PU1 instruments
	dw PU2_Instruments | $2000 ; $603F  ; goes to CF96..7 ; PU2 instruments
	dw WAV_Instruments | $2000 ; $6061  ; goes to CF98..9 ; WAV instruments
	dw NOI_Instruments | $2000 ; $614B  ; goes to CF9A..B ; NOI instruments

PU1_Instruments: ; max of 0x20 entries
	db $00, $00, $00 ; padding
	db $00, $80, $00
	db $00, $00, $00
	db $1F, $00, $00
	db $2F, $40, $01
	db $26, $80, $01

PU2_Instruments: ; max of 0x20 entries
	db $00, $00 ; padding
	db $80, $00

WAV_Instruments: ; max of 0x20 values
	dw .WAVSquare | $2000
.WAVSquare
	db $00,$00,$00,$00,$00,$00,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
NOI_Instruments: ; max of 0x20 values

	const_def $80
	const NASU_SFX_SILENCE
	const NASU_SFX_GET
	const NASU_SFX_BONUS
	const NASU_SFX_LOSE
	const NASU_SFX_WALK1
	const NASU_SFX_WALK2
	const NASU_SFX_LAND
	const NASU_SFX_JUMP
SFX_List:
	dw Sfx_Silence | $2000
	dw Sfx_Get | $2000
	dw Sfx_Bonus | $2000
	dw Sfx_Lose | $2000
	dw Sfx_Walk1 | $2000
	dw Sfx_Walk2 | $2000
	dw Sfx_Land | $2000
	dw Sfx_Jump | $2000

Sfx_Silence:
	db $01, $02, $03, $04, $00
	dw .channel1 | $2000
	dw .channel2 | $2000
	dw .channel3 | $2000
	dw .channel4 | $2000
.channel1
.channel2
.channel3
.channel4
	db $00
	mus_end

Sfx_Get:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 0
;	db $B1, $40, $00
	note $F, E_4, 1
	note $F, G_4, 1
	note $F, B_4, 1
	note $F, C_5, 1
	note $F, D_5, 1
	note $F, E_5, 1
;	rest 1
	mus_end
	
Sfx_Bonus:
	db $03, $00, $00, $00, $00
	dw .channel3 | $2000
.channel3
	db $00
	
	instrument 0
;	db $B1, $40, $00
	note $F, E_5, 1
	rest 1
	note $F, F#5, 1
	rest 1
	note $F, G#5, 1
	rest 1
	note $F, F#5, 1
	rest 1
	note $F, G#5, 1
	rest 1
	note $F, A_5, 1
	rest 1
	note $F, G#5, 1
	rest 1
	note $F, A_5, 1
	rest 1
	note $F, A_5, 1
	rest 1
	note $F, C#6, 1
	rest 1
	note $F, D#6, 1
;	rest 1
	mus_end

Sfx_Lose:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 1
;	db $B1, $40, $00
	note $F, D#1, 2
	note $F, C#2, 1
	instrument 2
	note $F, C#2, 8
;	rest 1
	mus_end
	
Sfx_Walk1:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 3
;	db $B1, $40, $00
	note $8, G_3, 0
	rest 8
	mus_end
	
Sfx_Walk2:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 3
;	db $B1, $40, $00
	note $8, A#3, 0
	rest 8
	mus_end
	
Sfx_Land:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 3
;	db $B1, $40, $00
	note $8, B_3, 0
	rest 8
	mus_end
	
Sfx_Jump:
	db $01, $00, $00, $00, $00
	dw .channel1 | $2000
.channel1
	db $00
	
	instrument 4
;	db $B1, $40, $00
	note $F, F_3, 0
	rest 8
	mus_end


	const_def $80
	const SOUNDBANK_NASU_MUS_SILENCE
	const SOUNDBANK_NASU_MUS_TITLE
	const SOUNDBANK_NASU_MUS_GAME
	const SOUNDBANK_NASU_MUS_GAME_OVER
Track_List:
	dw Mus_Silence | $2000
	dw Mus_Title | $2000
	dw Mus_Game | $2000
	dw Mus_Game_Over | $2000


Mus_Silence:
	db $04, ; number of affected channels
	db $00, ; padding??
	bigdw .channel1 - Mus_Silence ; big-endian relative pointer from 7000
	bigdw .channel2 - Mus_Silence ; big-endian relative pointer from 7000
	bigdw .channel3 - Mus_Silence ; big-endian relative pointer from 7000
	bigdw .channel4 - Mus_Silence ; big-endian relative pointer from 7000
.channel1
.channel2
.channel3
.channel4
	db $00, ; this+1 goes to CF04, CF14, CF24, CF34
	; pointer to this goes to CF00..1, CF10..1, CF20..1, CF30..1
	mus_end


DEF MUSIC1_TEMPO EQU 19
Mus_Title:
	db $04 ; number of affected channels
	db $00 ; padding??
	bigdw .channel1 - Mus_Title ; big-endian relative pointer from 662E
	bigdw .channel2 - Mus_Title ; big-endian relative pointer from 662E
	bigdw .channel3 - Mus_Title ; big-endian relative pointer from 662E
	bigdw .channel4 - Mus_Title ; big-endian relative pointer from 662E
.channel1
	db $00 ; this+1 goes to CF14
	
	instrument 0 
	mus_set_loop_point
	rest 1 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, F_4, 2 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, C_4, 1 * MUSIC1_TEMPO
	note $F, B_3, 1 * MUSIC1_TEMPO
	note $F, C_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, C_4, 2 * MUSIC1_TEMPO
	note $F, B_3, 1 * MUSIC1_TEMPO
	note $F, C_4, 1 * MUSIC1_TEMPO
	
	rest 1 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, F_4, 2 * MUSIC1_TEMPO
	note $F, E_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, C_4, 1 * MUSIC1_TEMPO
	note $F, B_3, 1 * MUSIC1_TEMPO
	note $F, C_4, 1 * MUSIC1_TEMPO
	note $F, D_4, 1 * MUSIC1_TEMPO
	note $F, C_4, 4 * MUSIC1_TEMPO
	mus_loop
	mus_end
.channel2
	db $00 ; this+1 goes to CF14
	
	instrument 0 
	mus_set_loop_point
	note $F, C_3, 4 * MUSIC1_TEMPO
	note $F, F_3, 4 * MUSIC1_TEMPO
	note $F, G_3, 4 * MUSIC1_TEMPO
	note $F, F_3, 4 * MUSIC1_TEMPO
	note $F, C_3, 4 * MUSIC1_TEMPO
	note $F, F_3, 4 * MUSIC1_TEMPO
	note $F, G_3, 2 * MUSIC1_TEMPO
	note $F, D_3, 2 * MUSIC1_TEMPO
	note $F, C_3, 4 * MUSIC1_TEMPO
	mus_loop
	mus_end

.channel3
.channel4
	db $00
	mus_end
	
DEF MUS_GAME_TEMPO EQU 17
Mus_Game:
	db $04, ; number of affected channels
	db $00, ; padding??
	bigdw .channel1 - Mus_Game ; big-endian relative pointer from 7000
	bigdw .channel2 - Mus_Game ; big-endian relative pointer from 7000
	bigdw .channel3 - Mus_Game ; big-endian relative pointer from 7000
	bigdw .channel4 - Mus_Game ; big-endian relative pointer from 7000
.channel2
	db $00
	instrument 0 
	mus_set_loop_point
	note $F, C_2, 1 * MUS_GAME_TEMPO
	rest 1 * MUS_GAME_TEMPO
	note $F, E_3, 1 * MUS_GAME_TEMPO
	note $F, G_3, 1 * MUS_GAME_TEMPO
	rest 4 * MUS_GAME_TEMPO
	note $F, E_2, 1 * MUS_GAME_TEMPO
	rest 1 * MUS_GAME_TEMPO
	note $F, E_3, 1 * MUS_GAME_TEMPO
	note $F, G_3, 1 * MUS_GAME_TEMPO
	rest 4 * MUS_GAME_TEMPO
	mus_loop
	mus_end
.channel1
.channel3
.channel4
	db $00, ; this+1 goes to CF04, CF14, CF24, CF34
	; pointer to this goes to CF00..1, CF10..1, CF20..1, CF30..1
	mus_end
	
DEF MUS_GAME_OVER_TEMPO EQU 24
Mus_Game_Over:
	db $04 ; number of affected channels
	db $00 ; padding??
	bigdw .channel1 - Mus_Game_Over ; big-endian relative pointer from 662E
	bigdw .channel2 - Mus_Game_Over ; big-endian relative pointer from 662E
	bigdw .channel3 - Mus_Game_Over ; big-endian relative pointer from 662E
	bigdw .channel4 - Mus_Game_Over ; big-endian relative pointer from 662E
.channel1
	db $00 ; this+1 goes to CF14
	
	instrument 0 
	
	note $F, C_3, 2 * MUS_GAME_OVER_TEMPO
	note $F, D_3, 1 * MUS_GAME_OVER_TEMPO
	note $F, E_3, 1 * MUS_GAME_OVER_TEMPO
	
	note $F, F_3, 2 * MUS_GAME_OVER_TEMPO
	note $F, E_3, 1 * MUS_GAME_OVER_TEMPO
	note $F, F_3, 1 * MUS_GAME_OVER_TEMPO
	
	note $F, A_3, 1 * MUS_GAME_OVER_TEMPO
	note $F, G_3, 1 * MUS_GAME_OVER_TEMPO
	note $F, A_3, 1 * MUS_GAME_OVER_TEMPO
	note $F, B_3, 1 * MUS_GAME_OVER_TEMPO
	
	note $F, C_3, 4 * MUS_GAME_OVER_TEMPO
	
	mus_end
.channel2
	db $00 ; this+1 goes to CF14
	
	instrument 0 
	
	note $F, C_2, 4 * MUS_GAME_OVER_TEMPO
	note $F, D_2, 4 * MUS_GAME_OVER_TEMPO
	note $F, F_2, 2 * MUS_GAME_OVER_TEMPO
	note $F, G_2, 2 * MUS_GAME_OVER_TEMPO
	note $F, C_2, 4 * MUS_GAME_OVER_TEMPO
	
	mus_end

.channel3
.channel4
	db $00
	mus_end