@ 004-hello.s
@ 20260928, Ondrej DURAS (+GoogleAI), NOKIA Public OpenSource GNU/GPLv2
@ Hello Word in assembly language for embeded environment
@ Unlike 001-hello-FAIL.c , here Stack-Pointer and Reset-Handler are initialized.
@ so within emulation this program should not be terminated.
@ Also a sample shows work with procedure local (within stack) variables.
@ It's out of scope of the firt example ...but GoogleAI provided ...so OK.


@ --- 1. programm header  ---
.syntax unified             @ defines a accepted grammer
.thumb                      @ used the set of instructions
.equ STACK_TOP, 0x20020000  @ is a typeless constant definition


@ --- 2. section initial of vector table -------
@ ,"a" means a linker instruction "alocatable in memory"  
@ ... not some comments, but real data chunk, it must be allocated into memory
@ .align 2 means 2^2=4bytes bounder (0,4,8,16...)  
@ .align 4 means 2^4=16 bytes  (0,16,32,48,64...) It's a GNU assembler specificum.

.section .vectors, "a" 
.align 2  

.long STACK_TOP        @ 0x00000000: Počiatočná hodnota Stack Pointeru (SP)
.long Reset_Handler    @ 0x00000004: Adresa reset handleru

@ --- 3. a section of programm code ---
.section .text
.global Reset_Handler
.global main
.thumb_func

Reset_Handler:
    BL main            @ Zavolaj funkciu main (Branch with Link)
_dead_loop:
    B _dead_loop       @ Ak main skončí, zachyť CPU v nekonečnej slučke (while(1))

.thumb_func
    @ causes +1 align of instructions within the address symbol table => Thumb mode
    @ All Cortex-M works in Thumb mode only.
    @ Jump to odd (neparnu) address sets T-bit of EPSR to true (Thnum_Mode) and causes requirement to read Thumb instruction.
    @ If we proceed a jump to even (parnu) address, then instruction there should be full with ARM-32/64-bit
    @ but on Cortex-M it causes HardFault (obdoba Kernel Panic v Linux, proste zly stav / nepodporovany rezim procesora)

main:
    @ After entry into main function, proceeding allocation of two 32-bit local (volatile) variables 
    @ [SP, #0] -> button_state
    @ [SP, #4] -> led_counter
    SUB     SP, SP, #8

    @ initiating local variables to zero.
    MOVS    R0, #0
    STR     R0, [SP, #0]    @ button_state = 0
    STR     R0, [SP, #4]    @ led_counter = 0

_loop:
    @ begin of main programm loop.
    @ incrementing button state
    LDR     R0, [SP, #0]
    CMP     R0, #1          @ compare button_state == 1?
    BNE     _loop           @ if not, then check again (while(1) in our case)

    @ if (button_state == 1), increment led_counter
    LDR     R1, [SP, #4]    @ read led_counter into R1
    ADDS    R1, R1, #1      @ led_counter++
    STR     R1, [SP, #4]    @ led_counter write back into memory

    B       _loop           @ unconditional end of loop (while(1))

    @ formal return from procedure main ... will never happen
    ADD     SP, SP, #8      @ cleanup the locals from stack
    MOVS    R0, #0          @ return value from proc main is 0
    BX      LR              @ return from proc main

@ --- end ---

