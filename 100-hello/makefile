
# 001-hello the first program ...in C for now

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld

CFLAGS  = -mcpu=cortex-m4 -mthumb -O0 -g
LDFLAGS = --nostartfiles --specs=nosys.specs
MEMDEF  = nRF52833.ld

help:
	echo "make all   - build all bin"
	echo "make clean - delete all non-git bin files"
	echo "make run   - start emulation"

# list of results
all: 00A-hello-FAIL.elf  00C-hello.elf

# way - A : C compilation within two steps
00B-hello-FAIL.o: 001-hello-FAIL.c
	$(CC) $(CFLAGS) -c 001-hello-FAIL.c -o 00B-hello-FAIL.o

00A-hello-FAIL.elf: 00B-hello-FAIL.o
	#$(LD) $(LDFLAGS) -T $(MEMDEF) 00A-hello-FAIL.o -o 00A-hello-FAIL.elf
	$(LD) -T $(MEMDEF) 00B-hello-FAIL.o -o 00A-hello-FAIL.elf

# way - B : C compilation within one step
00C-hello.elf: 003-hello.c
	$(CC)    $(CFLAGS) -c 003-hello.c -o 00D-hello.o
	$(LD) -T $(MEMDEF)    00D-hello.o -o 00C-hello.elf
	#$(CC)  $(CFLAGS) -T $(MEMDEF) 003-hello.c -o 00C-hello.elf

run: 00C-hello.elf
	renode 002-hello-on-microbit-v2.resc

# housekeeping - all files not going into git repository may be deleted.
clean:
	rm -vf 00B-hello-FAIL.o 00A-hello-FAIL.elf
	rm -vf 00D-hello.o
	rm -vf 00C-hello.elf

# --- end ---

