---
grand_parent: Peripheral libraries
parent: TCMECC Peripheral Library
title: TCMECC Peripheral Library Interface
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

### TCMECC_STATUS

```c
typedef enum
{
    TCMECC_STATUS_MEM_FIX_I = TCMECC_SR_MEM_FIX_I_Msk,
    TCMECC_STATUS_MEM_FIX_D = TCMECC_SR_MEM_FIX_D_Msk,
    TCMECC_STATUS_CPT_FIX_MASK = TCMECC_SR_CPT_FIX_Msk,
    TCMECC_STATUS_OVER_FIX = TCMECC_SR_OVER_FIX_Msk,
    TCMECC_STATUS_MEM_NOFIX_I = TCMECC_SR_MEM_NOFIX_I_Msk,
    TCMECC_STATUS_MEM_NOFIX_D = TCMECC_SR_MEM_NOFIX_D_Msk,
    TCMECC_STATUS_CPT_NOFIX_MASK = TCMECC_SR_CPT_NOFIX_Msk,
    TCMECC_STATUS_OVER_NOFIX = TCMECC_SR_OVER_NOFIX_Msk,
    TCMECC_STATUS_HES_MASK = TCMECC_SR_HES_Msk,
    TCMECC_STATUS_ONE = TCMECC_SR_ONE_Msk,
    TCMECC_STATUS_MEM_ID_I = TCMECC_SR_MEM_ID_I_Msk,
    TCMECC_STATUS_MEM_ID_D = TCMECC_SR_MEM_ID_D_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    TCMECC_STATUS_INVALID = 0xFFFFFFFF
} TCMECC_STATUS;
```

**Summary**

Identifies the TCMECC current status.

**Description**

This data type identifies the TCMECC status.

---

### TCMECC_CALLBACK

```c
typedef void (*TCMECC_CALLBACK) (uintptr_t contextHandle);
```

**Summary**

TCMECC Callback Function Pointer.

**Description**

This data type defines the required function signature for the TCMECC callback function. Application must register a pointer to a callback function whose function signature (parameter and return value types) match the types specified by this function pointer in order to receive callback from the PLIB.

The parameters and return values are described here and a partial example implementation is provided.

**Parameters**

*contextHandle* Value identifying the context of the application that registered the callback function

**Remarks**

The context parameter contains the a handle to the client context, provided at the time the callback function was registered using the CallbackRegister function. This context handle value is passed back to the client as the "context" parameter. It can be any value (such as a pointer to the client's data) necessary to identify the client context or instance of the client that made the data transfer request.

The callback function executes in the PLIB's interrupt context. It is recommended of the application to not perform process intensive or blocking operations with in this function.

**Example**

```c
void APP_TCMECC_FixHandler(uintptr_t context)
{
    //Fixable error has occurred
}

TCMECC_FixCallbackRegister(&APP_TCMECC_FixHandler, (uintptr_t)NULL);
```

---

## TCMECC_OBJ

```c
typedef struct
{
    /* Transfer Event Callback for Fixable Error interrupt*/
    TCMECC_CALLBACK fix_callback;

    /* Transfer Event Callback Context for Fixable Error interrupt*/
    uintptr_t fix_context;

    /* Transfer Event Callback for NoFixable Error interrupt */
    TCMECC_CALLBACK nofix_callback;

    /* Transfer Event Callback Context for NoFixable Error interrupt */
    uintptr_t nofix_context;
} TCMECC_OBJ;
```

**Summary**

TCMECC PLib Object structure.

**Description**

This data structure defines the TCMECC PLib Instance Object.

## Initialization functions

### TCMECC_Initialize

```c
void TCMECC_Initialize(void)
```

**Summary**

Initializes given instance of the TCMECC peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

None

## Setup functions

### TCMECC_ResetCounters

```c
void TCMECC_ResetCounters(void)
```

**Summary**

Reset Fix and NoFix error counters of the TCMECC peripheral.

**Preconditions**

None

**Parameters**
None

**Returns**

None

---

### TCMECC_FixCallbackRegister

```c
void TCMECC_FixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t context)
```

**Summary**

Sets the pointer to the function (and it's context) to be called when the given TCMECC's Fixable interrupt events occur.

**Description**

This function sets the pointer to a client function to be called "back" when the given TCMECC's interrupt events occur. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context.

**Preconditions**

TCMECC_Initialize must have been called for the associated TCMECC instance.

**Parameters**

*callback* A pointer to a function with a calling signature defined by the TCMECC_CALLBACK data type. Setting this to NULL disables the callback feature.
*contextHandle* A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**

None

**Example**

```c
    // Refer to the description of the TCMECC_CALLBACK data type for
    // example usage.
```

---

## TCMECC_NoFixCallbackRegister

```c
void TCMECC_NoFixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t context)
```

**Summary**

Sets the pointer to the function (and it's context) to be called when the given TCMECC's UnFixable interrupt events occur.

**Description**

This function sets the pointer to a client function to be called "back" when the given TCMECC's interrupt events occur. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context.

**Preconditions**

TCMECC_Initialize must have been called for the associated TCMECC instance.

**Parameters**

*callback* A pointer to a function with a calling signature defined by the TCMECC_CALLBACK data type. Setting this to NULL disables the callback feature.
*contextHandle* A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**

None

**Example**

```c
    // Refer to the description of the TCMECC_CALLBACK data type for
    // example usage.
```

## Status functions

### TCMECC_StatusGet

```c
TCMECC_STATUS TCMECC_StatusGet(void)
```

**Summary**

Get the status of the TCMECC peripheral.

**Preconditions**

None

**Parameters**

None

**Returns**

Current status of the TCMECC peripheral.

---

### TCMECC_GetFailAddressITCM

```c
uint32_t TCMECC_GetFailAddressITCM(void)
```

**Summary**

Get the last fail address were ECC error occurs in Instruction TCM.

**Preconditions**

None

**Parameters**

None

**Returns**

Fail address were fixable or unfixable error occured in ITCM.

### TCMECC_GetFailAddressDTCM

```c
uint32_t TCMECC_GetFailAddressDTCM(void)
```

**Summary**

Get the last fail address were ECC error occurs in Data TCM.

**Preconditions**

None

**Parameters**

None

**Returns**

Fail address were fixable or unfixable error occured in DTCM.

## Test Mode functions

### TCMECC_TestModeReadEnable

```c
void TCMECC_TestModeReadEnable(void)
```

**Summary**

Enable the TCMECC peripheral test mode Read. When enabled the ECC check bit value read is updated in TESTCB1 register at each TCM data read.

**Preconditions**

None

**Parameters**

None

**Returns**

None

### TCMECC_TestModeReadDisable

```c
void TCMECC_TestModeReadDisable(void)
```

**Summary**

Disable the TCMECC peripheral test mode Read.

**Preconditions**

None

**Parameters**

None

**Returns**

None

### TCMECC_TestModeWriteEnable

```c
void TCMECC_TestModeWriteEnable(void)
```

**Summary**

Enable the TCMECC peripheral test mode Write. When enabled the ECC check bit value in TESTCB1 register is write in memory at each TCM data write instead of calculated check bit.

**Preconditions**

None

**Parameters**

None

**Returns**

None

### TCMECC_TestModeWriteDisable

```c
void TCMECC_TestModeWriteDisable(void)
```

**Summary**

Disable the TCMECC peripheral test mode Write.

**Preconditions**

None

**Parameters**

None

**Returns**

None

### TCMECC_TestModeGetCbValue

```c
void TCMECC_TestModeGetCbValue(uint8_t* tcb1, uint8_t* tcb2)
```

**Summary**

Get the TCMECC peripheral test mode check bit values.

**Preconditions**

None

**Parameters**

*tcb1* pointer of the variable to be updated with test check bit 1 value.
*tcb2* pointer of the variable to be updated with test check bit 2 value.

**Returns**

None

### TCMECC_TestModeSetCbValue

```c
void TCMECC_TestModeSetCbValue(uint8_t tcb1, uint8_t tcb2)
```

**Summary**

Set the TCMECC peripheral test mode check bit values.

**Preconditions**

None

**Parameters**

*tcb1* Test check bit 1 value to set.
*tcb2* Test check bit 2 value to set.

**Returns**

None
