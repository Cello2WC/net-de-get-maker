;
;
; @param	\1	Name of this megasprite table
MACRO def_megasprites
	REDEF _MEGASPRITES_LABEL EQUS "MEGASPRITE_\1"
	DEF _NUM_{_MEGASPRITES_LABEL} = 0
ENDM

; Generates a unique constant for this MegaSprite.
; For example, something like
; MEGASPRITE_NASU_BIRD
; Always prefixed with "MEGASPRITE_"
; Followed by the name of the MegaSprite Table it belongs to,
; Followed by the unique name for this sprite given in \1
; 
; @param	\1	Name of this MegaSprite
MACRO def_megasprite
	REDEF _MEGASPRITE_LABEL EQUS "\1"
	DEF {_MEGASPRITES_LABEL}_{_MEGASPRITE_LABEL} EQU {_NUM_{_MEGASPRITES_LABEL}}
	DEF _NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}} = 0
ENDM

; Generates a unique constant for this MegaSprite frame.
; For example, something like
; MEGASPRITE_NASU_BIRD_WALK1
; 
; @param	\1	Name of this frame
MACRO def_megasprite_frame
	REDEF _MEGASPRITE_FRAME_LABEL EQUS "\1"
	DEF {_MEGASPRITES_LABEL}_{_MEGASPRITE_LABEL}_{_MEGASPRITE_FRAME_LABEL} EQU {_NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}}

{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_{_NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}}_Begin:
	db ({_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_{_NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}}_End - ({_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_{_NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}}_Begin + 1)) / 4
ENDM


; @param	\1	Y-Position
; @param	\2	X-Position
; @param	\3	Tile ID
; @param	\4	Attributes
MACRO object
	db \1, \2, \3, \4
ENDM


MACRO end_megasprite_frame
{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_{_NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}}_End:
	DEF _NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}} += 1
ENDM

MACRO end_megasprite
{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_Frames:
DEF _i = 0
REPT _NUM_FRAMES_{_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}
	dw {_MEGASPRITES_LABEL}_{_NUM_{_MEGASPRITES_LABEL}}_{_i}_Begin
	DEF _i += 1
ENDR
PURGE _i
	DEF _NUM_{_MEGASPRITES_LABEL} += 1
ENDM

MACRO end_megasprites
{_MEGASPRITES_LABEL}:
DEF _i = 0
REPT _NUM_{_MEGASPRITES_LABEL}
	dw {_MEGASPRITES_LABEL}_{_i}_Frames
	DEF _i += 1
ENDR
PURGE _i
ENDM