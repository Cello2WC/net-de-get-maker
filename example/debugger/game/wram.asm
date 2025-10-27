SECTION "WRAM2", WRAMX

;hSPBuffer:: dw
;hTilesPerCycle:: db
ds $80

hJoypadReleased:: db
hJoypadPressed:: db
hJoypadDown:: db
hJoypadSum:: db

;wTilemap:: ds SCREEN_WIDTH * SCREEN_HEIGHT

wMenuOption:: db
wCallA:: dw
wCallBC:: dw
wCallDE:: dw
wCallHL:: dw
wCallFunc:: dw
