---
parent: Examples applications
title: IP1553 Remote Terminal operation blocking Example
nav_order: 3
---

# IP1553 Remote Terminal operation blocking Example

This example shows how start the IP1553 module in Remote Terminal mode with RT01 address and receive data transfer commands in a blocking manner. The CPU polls the peripheral register continuously to manage the transfer. It waits for any incoming commands and display the buffer sent or the received data.

## Building The Application
The parent folder for all the MPLAB X IDE projects for this application is given below:

**Application Path** : aerospace\apps\ip1553\ip1553_rt_operation_blocking\firmware

To build the application, refer the below table and open the appropriate project file in MPLABX IDE.

| Project Name  | Description   |
| ------------- |:-------------:|
| sam_rh71_ek.X | SAM RH71 Evaluation Kit board  |


## MPLAB Harmony Configurations

Refer to the MHC project graph for the components used and the respective configuration options.

## Hardware Setup

1. Project sam_rh71_xult.X
    * Hardware Used
        * SAM RH71 Evaluation Kit
        * MIL1553 Exerciser and Cables
    * Hardware Setup
        * Connect the debugger probe to J33.
        * Connect the USB port on the board to the computer using a mini USB cable.
        * Connect the MIL1553 exerciser on 1553_BUSA or 1553_BUSB connectors.
    * Exerciser configuration
        * Configure in Bus commander to send commands to RT01.

## Running The Application

1. Open the Terminal application (Ex.:Tera term) on the computer.
2. Connect to the EDBG Virtual COM port and configure the serial settings as follows:
    * Baud : 115200
    * Data : 8 Bits
    * Parity : None
    * Stop : 1 Bit
    * Flow Control : None
3. Build and Program the application using the MPLAB X IDE.
4. See the following message in the console.

```console
-----------------------------------------------------------

  IP1553 - RT mode blocking operation example

-----------------------------------------------------------

MIL1553 RT mode, wait for BC command
```

1. With MIL1553 exerciser, send data transfer command to or from RT01.
2. It will echo the buffer sent or the received data.