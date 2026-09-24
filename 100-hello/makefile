
# 001-hello the first program ...in C for now

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld

CFLAGS  = -mcpu=cortex-m4 -mthumb -O0 -g
LDFLAGS = --nostartfiles --specs=nosys.specs
MEMDEF  = nRF52833.ld

help:
	echo "use make all"

all: 001-hello.elf

001-hello.o: 001-hello.c
	$(CC) $(CFLAGS) -c 001-hello.c -o 001-hello.o

001-hello.elf: 001-hello.o
	#$(LD) $(LDFLAGS) -T $(MEMDEF) 001-hello.o -o 001-hello.elf
	$(LD) -T $(MEMDEF) 001-hello.o -o 001-hello.elf


clean:
	rm -vf 001-hello.o 001-hello.elf

# --- end ---

