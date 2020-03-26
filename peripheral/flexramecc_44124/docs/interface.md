---
grand_parent: Peripheral libraries
parent: FLEXRAMECC Peripheral Library
title: FLEXRAMECC Peripheral Library Interface
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

### FLEXRAMECC_STATUS

```c
typedef enum
{
    FLEXRAMECC_STATUS_MEM_FIX = FLEXRAMECC_SR_MEM_FIX_Msk,
    FLEXRAMECC_STATUS_CPT_FIX_MASK = FLEXRAMECC_SR_CPT_FIX_Msk,
    FLEXRAMECC_STATUS_OVER_FIX = FLEXRAMECC_SR_OVER_FIX_Msk,
    FLEXRAMECC_STATUS_MEM_NOFIX = FLEXRAMECC_SR_MEM_NOFIX_Msk,
    FLEXRAMECC_STATUS_CPT_NOFIX_MASK = FLEXRAMECC_SR_CPT_NOFIX_Msk,
    FLEXRAMECC_STATUS_OVER_NOFIX = FLEXRAMECC_SR_OVER_NOFIX_Msk,
    FLEXRAMECC_STATUS_HES_MASK = FLEXRAMECC_SR_HES_Msk,
    FLEXRAMECC_STATUS_TYPE = FLEXRAMECC_SR_TYPE_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    FLEXRAMECC_STATUS_INVALID = 0xFFFFFFFF
} FLEXRAMECC_STATUS;
```

**Summary**

 Identifies the FLEXRAMECC current status

**Description**

 This data type identifies the FLEXRAMECC status

---

### FLEXRAMECC_CALLBACK

```c
typedef void (*FLEXRAMECC_CALLBACK) (uintptr_t contextHandle);
```

**Summary**

FLEXRAMECC Callback Function Pointer.

**Description**

This data type defines the required function signature for the FLEXRAMECC callback function.
Application must register a pointer to a callback function whose function signature (parameter and return value types) match the types specified by this function pointer in order to receive callback from the PLIB.
The parameters and return values are described here and a partial example implementation is provided.

**Parameters**

*contextHandle* Value identifying the context of the application that registered the callback function

**Remarks**

The context parameter contains the a handle to the client context, provided at the time the callback function was registered using the CallbackRegister function.
This context handle value is passed back to the client as the "context" parameter.
It can be any value (such as a pointer to the client's data) necessary to identify the client context or instance of the client that made the data transfer request.

The callback function executes in the PLIB's interrupt context. It is recommended of the application to not perform process intensive or blocking operations with in this function.

**Example**

```c
void APP_FLEXRAMECC_FixHandler(uintptr_t context)
{
    //Fixable error has occurred
}

FLEXRAMECC_FixCallbackRegister(&APP_FLEXRAMECC_FixHandler, (uintptr_t)NULL);
```

---

### FLEXRAMECC_OBJ

```c
typedef struct
{
    /* Transfer Event Callback for Fixable Error interrupt*/
    FLEXRAMECC_CALLBACK fix_callback;

    /* Transfer Event Callback Context for Fixable Error interrupt*/
    uintptr_t fix_context;

    /* Transfer Event Callback for NoFixable Error interrupt*/
    FLEXRAMECC_CALLBACK nofix_callback;

    /* Transfer Event Callback Context for NoFixable Error interrupt*/
    uintptr_t nofix_context;
} FLEXRAMECC_OBJ;
```

**Summary**

 FLEXRAMECC PLib Object structure.

**Description**

 This data structure defines the FLEXRAMECC PLib Instance Object.

---

## Initialization functions

### FLEXRAMECC_Initialize

```c
    void FLEXRAMECC_Initialize(void)
```

**Summary**

 Initializes given instance of the FLEXRAMECC peripheral.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

## Setup functions

### FLEXRAMECC_ResetCounters

```c
void FLEXRAMECC_ResetCounters(void)
```

**Summary**

 Reset Fix and NoFix error counters of the FLEXRAMECC peripheral.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

### FLEXRAMECC_FixCallbackRegister

```c
void FLEXRAMECC_FixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t context)
```

**Summary**

 Sets the pointer to the function (and it's context) to be called when the given FLEXRAMECC's ECC Fixable Error interrupt events occur.

**Description**

 This function sets the pointer to a client function to be called "back" when the given FLEXRAMECC's interrupt events occur. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context.

**Preconditions**

 FLEXRAMECC_Initialize must have been called for the associated FLEXRAMECC instance.

**Parameters**

  *callback*
    A pointer to a function with a calling signature defined by the FLEXRAMECC_CALLBACK data type.
    Setting this to NULL disables the callback feature.
  *contextHandle*
    A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**

 None

**Example**

Refer to the description of the [FLEXRAMECC_CALLBACK](#flexramecc_callback) data type for example usage.

---

### FLEXRAMECC_NoFixCallbackRegister

```c
void FLEXRAMECC_NoFixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t context)
```

**Summary**

 Sets the pointer to the function (and it's context) to be called when the given FLEXRAMECC's ECC Not Fixable Error interrupt events occur.

**Description**

 This function sets the pointer to a client function to be called "back" when the given FLEXRAMECC's interrupt events occur. It also passes a context value (usually a pointer to a context structure) that is passed into the function when it is called. The specified callback function will be called from the peripheral interrupt context.

**Preconditions**

 FLEXRAMECC_Initialize must have been called for the associated FLEXRAMECC instance.

**Parameters**

  *callback*
    A pointer to a function with a calling signature defined by the FLEXRAMECC_CALLBACK data type.
    Setting this to NULL disables the callback feature.
  *contextHandle*
    A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**

 None

**Example**

Refer to the description of the [FLEXRAMECC_CALLBACK](#flexramecc_callback) data type for example usage.

---

## Status functions

### FLEXRAMECC_StatusGet

```c
FLEXRAMECC_STATUS FLEXRAMECC_StatusGet(void)
```

**Summary**

 Get the status of the FLEXRAMECC peripheral.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 Current status of the FLEXRAMECC peripheral.

---

### FLEXRAMECC_GetFailAddress

```c
uint32_t FLEXRAMECC_GetFailAddress(void)
```

**Summary**

 Get the last fail address were ECC error occurs in FLEXRAM memory.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 Fail address were fixable or unfixable error occured in FLEXRAM memory.

---

### FLEXRAMECC_TestModeReadEnable

```c
void FLEXRAMECC_TestModeReadEnable(void)
```

**Summary**

 Enable the FLEXRAMECC peripheral test mode Read. When enabled the ECC check bit value read is updated in TESTCB1 register at each FLEXRAM data read.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

### FLEXRAMECC_TestModeReadDisable

```c
void FLEXRAMECC_TestModeReadDisable(void)
```

**Summary**

 Disable the FLEXRAMECC peripheral test mode Read.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

### FLEXRAMECC_TestModeWriteEnable

```c
void FLEXRAMECC_TestModeWriteEnable(void)
```

**Summary**

 Enable the FLEXRAMECC peripheral test mode Write. When enabled the ECC check bit value in TESTCB1 register is write in memory at each FLEXRAM data write instead of calculated check bit.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

### FLEXRAMECC_TestModeWriteDisable

```c
void FLEXRAMECC_TestModeWriteDisable(void)
```

**Summary**

 Disable the FLEXRAMECC peripheral test mode Write.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 None

---

### FLEXRAMECC_TestModeGetCbValue

```c
uint8_t FLEXRAMECC_TestModeGetCbValue(void)
```

**Summary**

 Get the FLEXRAMECC peripheral test mode check bit values.

**Preconditions**

 None

**Parameters**

 None

**Returns**

 Test check bit value.

---

### FLEXRAMECC_TestModeSetCbValue

```c
void FLEXRAMECC_TestModeSetCbValue(uint8_t tcb1)
```

**Summary**

 Set the FLEXRAMECC peripheral test mode check bit values.

**Preconditions**

 None

**Parameters**

  *tcb1*
    Test check bit value to set.

**Returns**

 None
