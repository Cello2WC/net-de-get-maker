	def_megasprites NASU

	def_megasprite BIRD
	def_megasprite_frame STAND_RIGHT
	object 0, 0, $C5, %00000001
	object 0, 8, $C6, %00000001
	object 8, 0, $C7, %00000001
	object 8, 8, $C8, %00000001
	end_megasprite_frame
	def_megasprite_frame WALK_RIGHT_1
	object 0, 0, $C9, %00000001
	object 0, 8, $CA, %00000001
	object 8, 0, $CB, %00000001
	object 8, 8, $CC, %00000001
	end_megasprite_frame
	def_megasprite_frame WALK_RIGHT_2
	object 0, 0, $CD, %00000001
	object 0, 8, $CE, %00000001
	object 8, 0, $CF, %00000001
	object 8, 8, $D0, %00000001
	end_megasprite_frame
	def_megasprite_frame JUMP_RIGHT
	object 0, 0, $D1, %00000001
	object 0, 8, $D2, %00000001
	object 8, 0, $D3, %00000001
	object 8, 8, $D4, %00000001
	end_megasprite_frame

	def_megasprite_frame STAND_LEFT
	object 0, 8, $C5, %00100001
	object 0, 0, $C6, %00100001
	object 8, 8, $C7, %00100001
	object 8, 0, $C8, %00100001
	end_megasprite_frame
	def_megasprite_frame WALK_LEFT_1
	object 0, 8, $C9, %00100001
	object 0, 0, $CA, %00100001
	object 8, 8, $CB, %00100001
	object 8, 0, $CC, %00100001
	end_megasprite_frame
	def_megasprite_frame WALK_LEFT_2
	object 0, 8, $CD, %00100001
	object 0, 0, $CE, %00100001
	object 8, 8, $CF, %00100001
	object 8, 0, $D0, %00100001
	end_megasprite_frame
	def_megasprite_frame JUMP_LEFT
	object 0, 8, $D1, %00100001
	object 0, 0, $D2, %00100001
	object 8, 8, $D3, %00100001
	object 8, 0, $D4, %00100001
	end_megasprite_frame
	end_megasprite

	def_megasprite BIRD_CHEATER
	def_megasprite_frame STAND_RIGHT
	object -4, 0, $DA, %00000010
	object -4, 8, $DB, %00000010
	object  4, 0, $DC, %00000010
	object  4, 8, $DD, %00000010
	object 8, 0, $C7, %00000001
	object 8, 8, $D5, %00000001
	end_megasprite_frame
	def_megasprite_frame WALK_RIGHT_1
	object -4, 0, $DA, %00000010
	object -4, 8, $DB, %00000010
	object  4, 0, $DC, %00000010
	object  4, 8, $DD, %00000010
	object 8, 0, $CB, %00000001
	object 8, 8, $D6, %00000001
	end_megasprite_frame
	def_megasprite_frame WALK_RIGHT_2
	object -3, 0, $DA, %00000010
	object -3, 8, $DB, %00000010
	object  5, 0, $DC, %00000010
	object  5, 8, $DD, %00000010
	object 8, 0, $CF, %00000001
	object 8, 8, $D7, %00000001
	end_megasprite_frame
	def_megasprite_frame JUMP_RIGHT
	object -3, 0, $DA, %00000010
	object -3, 8, $DB, %00000010
	object  5, 0, $DC, %00000010
	object  5, 8, $DD, %00000010
	object 8, 0, $D8, %00000001
	object 8, 8, $D9, %00000001
	end_megasprite_frame

	def_megasprite_frame STAND_LEFT
	object -4, 8, $DA, %00100010
	object -4, 0, $DB, %00100010
	object  4, 8, $DC, %00100010
	object  4, 0, $DD, %00100010
	object 8, 8, $C7, %00100001
	object 8, 0, $D5, %00100001
	end_megasprite_frame
	def_megasprite_frame WALK_LEFT_1
	object -4, 8, $DA, %00100010
	object -4, 0, $DB, %00100010
	object  4, 8, $DC, %00100010
	object  4, 0, $DD, %00100010
	object 8, 8, $CB, %00100001
	object 8, 0, $D6, %00100001
	end_megasprite_frame
	def_megasprite_frame WALK_LEFT_2
	object -3, 8, $DA, %00100010
	object -3, 0, $DB, %00100010
	object  5, 8, $DC, %00100010
	object  5, 0, $DD, %00100010
	object 8, 8, $CF, %00100001
	object 8, 0, $D7, %00100001
	end_megasprite_frame
	def_megasprite_frame JUMP_LEFT
	object -3, 8, $DA, %00100010
	object -3, 0, $DB, %00100010
	object  5, 8, $DC, %00100010
	object  5, 0, $DD, %00100010
	object 8, 8, $D8, %00100001
	object 8, 0, $D9, %00100001
	end_megasprite_frame
	end_megasprite


	def_megasprite EGGPLANT
	def_megasprite_frame PURPLE
	object 0, 0, $E1, %00000010
	end_megasprite_frame
	def_megasprite_frame RED
	object 0, 0, $E1, %00010011
	end_megasprite_frame
	end_megasprite

	def_megasprite POINTS
	def_megasprite_frame TEN
	object 0, 0, $DE, %00000000
	end_megasprite_frame
	def_megasprite_frame THREE_HUNDRED
	object 0, 0, $DF, %00000000
	object 0, 8, $E0, %00000000
	end_megasprite_frame
	end_megasprite

	end_megasprites

