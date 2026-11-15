@ tot este pozriet a doupravovat

.syntax unified
.cpu cortex-m4
.thumb

.global _reset

.section .vectors
.word 0x20004000     @ Inicializácia Stack Pointer (RAM kon¿í tu)
.word _reset         @ Reset Vector

.section .text
_reset:
    @ 1. Konfigurácia PIN_CNF pre Tla¿idlo A (P0.14) -> Vstup, Pull-up
    @ Hodnota 0x0c (b1100) nastaví Pull-up a Input pre nRF52
    ldr r0, =0x50000738   @ PIN_CNF[14]
    mov r1, #0x0C
    str r1, [r0]

    @ 2. Konfigurácia PIN_CNF pre Riadok 1 (P0.21) -> Výstup
    ldr r0, =0x50000754   @ PIN_CNF[21]
    mov r1, #0x01         @ Direction: Output
    str r1, [r0]

    @ 3. Konfigurácia PIN_CNF pre St¿pec 1 (P0.28) -> Výstup
    ldr r0, =0x50000770   @ PIN_CNF[28]
    mov r1, #0x01         @ Direction: Output
    str r1, [r0]

    @ Aby LED svietila: Riadok = 1, St¿pec = 0
    @ Nastavme st¿pec P0.28 permanentne na 0 (v registri OUT)
    ldr r2, =0x50000504   @ GPIO0 OUT register
    ldr r3, [r2]
    bic r3, r3, #(1 << 28) @ Vynuluj bit 28 (St¿pec na LOW)
    str r3, [r2]

main_loop:
    @ ¿ítanie registra IN (0x50000510)
    ldr r4, =0x50000510
    ldr r5, [r4]
    
    @ Overenie bitu 14 (Tla¿idlo A)
    tst r5, #(1 << 14)
    bne button_released

button_pressed:
    @ Tla¿idlo stla¿ené (LOG 0) -> Rozsvie¿ Riadok 1 (P0.21 dáme na HIGH)
    ldr r3, [r2]
    orr r3, r3, #(1 << 21)
    str r3, [r2]
    b main_loop

button_released:
    @ Tla¿idlo pustené (LOG 1) -> Zhasni Riadok 1 (P0.21 dáme na LOW)
    ldr r3, [r2]
    bic r3, r3, #(1 << 21)
    str r3, [r2]
    b main_loop
