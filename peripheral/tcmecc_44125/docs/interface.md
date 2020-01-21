# TCMECC Library Interface

#### Data Types and Constants
* [TCMECC_STATUS](##-TCMECC_STATUS)
* [TCMECC_CALLBACK](##-TCMECC_CALLBACK)
* [TCMECC_OBJ](##-TCMECC_OBJ)
#### Initialization functions
* [TCMECC_Initialize](##-TCMECC_Initialize)
#### Setup functions
* [TCMECC_ResetCounters](##-TCMECC_ResetCounters)
* [TCMECC_FixCallbackRegister](##-TCMECC_FixCallbackRegister)
* [TCMECC_NoFixCallbackRegister](##-TCMECC_NoFixCallbackRegister)
#### Status functions
* [TCMECC_StatusGet](##-TCMECC_StatusGet)
* [TCMECC_GetFailAddressITCM](##-TCMECC_GetFailAddressITCM)
* [TCMECC_GetFailAddressDTCM](##-TCMECC_GetFailAddressDTCM)
#### Test Mode functions
* [TCMECC_TestModeReadEnable](##-TCMECC_TestModeReadEnable)
* [TCMECC_TestModeReadDisable](##-TCMECC_TestModeReadDisable)
* [TCMECC_TestModeWriteEnable](##-TCMECC_TestModeWriteEnable)
* [TCMECC_TestModeWriteDisable](##-TCMECC_TestModeWriteDisable)
* [TCMECC_TestModeGetCbValue](##-TCMECC_TestModeGetCbValue)
* [TCMECC_TestModeSetCbValue](##-TCMECC_TestModeSetCbValue)

---

## TCMECC_STATUS
```C
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

**Summary**:
&nbsp;&nbsp;Identifies the TCMECC current status.

**Description**:   
&nbsp;&nbsp;This data type identifies the TCMECC status.

---

## TCMECC_CALLBACK
```C
typedef void (*TCMECC_CALLBACK) (uintptr_t contextHandle);
```

**Summary**:   
&nbsp;&nbsp;TCMECC Callback Function Pointer.

**Description**:   
&nbsp;&nbsp;This data type defines the required function signature for the TCMECC callback function.   
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
void APP_TCMECC_FixHandler(uintptr_t context)
{
    //Fixable error has occurred
}

TCMECC_FixCallbackRegister(&APP_TCMECC_FixHandler, (uintptr_t)NULL);
```

---

## TCMECC_OBJ
```C
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

**Summary**:
&nbsp;&nbsp;TCMECC PLib Object structure.

**Description**:   
&nbsp;&nbsp;This data structure defines the TCMECC PLib Instance Object.

---

## TCMECC_Initialize
```C
void TCMECC_Initialize(void)
```
**Summary**:   
&nbsp;&nbsp;Initializes given instance of the TCMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_ResetCounters
```C
void TCMECC_ResetCounters(void)
```
**Summary**:   
&nbsp;&nbsp;Reset Fix and NoFix error counters of the TCMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_FixCallbackRegister
```C
void TCMECC_FixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t context)
```
**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called when the   
&nbsp;&nbsp;given TCMECC's Fixable interrupt events occur.

**Description**:   
&nbsp;&nbsp;This function sets the pointer to a client function to be called "back" when   
&nbsp;&nbsp;the given TCMECC's interrupt events occur. It also passes a context value   
&nbsp;&nbsp;(usually a pointer to a context structure) that is passed into the function   
&nbsp;&nbsp;when it is called. The specified callback function will be called from the   
&nbsp;&nbsp;peripheral interrupt context.

**Precondition**:   
&nbsp;&nbsp;TCMECC_Initialize must have been called for the associated TCMECC instance.   

**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the TCMECC_CALLBACK data type.   
&nbsp;&nbsp;&nbsp;&nbsp;Setting this to NULL disables the callback feature.   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**:   
&nbsp;&nbsp;None

**Example**: 
```C
    // Refer to the description of the TCMECC_CALLBACK data type for
    // example usage.
```

---

## TCMECC_NoFixCallbackRegister
```C
void TCMECC_NoFixCallbackRegister(TCMECC_CALLBACK callback, uintptr_t context)
```
**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called when the   
&nbsp;&nbsp;given TCMECC's UnFixable interrupt events occur.

**Description**: 
&nbsp;&nbsp;This function sets the pointer to a client function to be called "back" when   
&nbsp;&nbsp;the given TCMECC's interrupt events occur. It also passes a context value   
&nbsp;&nbsp;(usually a pointer to a context structure) that is passed into the function   
&nbsp;&nbsp;when it is called. The specified callback function will be called from the   
&nbsp;&nbsp;peripheral interrupt context.

**Precondition**:   
&nbsp;&nbsp;TCMECC_Initialize must have been called for the associated TCMECC instance.   

**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the TCMECC_CALLBACK data type.   
&nbsp;&nbsp;&nbsp;&nbsp;Setting this to NULL disables the callback feature.   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**:   
&nbsp;&nbsp;None

**Example**: 
```C
    // Refer to the description of the TCMECC_CALLBACK data type for
    // example usage.
```

---

## TCMECC_StatusGet
```C
TCMECC_STATUS TCMECC_StatusGet(void)
```
**Summary**:   
&nbsp;&nbsp;Get the status of the TCMECC peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current status of the TCMECC peripheral.

---

## TCMECC_GetFailAddressITCM
```C
uint32_t TCMECC_GetFailAddressITCM(void)
```
**Summary**:   
&nbsp;&nbsp;Get the last fail address were ECC error occurs in Instruction TCM.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Fail address were fixable or unfixable error occured in ITCM.

---

## TCMECC_GetFailAddressDTCM
```C
uint32_t TCMECC_GetFailAddressDTCM(void)
```
**Summary**:   
&nbsp;&nbsp;Get the last fail address were ECC error occurs in Data TCM.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Fail address were fixable or unfixable error occured in DTCM.

---

## TCMECC_TestModeReadEnable
```C
void TCMECC_TestModeReadEnable(void)
```
**Summary**:   
&nbsp;&nbsp;Enable the TCMECC peripheral test mode Read. When enabled the   
&nbsp;&nbsp;ECC check bit value read is updated in TESTCB1 register at each TCM data read.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_TestModeReadDisable
```C
void TCMECC_TestModeReadDisable(void)
```
**Summary**:   
&nbsp;&nbsp;Disable the TCMECC peripheral test mode Read.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_TestModeWriteEnable
```C
void TCMECC_TestModeWriteEnable(void)
```
**Summary**:   
&nbsp;&nbsp;Enable the TCMECC peripheral test mode Write. When enabled the   
&nbsp;&nbsp;ECC check bit value in TESTCB1 register is write in memory at each   
&nbsp;&nbsp;TCM data write instead of calculated check bit.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_TestModeWriteDisable
```C
void TCMECC_TestModeWriteDisable(void)
```
**Summary**:   
&nbsp;&nbsp;Disable the TCMECC peripheral test mode Write.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_TestModeGetCbValue
```C
void TCMECC_TestModeGetCbValue(uint8_t* tcb1, uint8_t* tcb2)
```
**Summary**:   
&nbsp;&nbsp;Get the TCMECC peripheral test mode check bit values.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*tcb1*   
&nbsp;&nbsp;&nbsp;&nbsp;pointer of the variable to be updated with test check bit 1 value.   
&nbsp;&nbsp;*tcb2*   
&nbsp;&nbsp;&nbsp;&nbsp;pointer of the variable to be updated with test check bit 2 value.

**Returns**:   
&nbsp;&nbsp;None

---

## TCMECC_TestModeSetCbValue
```C
void TCMECC_TestModeSetCbValue(uint8_t tcb1, uint8_t tcb2)
```
**Summary**:   
&nbsp;&nbsp;Set the TCMECC peripheral test mode check bit values.

**Precondition**:   
&nbsp;&nbsp;None  

**Parameters**:   
&nbsp;&nbsp;*tcb1*   
&nbsp;&nbsp;&nbsp;&nbsp;Test check bit 1 value to set.    
&nbsp;&nbsp;*tcb2*   
&nbsp;&nbsp;&nbsp;&nbsp;Test check bit 2 value to set.    

**Returns**:   
&nbsp;&nbsp;None
