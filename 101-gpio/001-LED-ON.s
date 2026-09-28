@ 101-gpio/001-LED-ON.s
@ 20260928, Ondrej DURAS (+GoogleAI) NOKIA Public OpenSource GNU/GPLv2


.syntax unified
.thumb

.equ STACK_TOP,     0x20020000
.equ GPIO_P0_BASE,  0x50000000

@ Registre pre konfiguráciu pinov (PIN_CNF)
@ Ka¿dý pin má svoj 32-bitový register na adrese: BASE + 0x700 + (pin * 4)
.equ P0_21_CNF,     (0x700 + (21 * 4)) @ ROW1
.equ P0_28_CNF,     (0x700 + (28 * 4)) @ COL1

@ Registre pre zápis na port (posuny od GPIO_P0_BASE)
.equ GPIO_OUTSET,   0x508  @ Nastaví bity na 1
.equ GPIO_OUTCLR,   0x50C  @ Nastaví bity na 0

.section .vectors, "a"
.align 2
.long STACK_TOP
.long Reset_Handler

.section .text
.global Reset_Handler
.thumb_func

Reset_Handler:
    LDR     R0, =GPIO_P0_BASE

    @ 1. Konfigurácia pinu P0.21 (ROW1) ako VÝSTUP (hodnota 1 v PIN_CNF)
    MOVS    R1, #1
    STR     R1, [R0, #P0_21_CNF]

    @ 2. Konfigurácia pinu P0.28 (COL1) ako VÝSTUP (hodnota 1 v PIN_CNF)
    STR     R1, [R0, #P0_28_CNF]

    @ 3. Zhasnutie st¿pca COL1 (Pin 28 stiahneme na 0 cez OUTCLR register)
    LDR     R2, =(1 << 28)
    STR     R2, [R0, #GPIO_OUTCLR]

    @ 4. Rozsvietenie riadku ROW1 (Pin 21 vytiahneme na 1 cez OUTSET register)
    LDR     R3, =(1 << 21)
    STR     R3, [R0, #GPIO_OUTSET]

_infinite_loop:
    B       _infinite_loop   @ Dr¿íme CPU v chode, LED stále svieti

@ --- end ---

