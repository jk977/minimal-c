CC ?= gcc
AS ?= as
LD ?= ld

BUILD ?= ./build
SRC ?= ./src
LIB ?= ./lib

ARCH ?= 64

ifdef DEBUG
	CFLAGS += -g
	ASFLAGS += -g
endif

ifeq ($(ARCH),32)
	BOOTSTRAP = bootstrap32.o
else
	BOOTSTRAP = bootstrap64.o
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

