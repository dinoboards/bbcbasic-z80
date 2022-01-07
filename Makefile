SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

BIN := ./bin/
SRC := ./

SRCS := main exec eval fpp hardware cpm ram msxdist msxdist-cls msxdist-gettime

all: $(BIN)bbcbasic.com

bin/msxdist.o: msx.inc
bin/msxdist-cls.o: msx.inc
bin/msxdist-gettime.o: msx.inc

OBJ_FILES := $(addsuffix .o,$(addprefix $(BIN),$(SRCS)))

$(BIN)bbcbasic.com: $(OBJ_FILES)
	@z80asm -o$@ -b -m $(OBJ_FILES)
	echo "Assembled $@ from $(addsuffix .asm,$(SRCS))"

clean:
	@rm -f *.o *.err *.lis *.map *.com *.bin
	rm -rf bin

$(BIN)%.o: $(SRC)%.asm
	@mkdir -p bin
	z80asm -l -o$@ $^
	mv *.lis bin/
	mv *.o bin/
	errfile=$(notdir $(patsubst %.o,%.err,$@))
	([ -f $${errfile} ] && mv $${errfile} bin/) || true
	echo "Assembled $^ to $@"

