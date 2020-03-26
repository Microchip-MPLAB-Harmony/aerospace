---
grand_parent: Peripheral libraries
parent: ICM Peripheral Library
title: ICM Peripheral Library Usage
nav_order: 1
---

# ICM Peripheral Library Usage

## Configuring the library
Configure the peripheral library using the MHC.

The MHC can be used to configure the 4 memory regions (without secondary list).

The selected configuration are set during the system initialization.

## Using the library

After system initialization and before enabling the ICM, the memory hash address area should be set using the function  ```ICM_SetHashStartAddress```. This address should be a multiple of 128 bytes. For each region, 32 bytes are used to store the computed hash:

```c
    /* Hash Buffer were ICM will store the computed hash for each region */
    uint32_t __attribute__((aligned (128))) bufferHash[4][8] = {0};

    /* Set ICM memory address for generated hash */
    ICM_SetHashStartAddress((uint32_t) & bufferHash);
```

If interrupts are used, the callback function should be set and expected interrupts enabled:

```c
    /* Register ICM Callback */
    ICM_CallbackRegister(ICM_Callback_Function, (uintptr_t)NULL);

    /* Enable Interrupts */
    ICM_InterruptEnable(ICM_INT_MSK_HASH_R0_MASK | ICM_INT_MSK_HASH_R1_MASK |
                        ICM_INT_MSK_HASH_R2_MASK | ICM_INT_MSK_HASH_R3_MASK);
```

In order to run only one hash of the region, the ICM can be start using ```ICM_Enable``` function:

```c
    /* Enable ICM to perform hash of regions */
    ICM_Enable();
```

To modify the ICM configuration, it should be disabled using the ```ICM_Disable``` function:

```c
    /* Disable ICM */
    ICM_Disable();
    /* Wait end of current memory region monitored */
    while ( (ICM_StatusGet() & ICM_STATUS_ENABLE) == ICM_STATUS_ENABLE );
```

If a first hash has already been performed, the ICM can be run in monitoring mode after disabling the write back feature:

```c
    /* Disable ICM Write back feature */
    ICM_WriteBackDisable(true);

    /* Enable ICM monitor mode */
    ICM_MonitorEnable(ICM_REGION0_MASK | ICM_REGION1_MASK | ICM_REGION2_MASK | ICM_REGION3_MASK);

    /* Enable mismatch interrupts */
    ICM_InterruptEnable(ICM_INT_MSK_DIGEST_MISMATCH_R0_MASK |
                        ICM_INT_MSK_DIGEST_MISMATCH_R1_MASK |
                        ICM_INT_MSK_DIGEST_MISMATCH_R2_MASK |
                        ICM_INT_MSK_DIGEST_MISMATCH_R3_MASK);
    /* Enable ICM */
    ICM_Enable();
```
