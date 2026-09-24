
/* nRF52833 micro:bit v2 linker-script */
/* 20260924, Ondrej DURAS, GoogleAI */
/* linker-script for 001-hello.c */
/* this script defines a memory map of the chip nRF52833 / micro:bit v2 */

MEMORY
{
        /* there we have 512kB of Flash from address 0x00000000 */
        FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 512K

        /* and 128kB of RAM organized from address 0x20000000 */
        RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 128K
}

SECTIONS
{
        .text : { *(.text*) } > FLASH /* programm code is placed here */
        .data : { *(.data*) } > RAM AT > FLASH /* initialized variables */
        .bss  : { *(.bss*)  } > RAM  /* non-initialized variables */
}
/* --- end --- */

