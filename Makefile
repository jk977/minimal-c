# Options:
# 	- all:		compile object files and main.c, create executable
# 	- lib:		generate object file with bitness ${ARCH} (32 or 64)
# 	- clean: 	remove all object files from build directory
# 	- purge:	clean and remove executables from build directory

CC ?= gcc
AS ?= as
LD ?= ld

BUILD ?= ./build
SRC ?= ./src
LIB ?= ./lib

# ARCH can be one of the following (see lib/*.s):
# 	- x86_64
# 	- x86_32
# 	- armhf

ARCH ?= x86_64
BOOTSTRAP = $(ARCH).o

ifeq ($(ARCH),32)
	CFLAGS += -m32
	ASFLAGS += --32
	LDFLAGS += -melf_i386
endif

ifdef DEBUG
	CFLAGS += -g
	ASFLAGS += -g
endif

.PHONY: all lib clean purge

all: $(BUILD)/main.o $(BUILD)/$(BOOTSTRAP)
	$(LD) $(LDFLAGS) -nostdlib -o $(BUILD)/main.elf $^

lib: $(BUILD)/$(BOOTSTRAP)

clean:
	rm -f $(BUILD)/*.o

purge: clean
	rm -f $(BUILD)/*.elf

$(BUILD):
	mkdir -p $@

$(BUILD)/%.o: $(SRC)/%.c $(BUILD) 
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: $(LIB)/%.s $(BUILD) 
	$(AS) $(ASFLAGS) -o $@ $<

