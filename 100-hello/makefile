
# 001-hello the first program ...in C for now

CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m4 -mthumb -O0 -g

help:
	echo "use make all"

all: 001-hello.o

001-hello.o: 001-hello.c
	$(CC) $(CFLAGS) -c 001-hello.c -o 001-hello.o


clean:
	rm -vf 001-hello.o

# --- end ---

