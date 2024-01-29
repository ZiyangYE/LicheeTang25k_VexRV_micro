# LicheeTang25k_VexRV_micro

## Overview

The LicheeTang25k_VexRV_micro is a small RISC-V soft core project, implemented with [VexRISCV](https://github.com/SpinalHDL/VexRiscv). It is designed to be as simple as possible, yet functional enough for educational and basic embedded system applications.

### Features

- **Instruction Set:** RV32EC, reducing the ROM usage.
- **JTAG Debugging:** Includes a large standard JTAG debugging module relative to the core size, making it beginner-friendly.
- **Minimal Pin Design:** Initially designed for external bus connectivity, resulting in a reduced pin count. (In the provided example, the bus is internally connected.)

## Memory and Bus Details

- **External Bus Mapping:** Address range 0x80000000 - 0x80000400, supporting only single-byte access without handshake signals.
- **RAM/ROM:** Address range 0x00000000 - 0x00004000, implemented using BRAM, serving as both RAM and ROM, total 16kB.

## Register Details

- **Timer Registers:**
  - `0x80000000 - 0x80000007`: Dedicated to a timer with various control and status registers.
    - `0x0` - `0x3`: Timer value registers (low to high).
    - `0x4`: Writing resets the counter.
    - `0x5`: Writing captures a snapshot of the timer.
    - `0x6` - `0x7`: Timer prescaler registers (low to high).
- **UART Registers:**
  - `0x80000010 - 0x80000013`: Dedicated to a UART TX module.
    - `0x0` - `0x1`: Prescaler registers (low to high).
    - `0x2`: Transmit data register.
    - `0x3`: Transmit status register.

## Additional Information

- **No Interrupt Support:** The core does not support interrupts.
- **Development Environment:** Utilizes Segger Embedded Studio. Note: A license is required for commercial use.
- **Probe Hardware:** Jlink EDU V11 is recommended for debugging. OpenOCD is also supported.
- **OpenOCD Supports:** Includes vexrv.cfg for OpenOCD chip configuration and an OpenOCD project file.
- **External Bus Operation:** Note that this bus lacks any handshake signals. Writing is straightforward with an output enable (oe). During read operations, the first read sets the address lines to the corresponding address. A second read allows adequate time for the bus device to respond. It's advised to insert a NOP instruction between reads to prevent merging.

## Example Usage

A "Hello World" program demonstrates basic operations, including timer read/write, and outputs via RTT and UART. Project file for both JLink and OpenOCD is located at `example/Hello_world_jlink/Hello_world_jlink.emProject`.

### Compilation and BRAM Initialization

Compile the example to generate a binary file. Use `translate.py` to convert this binary to a hex file for BRAM initialization.

## Resource Ultization

| Resource | Utilization | Percentage |
| -------- | ----------- | ---------- |
| LUT      | 2,281       | 10%       |
| FF       | 1,497       | 7%       |
| BRAM     | 8           | 15%       |
