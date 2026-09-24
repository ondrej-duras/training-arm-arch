
// training-arm-arch
// 100-hello.c
// 2026-09-24 GoogleAI
//
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

