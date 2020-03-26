---
grand_parent: Peripheral libraries
parent: IP1553 Peripheral Library
title: IP1553 Peripheral Library Usage
has_toc: true
nav_order: 1
---

# IP1553 Peripheral Library Usage

## Configuring the library

Configure the peripheral library using the MHC.

* 12 MHz input clock should be configured with clock configurator.
* The 1553 mode used is configurable : BC or RT mode
    * RT address should be configured for RT mode.
* "Interrupt Mode" option can be enabled to add interface functions for interrupt support (Enable, Disable and callback register).

## Using the library

The IP1553 initialization is done during system initialization. It configures the module depending on the given parameters in MHC interface.

For both modes, once the module is initialize, the receive and transmit buffers should be initialized. Application must allocate 2 buffers (one for receive and one for transmit) from non-cached contiguous memory and buffer size must be 2 Kbyte (16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM)

Code example for buffers configuration:

```c
    /* Allocation of receive buffer for IP1553 */
    uint16_t IP1553RxBuffersRAM[IP1553_BUFFERS_NUM][IP1553_BUFFERS_SIZE] __attribute__((aligned (32)))__attribute__((space(data), section (".ram_nocache")));

    /* Allocation of transmit buffer for IP1553 */
    uint16_t IP1553TxBuffersRAM[IP1553_BUFFERS_NUM][IP1553_BUFFERS_SIZE] __attribute__((aligned (32)))__attribute__((space(data), section (".ram_nocache")));

    /* Set buffers Configuration */
    IP1553_BuffersConfigSet(&IP1553TxBuffersRAM[0][0], &IP1553RxBuffersRAM[0][0]);
```

To receive and transmit, the status of the buffers must be reset (indicate buffer is empty for RX and that buffer is ready to be sent for Tx):

```c
    /* Reset Tx and Rx status for buffers 0 and 31 */
    IP1553_ResetTxBuffersStatus(0x80000001);
    IP1553_ResetRxBuffersStatus(0x80000001);
```

### Bus Controller mode

Once initialized, the Bus Controller can issue data transfer commands:
* From BC to RT
* From RT to BC
* From RT to RT

After the send of the command the BC can check the status to detect the end of transmission/reception and/or possible errors flags.

Example of sending data from BC buffer 0 to RT1 buffer 3 and wait for word status:

```c
    /* Send 4 words data from BC buffer 2 to RT1 buffer 3, on Bus A */
    IP1553_BcStartDataTransfer(
        IP1553_DATA_TX_TYPE_BC_TO_RT,
        0,
        2,
        1,
        3,
        4,
        IP1553_BUS_A
    );

    /* Wait for status word */
    do
    {
        IP1553_INT_MASK status = IP1553_IrqStatusGet();
        if ( (status & IP1553_INT_MASK_ETX) != 0 )
        {
            isTransferEnded = true;
        }
        if ( (status & IP1553_INT_MASK_ETRANS_MASK) != 0 )
        {
            hasStatusWord = true;
        }
        transferErrors = status & IP1553_INT_MASK_ERROR_MASK;
    }
    while ( (!isTransferEnded || !hasStatusWord) && (transferErrors) == 0 );
```
### Remote Terminal mode

When configured in RT mode, the 1553 module features a specific behaviour  depending on the command received from the 1553 network.

The status return by ```IP1553_IrqStatusGet``` contains the information on detected errors or the end of data reception and transmission.

If the buffer read or write by the BC command were prepared (reset status to indicate empty or ready to send), the transfer is executed without error.

The functions ```IP1553_GetRxBuffersStatus``` and ```IP1553_GetTxBuffersStatus``` can then be used to determine the modified buffers.

Example of wait of data reception:

```c
    while ( true )
    {
        IP1553_INT_MASK status = IP1553_IrqStatusGet();

        if ( (status & IP1553_INT_MASK_ERX) == IP1553_INT_MASK_ERX )
        {
            uint32_t lastActiveBuffers = (~(IP1553_GetRxBuffersStatus())) & 0x80000001;
            uint32_t buffer = 0;
            while ( lastActiveBuffers != 0 )
            {
                while ( ( lastActiveBuffers & 0x1 ) == 0 )
                {
                    buffer++;
                    lastActiveBuffers >>= 1;
                }

                printf("RX buffer : %u", (unsigned int) buffer);

                /* Reset Rx buffer status */
                IP1553_ResetRxBuffersStatus(IP1553_BUFFER_TO_BITFIELD_SA(buffer));

                /* Go to next bit in lastActiveBuffer bit field */
                buffer++;
                lastActiveBuffers >>= 1;
            }
        }
    }
```

### Using interrupts

When interrupts are used to check the IP1553 status, the interrupt callback function should be set and expected interrupts enabled:

```c
    /* Set 1553 application callback on interrupt event */
    IP1553_CallbackRegister(IP1553_Callback_Function, (uintptr_t) NULL);

    /* Enable all IP1553 interrupts */
    IP1553_InterruptEnable(
        IP1553_INT_MASK_EMT |
        IP1553_INT_MASK_MTE |
        IP1553_INT_MASK_ERX |
        IP1553_INT_MASK_ETX |
        IP1553_INT_MASK_ETRANS_MASK |
        IP1553_INT_MASK_TE |
        IP1553_INT_MASK_TCE |
        IP1553_INT_MASK_TPE |
        IP1553_INT_MASK_TDE |
        IP1553_INT_MASK_TTE |
        IP1553_INT_MASK_TWE |
        IP1553_INT_MASK_BE |
        IP1553_INT_MASK_ITR |
        IP1553_INT_MASK_TVR |
        IP1553_INT_MASK_DBR |
        IP1553_INT_MASK_STR |
        IP1553_INT_MASK_TSR |
        IP1553_INT_MASK_OSR |
        IP1553_INT_MASK_SDR |
        IP1553_INT_MASK_SWD |
        IP1553_INT_MASK_RRT |
        IP1553_INT_MASK_ITF |
        IP1553_INT_MASK_OTF |
        IP1553_INT_MASK_IPB);
```
