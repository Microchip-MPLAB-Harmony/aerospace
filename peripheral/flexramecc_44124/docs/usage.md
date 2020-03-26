---
grand_parent: Peripheral libraries
parent: FLEXRAMECC Peripheral Library
title: FLEXRAMECC Peripheral Library Usage
has_toc: true
nav_order: 1
---

# FLEXRAMECC Peripheral Library Usage

## Configuring the library

Configure the peripheral library using the MHC.

* "Interrupt Mode" option can be enabled to add interface functions for interrupt support:
    * Interrupts are enable during system initialization
    * ```FLEXRAMECC_FixCallbackRegister``` and ```FLEXRAMECC_NoFixCallbackRegister``` functions can be used to register callbacks.
* "Use injection test mode" option can be enabled to add functions for the test of error injection by reading or setting the ECC check bit value.

## Using the library

If interrupts are used, the callback function should be set for expected interrupts types:

```c
    /* Register Fixable errors Callback */
    FLEXRAMECC_FixCallbackRegister(FLEXRAM_FixCallback_Function, (uintptr_t)NULL);
    /* Register UnFixable errors Callback */
    FLEXRAMECC_NoFixCallbackRegister(FLEXRAM_NoFixCallback_Function, (uintptr_t)NULL);
```

When an ECC error is detected and an interrupt occurs, the fail address must be read before the status in order to avoid multiple interrupts:

```c
    /* Get ECC fault address */
    uint32_t* fault_pointer = (uint32_t*)(FLEXRAMECC_GetFailAddress());

    /* Get FLEXRAMECC status */
    FLEXRAMECC_STATUS status_reg = FLEXRAMECC_StatusGet();
```

The faulty address may then be fixed by the application if applicable.

### Error injection test mode

#### ECC Check bit read

The ECC check bit value can be get when the read test mode is activated. Once this mode is activated, the check bit value for each read of data on FlexRAM memory is stored. It is possible to get the last check bit value using the function ```FLEXRAMECC_TestModeGetCbValue```.

```c
    /* Enable FLEXRAM ECC Test mode Read */
    FLEXRAMECC_TestModeReadEnable();
    __DSB();
    __ISB();

    /* Read data in FlexRAM */
    data = buffer[index];
    __DSB();
    __ISB();

    /* Get the Check Bit for last read data in FlexRAM */
    ecc_tcb = FLEXRAMECC_TestModeGetCbValue();
    __DSB();
    __ISB();

    /* Disable FLEXRAM ECC Test mode Read */
    FLEXRAMECC_TestModeReadDisable();
```

*Note:* It is recommended to use memory barriers on Cortex-M core-based products where instructions can be executed out of programmed order, or to ensure that all memory transfers or instructions are completed before any new instruction is executed. In our application, we must ensure that register modification and memory transfers are completed before executing the next step.

#### ECC Check bit write

The ECC check bit value can be override when the write test mode is activated. Once this mode is activated, the check bit value for each write of data on FlexRAM memory is override by the given value instead of being calculated automatically. The check bit value used should be set using the function ```FLEXRAMECC_TestModeSetCbValue```.

```c
    /* Enable FLEXRAM ECC Test mode Write */
    FLEXRAMECC_TestModeWriteEnable();
    __DSB();
    __ISB();

    /* Set the Check Bit for override when data will be write in FlexRAM */
    FLEXRAMECC_TestModeSetCbValue(ecc_tcb);
    __DSB();
    __ISB();

    /* Write data in FlexRAM */
    buffer = data;
    __DSB();
    __ISB();

    /* Disable FLEXRAM ECC Test mode Write */
    FLEXRAMECC_TestModeWriteDisable();
```

*Note:* It is recommended to use memory barriers on Cortex-M core-based products where instructions can be executed out of programmed order, or to ensure that all memory transfers or instructions are completed before any new instruction is executed. In our application, we must ensure that register modification and memory transfers are completed before executing the next step.
