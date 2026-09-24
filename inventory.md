## Hardware inventory

| Platform  | Chipset | Processor | Archytecture | System |  Used Features | Target Topic |
|-----------|---------|-----------|--------------|--------|----------------|--------------|
| micro:bit | nrf52833 | Cortex-M4 | ARM-32      |embed | GPIO LED diodes, buttons, UART | morse telegraph LED+Button |
| Adafruit Clue | nrf52840 | Cortex-M4 | ARM-32  | embed |GPIO buttons, display 240x240, SPI, I2C, UART, BLE| morse telegraph via BLE |
| Adafruit PyBadge | ATSAMD51J19 | Cortex-M4F | ARM-32 +FPU | embed| FPU, GPIO 8-buttons, display 160x128, UART, BLE| arkanoid game |
| RaspBerry Pi 5 1GB | SC2162 | Cortex-A76 | ARM-64 +GPU |linux | MMU, USB, Ethernet, UART-HMI, GPU | arkanoid game, packet generator |
| routerboard | IPQ4018 | Cortex-A7 | ARM-32 |linux | 5x Gbps Ethernet | packet generator, packet analyzer |


## Software Inventory

- VIM (text editor - IDE environment)
- ARM toolchain (assembler compilarot)
- Renode.IO (Emulator of hardware)

## Security Exceptions

If you work in corporation, then you need security exceptions
for usage of USB port.
So necessary data are following:


|Product Name    |USB Vendor ID |USB Product ID | System Memory            |   Capacity of storage |
|----------------|--------------|---------------|--------------------------|-----------------------|
|micro:bit 1/2   |VID=0x0d28    |PID=0x0204     | 128kB RAM                |   512kB               |
|Adafruit PyBadge|VID=0x239A    |PID=0x8033     | 5125kB code / 192kB data |   2MB QSPI flash      |
|Adafruit Clue   |VID=0x239A    |PID=0x0071     | 1 MB code/ 256kB data    |   2MB QSPI flash      |



