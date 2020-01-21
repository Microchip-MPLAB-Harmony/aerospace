## FLEXRAMECC Library Interface

#### Data Types and Constants
* [FLEXRAMECC_STATUS](##-FLEXRAMECC_STATUS)
* [FLEXRAMECC_CALLBACK](##-FLEXRAMECC_CALLBACK)
* [FLEXRAMECC_OBJ](##-FLEXRAMECC_OBJ)

#### Initialization functions
* [FLEXRAMECC_Initialize](##-FLEXRAMECC_Initialize)

#### Setup functions
* [FLEXRAMECC_ResetCounters](##-FLEXRAMECC_ResetCounters)
* [FLEXRAMECC_FixCallbackRegister](##-FLEXRAMECC_FixCallbackRegister)
* [FLEXRAMECC_NoFixCallbackRegister](##-FLEXRAMECC_NoFixCallbackRegister)

#### Status functions
* [FLEXRAMECC_StatusGet](##-FLEXRAMECC_StatusGet)
* [FLEXRAMECC_GetFailAddress](##-FLEXRAMECC_GetFailAddress)

#### Test Mode functions
* [FLEXRAMECC_TestModeReadEnable](##-FLEXRAMECC_TestModeReadEnable)
* [FLEXRAMECC_TestModeReadDisable](##-FLEXRAMECC_TestModeReadDisable)
* [FLEXRAMECC_TestModeWriteEnable](##-FLEXRAMECC_TestModeWriteEnable)
* [FLEXRAMECC_TestModeWriteDisable](##-FLEXRAMECC_TestModeWriteDisable)
* [FLEXRAMECC_TestModeGetCbValue](##-FLEXRAMECC_TestModeGetCbValue)
* [FLEXRAMECC_TestModeGetCbValue](##-FLEXRAMECC_TestModeGetCbValue)

---

## FLEXRAMECC_STATUS
```C
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
**Summary**:   
&nbsp;&nbsp;Identifies the FLEXRAMECC current status

**Description**:   
&nbsp;&nbsp;This data type identifies the FLEXRAMECC status   

---

## FLEXRAMECC_CALLBACK
```C
typedef void (*FLEXRAMECC_CALLBACK) (uintptr_t contextHandle);
```
**Summary**:   
&nbsp;&nbsp;FLEXRAMECC Callback Function Pointer.

**Description**:   
&nbsp;&nbsp;This data type defines the required function signature for the FLEXRAMECC callback function.   
&nbsp;&nbsp;Application must register a pointer to a callback function whose function signature   
&nbsp;&nbsp;(parameter and return value types) match the types specified by this function pointer   
&nbsp;&nbsp;in order to receive callback from the PLIB.    
&nbsp;&nbsp;The parameters and return values are described here and a partial example implementation is provided.

**Parameters**:   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;Value identifying the context of the application that registered the callback function

**Remarks**:   
&nbsp;&nbsp;The context parameter contains the a handle to the client context, provided   
&nbsp;&nbsp;at the time the callback function was registered using the CallbackRegister function.   
&nbsp;&nbsp;This context handle value is passed back to the client as the "context" parameter.   
&nbsp;&nbsp;It can be any value (such as a pointer to the client's data) necessary to   
&nbsp;&nbsp;identify the client context or instance of the client that made the data transfer request. 

&nbsp;&nbsp;The callback function executes in the PLIB's interrupt context. It is recommended   
&nbsp;&nbsp;of the application to not perform process intensive or blocking operations with in this function.

**Example**:
```C
void APP_FLEXRAMECC_FixHandler(uintptr_t context)
{
    //Fixable error has occurred
}

FLEXRAMECC_FixCallbackRegister(&APP_FLEXRAMECC_FixHandler, (uintptr_t)NULL);
```

---

## FLEXRAMECC_OBJ
```C
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
**Summary**:
&nbsp;&nbsp;FLEXRAMECC PLib Object structure.

**Description**:   
&nbsp;&nbsp;This data structure defines the FLEXRAMECC PLib Instance Object.

---

## FLEXRAMECC_Initialize
/* Function:
```C
    void FLEXRAMECC_Initialize(void)
```
**Summary**:   
&nbsp;&nbsp;Initializes given instance of the FLEXRAMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_ResetCounters
```C
void FLEXRAMECC_ResetCounters(void)
```
**Summary**:   
&nbsp;&nbsp;Reset Fix and NoFix error counters of the FLEXRAMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_FixCallbackRegister
```C
    void FLEXRAMECC_FixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t context)
```
**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called   
&nbsp;&nbsp;when the given FLEXRAMECC's ECC Fixable Error interrupt events occur.

**Description**:   
&nbsp;&nbsp;This function sets the pointer to a client function to be called   
&nbsp;&nbsp;"back" when the given FLEXRAMECC's interrupt events occur. It also  
&nbsp;&nbsp; passes a context value (usually a pointer to a context structure)  
&nbsp;&nbsp; that is passed into the function when it is called. The specified  
&nbsp;&nbsp; callback function will be called from the peripheral interrupt context.

**Precondition**:   
&nbsp;&nbsp;FLEXRAMECC_Initialize must have been called for the associated FLEXRAMECC instance.

**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the FLEXRAMECC_CALLBACK data type.   
&nbsp;&nbsp;&nbsp;&nbsp;Setting this to NULL disables the callback feature.   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**:   
&nbsp;&nbsp;None

**Example**: 
```C
    // Refer to the description of the FLEXRAMECC_CALLBACK data type for
    // example usage.
```

---

## FLEXRAMECC_NoFixCallbackRegister
```C
void FLEXRAMECC_NoFixCallbackRegister(FLEXRAMECC_CALLBACK callback, uintptr_t context)
```

**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called when the given   
&nbsp;&nbsp;FLEXRAMECC's ECC Not Fixable Error interrupt events occur.

**Description**:   
&nbsp;&nbsp;This function sets the pointer to a client function to be called "back" when   
&nbsp;&nbsp;the given FLEXRAMECC's interrupt events occur. It also passes a context value   
&nbsp;&nbsp;(usually a pointer to a context structure) that is passed into the function   
&nbsp;&nbsp;when it is called. The specified callback function will be called from the   
&nbsp;&nbsp;peripheral interrupt context.

**Precondition**:   
&nbsp;&nbsp;FLEXRAMECC_Initialize must have been called for the associated FLEXRAMECC instance.   

**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the FLEXRAMECC_CALLBACK data type.   
&nbsp;&nbsp;&nbsp;&nbsp;Setting this to NULL disables the callback feature.   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**:   
&nbsp;&nbsp;None

**Example**: 
```C
    // Refer to the description of the FLEXRAMECC_CALLBACK data type for
    // example usage.
```

---

## FLEXRAMECC_StatusGet
```C
FLEXRAMECC_STATUS FLEXRAMECC_StatusGet(void)
```
**Summary**:   
&nbsp;&nbsp;Get the status of the FLEXRAMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current status of the FLEXRAMECC peripheral.

---

## FLEXRAMECC_GetFailAddress
```C
uint32_t FLEXRAMECC_GetFailAddress(void)
```

**Summary**:   
&nbsp;&nbsp;Get the last fail address were ECC error occurs in FLEXRAM memory.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Fail address were fixable or unfixable error occured in FLEXRAM memory.

---

## FLEXRAMECC_TestModeReadEnable
```C
void FLEXRAMECC_TestModeReadEnable(void)
```
**Summary**:   
&nbsp;&nbsp;Enable the FLEXRAMECC peripheral test mode Read. When enabled the   
&nbsp;&nbsp;ECC check bit value read is updated in TESTCB1 register at each FLEXRAM data read.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_TestModeReadDisable
```C
void FLEXRAMECC_TestModeReadDisable(void)
```
**Summary**:   
&nbsp;&nbsp;Disable the FLEXRAMECC peripheral test mode Read.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_TestModeWriteEnable
```C
void FLEXRAMECC_TestModeWriteEnable(void)
```
**Summary**:   
&nbsp;&nbsp;Enable the FLEXRAMECC peripheral test mode Write. When enabled the ECC check bit   
&nbsp;&nbsp;value in TESTCB1 register is write in memory at each FLEXRAM data write instead   
&nbsp;&nbsp;of calculated check bit.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_TestModeWriteDisable
```C
void FLEXRAMECC_TestModeWriteDisable(void)
```
**Summary**:   
&nbsp;&nbsp;Disable the FLEXRAMECC peripheral test mode Write.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## FLEXRAMECC_TestModeGetCbValue
```C
uint8_t FLEXRAMECC_TestModeGetCbValue(void)
```
**Summary**:   
&nbsp;&nbsp;Get the FLEXRAMECC peripheral test mode check bit values.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Test check bit value.

---

## FLEXRAMECC_TestModeSetCbValue
```C
void FLEXRAMECC_TestModeSetCbValue(uint8_t tcb1)
```
**Summary**:   
&nbsp;&nbsp;Set the FLEXRAMECC peripheral test mode check bit values.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*tcb1*   
&nbsp;&nbsp;&nbsp;&nbsp;Test check bit value to set.

**Returns**:   
&nbsp;&nbsp;None
