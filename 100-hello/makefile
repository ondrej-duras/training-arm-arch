
# 001-hello the first program ...in C for now

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld

CFLAGS  = -mcpu=cortex-m4 -mthumb -O0 -g
LDFLAGS = --nostartfiles --specs=nosys.specs
MEMDEF  = nRF52833.ld

help:
	echo "use make all"

all: 00A-hello.elf

00B-hello.o: 001-hello.c
	$(CC) $(CFLAGS) -c 001-hello.c -o 00B-hello.o

00A-hello.elf: 00B-hello.o
	#$(LD) $(LDFLAGS) -T $(MEMDEF) 00A-hello.o -o 00A-hello.elf
	$(LD) -T $(MEMDEF) 00B-hello.o -o 00A-hello.elf


clean:
	rm -vf 00B-hello.o 00A-hello.elf

# --- end ---

