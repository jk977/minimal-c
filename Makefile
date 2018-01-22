CC ?= gcc
AS ?= as
LD ?= ld
BUILDPATH ?= ./build

ifdef DEBUG
	CFLAGS += -g
	ASFLAGS += -g
endif

.PHONY: all clean purge

all: $(BUILDPATH)/main.o $(BUILDPATH)/bootstrap.o
	$(LD) $(LDFLAGS) -o $(BUILDPATH)/main.elf $^

clean:
	rm -f build/*.o

purge: clean
	rm -f $(BUILDPATH)/*.elf

$(BUILDPATH):
	mkdir -p $@

$(BUILDPATH)/%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(BUILDPATH)/%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $^

