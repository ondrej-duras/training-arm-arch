# makefile for 101-gpio/001-LED-ON.s
# 20260928, Ondrej DURAS NOKIA Public OpenWare GNU/GPLv2

# tools
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
OC = arm-none-eabi-objcopy

# build parameters
CFLAGS = -mcpu=cortex-m4 -mthumb -O0 -g
LDFLAGS = --nostartfiles --specs=nosys.specs
MEMDEF  = 004-nRF52833.ld

help:
	@echo "make all ...... build a code"
	@echo "make run ...... emulate built application"
	@echo "make runa ..... emulate built application using c:\opt\renode"
	@echo "make clean .... delete all non-commitable/temporary data and binaries"

# list of results
all: 00A-LED-ON.hex

00A-LED-ON.hex: 001-LED-ON.s
	# compile to object
	$(AS) 001-LED-ON.s -o 00B-LED-ON.o
	# link object to .elf binary
	$(LD) -T $(MEMDEF) 00B-LED-ON.o -o 00C-LED-ON.elf
	# translate .elf into Inter HEX file - optional step
	$(OC) -O ihex 00C-LED-ON.elf 00A-LED-ON.hex 

run:  00A-LED-ON.hex 003-LED-ON.resc 002-microbit_v2.repl
	renode 003-LED-ON.resc

runa: 00A-LED-ON.hex 003-LED-ON.resc 002-microbit_v2.repl
	c:/opt/renode/bin/Renode.exe 003-LED-ON.resc

clean:
	echo "removing all non-commitable files and binaries"
	rm -vf 00A-LED-ON.hex
	rm -vf 00B-LED-ON.o
	rm -vf 00C-LED-ON.elf

# NOTY:
# 1. Krok: Skompiluj assembler do .elf (ako doteraz)
#arm-none-eabi-gcc -nostartfiles -T linker_script.ld 101-gpio/led_top_left.s -o 101-gpio/led_top_left.elf
# 2. Krok: Prevedie .elf do textového formátu Intel HEX
#arm-none-eabi-objcopy -O ihex 101-gpio/led_top_left.elf 101-gpio/led_top_left.hex
# --- end ---

