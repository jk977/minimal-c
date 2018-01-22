CC ?= gcc
AS ?= as
LD ?= ld

BUILD ?= ./build
SRC ?= ./src
LIB ?= ./lib

# ARCH can either be 32 or 64
ARCH ?= 64
BOOTSTRAP = bootstrap$(ARCH).o

ifeq ($(ARCH),32)
	CFLAGS += -m32
	ASFLAGS += --32
	LDFLAGS += -melf_i386
endif

ifdef DEBUG
	CFLAGS += -g
	ASFLAGS += -g
endif

.PHONY: all clean purge

all: $(BUILD)/main.o $(BUILD)/$(BOOTSTRAP)
	$(LD) $(LDFLAGS) -nostdlib -o $(BUILD)/main.elf $^

clean:
	rm -f build/*.o

purge: clean
	rm -f $(BUILD)/*.elf

$(BUILD):
	mkdir -p $@

$(BUILD)/%.o: $(SRC)/%.c $(BUILD) 
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD)/%.o: $(LIB)/%.s $(BUILD) 
	$(AS) $(ASFLAGS) -o $@ $<

