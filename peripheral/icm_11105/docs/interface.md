---
grand_parent: Peripheral libraries
parent: ICM Peripheral Library
title: ICM Peripheral Library Interface
has_toc: true
nav_order: 2
---

# Peripheral Library Interface
{: .no_toc }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Data Types and Constants

### ICM_REGION_MASK

```c
typedef enum
{
    ICM_REGION0_MASK = 0x1,
    ICM_REGION1_MASK = 0x2,
    ICM_REGION2_MASK = 0x4,
    ICM_REGION3_MASK = 0x8,
    /* Force the compiler to reserve 32-bit memory for enum */
    ICM_REGION_MASK_INVALID = 0xFFFFFFFF
} ICM_REGION_MASK;
```

**Summary**

ICM Region Mask.

**Description**

This data type defines the ICM Region.

---

### ICM_INT_MSK

```c
typedef enum
{
    ICM_INT_MSK_HASH_R0_MASK = ICM_IER_RHC(ICM_REGION0_MASK),
    ICM_INT_MSK_HASH_R1_MASK = ICM_IER_RHC(ICM_REGION1_MASK),
    ICM_INT_MSK_HASH_R2_MASK = ICM_IER_RHC(ICM_REGION2_MASK),
    ICM_INT_MSK_HASH_R3_MASK = ICM_IER_RHC(ICM_REGION3_MASK),
    ICM_INT_MSK_DIGEST_MISMATCH_R0_MASK = ICM_IER_RDM(ICM_REGION0_MASK),
    ICM_INT_MSK_DIGEST_MISMATCH_R1_MASK = ICM_IER_RDM(ICM_REGION1_MASK),
    ICM_INT_MSK_DIGEST_MISMATCH_R2_MASK = ICM_IER_RDM(ICM_REGION2_MASK),
    ICM_INT_MSK_DIGEST_MISMATCH_R3_MASK = ICM_IER_RDM(ICM_REGION3_MASK),
    ICM_INT_MSK_BUS_ERROR_R0_MASK = ICM_IER_RBE(ICM_REGION0_MASK),
    ICM_INT_MSK_BUS_ERROR_R1_MASK = ICM_IER_RBE(ICM_REGION1_MASK),
    ICM_INT_MSK_BUS_ERROR_R2_MASK = ICM_IER_RBE(ICM_REGION2_MASK),
    ICM_INT_MSK_BUS_ERROR_R3_MASK = ICM_IER_RBE(ICM_REGION3_MASK),
    ICM_INT_MSK_WRAP_R0_MASK = ICM_IER_RWC(ICM_REGION0_MASK),
    ICM_INT_MSK_WRAP_R1_MASK = ICM_IER_RWC(ICM_REGION1_MASK),
    ICM_INT_MSK_WRAP_R2_MASK = ICM_IER_RWC(ICM_REGION2_MASK),
    ICM_INT_MSK_WRAP_R3_MASK = ICM_IER_RWC(ICM_REGION3_MASK),
    ICM_INT_MSK_END_BIT_R0_MASK = ICM_IER_REC(ICM_REGION0_MASK),
    ICM_INT_MSK_END_BIT_R1_MASK = ICM_IER_REC(ICM_REGION1_MASK),
    ICM_INT_MSK_END_BIT_R2_MASK = ICM_IER_REC(ICM_REGION2_MASK),
    ICM_INT_MSK_END_BIT_R3_MASK = ICM_IER_REC(ICM_REGION3_MASK),
    ICM_INT_MSK_STATUS_UPDATE_R0_MASK = ICM_IER_RSU(ICM_REGION0_MASK),
    ICM_INT_MSK_STATUS_UPDATE_R1_MASK = ICM_IER_RSU(ICM_REGION1_MASK),
    ICM_INT_MSK_STATUS_UPDATE_R2_MASK = ICM_IER_RSU(ICM_REGION2_MASK),
    ICM_INT_MSK_STATUS_UPDATE_R3_MASK = ICM_IER_RSU(ICM_REGION3_MASK),
    ICM_INT_MSK_UNDEFINED_REG_ACCESS_MASK = ICM_IER_URAD_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    ICM_INT_MSK_INVALID = 0xFFFFFFFF
} ICM_INT_MSK;
```

**Summary**

ICM Interrupt Mask.

**Description**

This data type defines the ICM Interrupt sources.

---

## ICM_STATUS

```c
typedef enum
{
    ICM_STATUS_ENABLE = ICM_SR_ENABLE_Msk,
    ICM_STATUS_RAW_MON_DIS_R0 = ICM_SR_RAWRMDIS(ICM_REGION0_MASK),
    ICM_STATUS_RAW_MON_DIS_R1 = ICM_SR_RAWRMDIS(ICM_REGION1_MASK),
    ICM_STATUS_RAW_MON_DIS_R2 = ICM_SR_RAWRMDIS(ICM_REGION2_MASK),
    ICM_STATUS_RAW_MON_DIS_R3 = ICM_SR_RAWRMDIS(ICM_REGION3_MASK),
    ICM_STATUS_MON_DIS_R0 = ICM_SR_RMDIS(ICM_REGION0_MASK),
    ICM_STATUS_MON_DIS_R1 = ICM_SR_RMDIS(ICM_REGION1_MASK),
    ICM_STATUS_MON_DIS_R2 = ICM_SR_RMDIS(ICM_REGION2_MASK),
    ICM_STATUS_MON_DIS_R3 = ICM_SR_RMDIS(ICM_REGION3_MASK),
    /* Force the compiler to reserve 32-bit memory for enum */
    ICM_STATUS_INVALID = 0xFFFFFFFF
} ICM_STATUS;
```

**Summary**

Identifies the ICM current status.

**Description**

This data type identifies the ICM status.

---

### ICM_CALLBACK

```c
typedef void (*ICM_CALLBACK) (uintptr_t contextHandle);
```

**Summary**

ICM Callback Function Pointer.

**Description**

This data type defines the required function signature for the ICM callback function. Application must register a pointer to a callback function whose function signature (parameter and return value types) match the types specified by this function pointer in order to receive callback from the PLIB. The parameters and return values are described here and a partial example implementation is provided.

**Parameters**

*contextHandle* Value identifying the context of the application that registered the callback function

**Remarks**

The context parameter contains the a handle to the client context, provided at the time the callback function was registered using the CallbackRegister function. This context handle value is passed back to the client as the "context" parameter. It can be any value (such as a pointer to the client's data) necessary to identify the client context or instance of the client that made the data transfer request.

The callback function executes in the PLIB's interrupt context. It is recommended of the application to not perform process intensive or blocking operations with in this function.

**Example**

```c
void APP_ICM_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

ICM_CallbackRegister(&APP_ICM_Handler, (uintptr_t)NULL);
```

----

### ICM_OBJ

```c
typedef struct
{
    /* Transfer Event Callback */
    ICM_CALLBACK callback;

    /* Transfer Event Callback Context */
    uintptr_t context;
} ICM_OBJ;
```

**Summary**

ICM PLib Object structure.

**Description**

This data structure defines the ICM PLib Instance Object.

---



## Initialization functions

### ICM_Initialize

```c
void ICM_Initialize(void)
```

**Summary**

Initializes given instance of the ICM peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### ICM_SetHashStartAddress

```c
void ICM_SetHashStartAddress(void)
```

**Summary**

Set the ICM hash area start address register.

**Description**

The ICM Hash Area should be a contiguous area of system memory that the controller
and the processor can access. This address is a multiple of 128 bytes.
For each region, 32 bytes are used to store the computed hash.

**Preconditions**

None

**Parameters**

*addr*
The address of the ICM Hash memory location.

**Returns**

None

**Remarks**

This field points at the Hash memory location. The address must be aligned to 128 bytes.

---

## Setup functions

### ICM_SetEndOfMonitoringDisable

```c
void ICM_SetEndOfMonitoringDisable(bool disable)
```
**Summary**

Disables/enables the ICM End of Monitoring Configuration.

**Preconditions**

None

**Parameters**

*disable*
If true, End of Monitoring is disabled. Enabled if false.

**Returns**
None

---

### ICM_WriteBackDisable

```c
void ICM_WriteBackDisable(bool disable)
```
**Summary**
Disables/enables the ICM Write Back Configuration.

**Preconditions**
None

**Parameters**
*disable*
If true, Write Back is disabled. Enabled if false.

**Returns**
None

---

### ICM_SoftwareReset

```c
void ICM_SoftwareReset(void)
```
**Summary**

Reset the ICM Peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### ICMICM_SetDescStartAddress

```c
void ICMICM_SetDescStartAddress(icm_descriptor_registers_t* addr)
```
**Summary**

Set the ICM descriptor area start address register.

**Preconditions**

None

**Parameters**

*addr*
The address of the ICM list descriptor.

**Returns**

None

**Remarks**

The start address must be aligned with size of the data structure (64 bytes).

---

### ICM_Enable

```c
void ICM_Enable(void)
```

**Summary**

Enable the ICM Peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### ICM_Disable

```c
void ICM_Disable(void)
```

**Summary**

Disable the ICM Peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

### ICM_ReComputeHash

```c
void ICM_ReComputeHash(ICM_REGION_MASK regions)
```

**Summary**

Re-compute the ICM hash area start for the given regions.

**Preconditions**

Region monitoring should be disabled.

**Parameters**

*region* The regions for which the digest will be re-computed.

**Returns**

None

---

### ICM_MonitorEnable

```c
void ICM_MonitorEnable(ICM_REGION_MASK regions)
```

**Summary**

Enable the ICM monitoring of the given regions.

**Preconditions**

None

**Parameters**

*region* The regions for which the monitoring will be enabled.

**Returns**

None

---

### ICM_MonitorDisable

```c
void ICM_MonitorDisable(ICM_REGION_MASK regions)
```

**Summary**

Disable the ICM monitoring of the given regions.

**Preconditions**

None

**Parameters**

*region* The regions for which the monitoring will be disabled.

**Returns**

None

---

### ICM_InterruptEnable

```c
void ICM_InterruptEnable(ICM_INT_MSK interruptMask)
```

**Summary**

Enables ICM Interrupt.

**Preconditions**

ICM_Initialize must have been called for the associated ICM instance.

**Parameters**

*interruptMask* Interrupt to be enabled.

**Returns**

None

---

### ICM_InterruptDisable

```c
void ICM_InterruptDisable(ICM_INT_MSK interruptMask)
```

**Summary**

Disables ICM Interrupt.

**Preconditions**

ICM_Initialize must have been called for the associated ICM instance.

**Parameters**

*interruptMask* Interrupt to be disabled.

**Returns**

None

---

### ICM_CallbackRegister

```c
void ICM_CallbackRegister(ICM_CALLBACK callback, uintptr_t context)
```

**Summary**

Sets the pointer to the function (and it's context) to be called when the given ICM's interrupt events occur.

**Description**

This function sets the pointer to a client function to be called "back" when the given ICM's interrupt events occur. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context.

**Preconditions**

ICM_Initialize must have been called for the associated ICM instance.

**Parameters**

*callback* A pointer to a function with a calling signature defined by the ICM_CALLBACK data type. Setting this to NULL disables the callback feature.

*contextHandle* A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**

None

**Example**

```c
    // Refer to the description of the ICM_CALLBACK data type for
    // example usage.
```

## Status functions

### ICM_StatusGet

```c
ICM_STATUS ICM_StatusGet(void)
```

**Summary**

Get the ICM Peripheral Status.

**Preconditions**

None

**Parameters**

None

**Returns**

The current ICM status.

---

### ICM_InterruptGet

```c
ICM_INT_MSK ICM_InterruptGet(void)
```

**Summary**

Returns the Interrupt status.

**Preconditions**

ICM_Initialize must have been called for the associated ICM instance.

**Parameters**

None

**Returns**

Interrupts that are active.

---

### ICM_InterruptMasked

```c
ICM_INT_MSK ICM_InterruptMasked(void)
```

**Summary**

Returns the current masked Interrupts.

**Preconditions**

ICM_Initialize must have been called for the associated ICM instance.

**Parameters**

None

**Returns**

Interrupts that are currently masked.
