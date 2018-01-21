CC = gcc
CFLAGS = -ansi

ifdef DEBUG
	CFLAGS += -g
endif

main : main.o
	$(CC) $(CFLAGS) -nostdlib -o main main.o
	rm main.o
