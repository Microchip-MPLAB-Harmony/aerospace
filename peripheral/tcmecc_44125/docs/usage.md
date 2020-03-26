---
grand_parent: Peripheral libraries
parent: TCMECC Peripheral Library
title: TCMECC Peripheral Library Usage
has_toc: true
nav_order: 1
---

# TCMECC Peripheral Library Usage

## Configuring the library
Configure the peripheral library using the MHC.

* "Interrupt Mode" option can be enabled to add interface functions for interrupt support:
    * Interrupts are enable during system initialization
    * ```TCMECC_FixCallbackRegister``` and ```TCMECC_NoFixCallbackRegister``` functions can be used to register callbacks.
* "Use injection test mode" option can be enabled to add functions for the test of error injection by reading or setting the ECC check bit value.

## Using the library

If interrupts are used, the callback function should be set for expected interrupts types:

```C
    /* Register Fixable errors Callback */
    TCMECC_FixCallbackRegister(TCM_FixCallback_Function, (uintptr_t)NULL);
    /* Register UnFixable errors Callback */
    TCMECC_NoFixCallbackRegister(TCM_NoFixCallback_Function, (uintptr_t)NULL);
```

When an ECC error is detected and an interrupt occurs, the fail address must be read before the status in order to avoid multiple interrupts:

```C
    /* Get DTCM fault address */
    uint32_t* fault_pointer_word = (uint32_t*)(TCMECC_GetFailAddressDTCM() & 0x2003FFFF);

    /* Get ITCM fault address */
    uint64_t* fault_pointer = (uint64_t*)(TCMECC_GetFailAddressITCM() & 0x1FFFF);

    /* Only for Fixable error handler : Read corrected data on the Fly for ITCM */
    uint64_t fault_data = *fault_pointer;

    /* Only for Fixable error handler : Read corrected data on the Fly for DTCM */
    if ( ( (uint32_t)fault_pointer_word >= 0x20000000 ) && ( (uint32_t)fault_pointer_word <= 0x2003FFFF ) )
    {
        fault_data_word = *fault_pointer_word;
    }

    /* Read TCMECC Status */
    TCMECC_STATUS status_reg = TCMECC_StatusGet();
```

The faulty address may then be fixed by the application if applicable.

### Error injection test mode

#### ECC Check bit read

The ECC check bit value can be get when the read test mode is activated. Once this mode is activated, the check bit value for each read of data on TCM memory is stored. It is possible to get the last check bit value using the function ```TCMECC_TestModeGetCbValue```.

```C
    /* Reset check bit value to 0 */
    TCMECC_TestModeSetCbValue(0, 0);
    __DSB();
    __ISB();

    /* Enable TCM ECC Test mode Read */
    TCMECC_TestModeReadEnable();
    __DSB();
    __ISB();

    /* Read data in TCM */
    data = buffer;

    /* Disable TCM ECC Test mode Read */
    TCMECC_TestModeReadDisable();
    __DSB();
    __ISB();

    /* Get the Check Bit for last read data in TCM - Wait check bit values are correctly updated */
    do
    {
        TCMECC_TestModeGetCbValue(&(pEccErrorInject->ecc_tcb1), &(pEccErrorInject->ecc_tcb2));
    }
    while ( (pEccErrorInject->ecc_tcb1 == 0) && (pEccErrorInject->ecc_tcb2 == 0) );
```

*Note:* It is recommended to use memory barriers on Cortex-M core-based products where instructions can be executed out of programmed order, or to ensure that all memory transfers or instructions are completed before any new instruction is executed. In our application, we must ensure that register modification and memory transfers are completed before executing the next step.

#### ECC Check bit write

The ECC check bit value can be override when the write test mode is activated. Once this mode is activated, the check bit value for each write of data on TCM memory is override by the given value instead of being calculated automatically. The check bit value used should be set using the function ```TCMECC_TestModeSetCbValue```.

```C
    /* Enable TCM ECC Test mode Write */
    TCMECC_TestModeWriteEnable();
    __DSB();
    __ISB();

    /* Set the Check Bit for override when data will be write in TCM */
    TCMECC_TestModeSetCbValue(tcb1, tcb2);
    __DSB();
    __ISB();

    /* Write data in TCM */
    buffer = data;
    __DSB();
    __ISB();

    /* Disable TCM ECC Test mode Write */
    TCMECC_TestModeWriteDisable();
```

*Note:* It is recommended to use memory barriers on Cortex-M core-based products where instructions can be executed out of programmed order, or to ensure that all memory transfers or instructions are completed before any new instruction is executed. In our application, we must ensure that register modification and memory transfers are completed before executing the next step.
