
// training-arm-arch
// 003-hello.c
// 2026-09-25 GoogleAI
//
// This is embeded app, so vector table needs to be initialized.
// Otherwise CPU will fly to space.
// Real HW will die, Emulation will be terminated with the critical notice.
// So here is a fix of 001-hello-FAIL.c
//

// in memory Cortex-M based SoC
// 0x00000000 should contain initial address of Stack-Pointer
// 0x00000004 should contain Reset-Handler address
//
// within SoC nRF52833 (micro:bit-v2) the RAM ends at following address
// This address becomes an initial value of the stack-pointer
#define STACK_TOP 0x20020000


// Fuction Prototypes
void Reset_Handler(void);
int main(void);


// Reset handler - the first thing, it runs after PowerON of the chip
void Reset_Handler(void) {
	main();

	// is happen, the main will end,
	// the CPU intentionally fall in neverending cycle
	while(1);
}

// Vector Table ... stored in dedicated section .vectors

__attribute__((section(".vectors")))
void (* const vector_table[])(void) = {
	(void (*)(void))STACK_TOP, // 0x00000000: SP / R13 - Stack-Pointer register initial value
	Reset_Handler              // 0x00000004: Reset Handler
};

// Our original application
int main(void) {
        // volatile tells to compiler, do not optimize access to memory
        // allways read-write into memory, never hold in registers only

        volatile int button_state = 0;
        volatile int led_counter = 0;

        while(1) {
                if (button_state == 1) {
                        led_counter++;
                }
        }
        return 0;
}

// --- end ---

