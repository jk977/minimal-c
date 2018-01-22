CC ?= gcc
AS ?= as
LD ?= ld

BUILD ?= ./build
SRC ?= ./src
LIB ?= ./lib

ifdef DEBUG
	CFLAGS += -g
	ASFLAGS += -g
endif

.PHONY: all clean purge

all: $(BUILD)/main.o $(BUILD)/bootstrap.o
	$(LD) $(LDFLAGS) -o $(BUILD)/main.elf $^

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

