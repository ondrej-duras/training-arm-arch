
# 001-hello the first program ...in C for now

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
EM = c:/opt/renode16/bin/Renode.exe
#EM = c:/opt/renode17/Renode.exe

CFLAGS  = -mcpu=cortex-m4 -mthumb -O0 -g
LDFLAGS = --nostartfiles --specs=nosys.specs
MEMDEF  = nRF52833.ld

help:
	echo "ARM toolchain is installed via"
	echo "winget install -e --id=Arm.GnuArmEmbeddedToolchain =i -l c:\opt\arm"
	echo "Renode (site builds.renode.io or renode.io)"
	echo "version 1.16 has been installed via" 
	echo "winget install -e --id=Renode.Renode -i -l c:\opt\renode16"
	echo "version 1.17 has been installed via UNZIP"
	echo "wget https://builds.renode.io/renode-1.17.0+20261023git8056b03eb.windows-portable.zip"
	echo "7z x "renode-1.17.0+20261023git8056b03eb.windows-portable.zip" -oc:\opt\renode17\"
	echo "---"
	echo "make all ....... build all bin"
	echo "make clean ..... delete all non-git bin files"
	echo "make run ....... start emulation of C/S example see .resc"
	echo "make run_opt ... start emulation of C/S example see .resc"

# list of results
all: 00A-hello-FAIL.elf  00C-hello.elf  00F-hello-as.elf

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

00F-hello-as.elf: 004-hello-as.s
	$(AS) 004-hello-as.s -o 00E-hello-as.o
	$(LD) -T $(MEMDEF) 00E-hello-as.o -o 00F-hello-as.elf

run: 00F-hello-as.elf
	$(EM) 002-hello-on-microbit-v2.resc

# housekeeping - all files not going into git repository may be deleted.
clean:
	rm -vf 00B-hello-FAIL.o 00A-hello-FAIL.elf 00F-hello-as.elf
	rm -vf 00D-hello.o 00E=hello-as.o
	rm -vf 00C-hello.elf

# --- end ---

