SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

BIN := ./bin/
SRC := ./

SRCS := main exec eval fpp hardware cpm ram

OBJ_FILES := $(addsuffix .o,$(addprefix $(BIN),$(SRCS)))

$(BIN)bbcbasic.com: $(OBJ_FILES)
	@z80asm -o$@ -b -m $(OBJ_FILES)
	echo "Assembled $@ from $(addsuffix .asm,$(SRCS))"

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin
	rm -rf bin

$(BIN)%.o: $(SRC)%.asm
	@mkdir -p bin
	z80asm -l -o$@ $^
	mv $(notdir $@) bin/
	mv $(notdir $(patsubst %.o,%.lis,$@)) bin/
	errfile=$(notdir $(patsubst %.o,%.err,$@))
	([ -f $${errfile} ] && mv $${errfile} bin/) || true
	echo "Assembled $^ to $@"

