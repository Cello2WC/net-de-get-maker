dbuser ?=
dbpass ?=

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBLINK ?= $(RGBDS)rgblink

all: 
	$(RGBASM) main.asm -o main.o
	$(RGBLINK) main.o -o bin/game.bin
	python3 ./fix.py game.bin
	
push:
	python3 ./push.py game.bin "$(dbuser)" "$(dbpass)"
	
andpush: all push