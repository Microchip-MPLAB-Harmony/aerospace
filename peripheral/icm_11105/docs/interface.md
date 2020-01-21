# ICM Library Interface

### Data Types and Constants
* [ICM_REGION_MASK](##-ICM_REGION_MASK)
* [ICM_INT_MSK](##-ICM_INT_MSK)
* [ICM_STATUS](##-ICM_STATUS)
* [ICM_CALLBACK](##-ICM_CALLBACK)
* [ICM_OBJ](##-ICM_OBJ)

#### Initialization functions
* [ICM_Initialize](##-ICM_Initialize)
* [ICM_SetHashStartAddress](##-ICM_SetHashStartAddress)

#### Setup functions
* [ICM_SetEndOfMonitoringDisable](##-ICM_SetEndOfMonitoringDisable)
* [ICM_WriteBackDisable](##-ICM_WriteBackDisable)
* [ICM_SoftwareReset](##-ICM_SoftwareReset)
* [ICM_SetDescStartAddress](##-ICM_SetDescStartAddress)
* [ICM_Enable](##-ICM_Enable)
* [ICM_Disable](##-ICM_Disable)
* [ICM_ReComputeHash](##-ICM_ReComputeHash)
* [ICM_MonitorEnable](##-ICM_MonitorEnable)
* [ICM_MonitorDisable](##-ICM_MonitorDisable)
* [ICM_InterruptEnable](##-ICM_InterruptEnable)
* [ICM_InterruptDisable](##-ICM_InterruptDisable)
* [ICM_CallbackRegister](##-ICM_CallbackRegister)

#### Status functions
* [ICM_StatusGet](##-ICM_StatusGet)
* [ICM_InterruptGet](##-ICM_InterruptGet)
* [ICM_InterruptMasked](##-ICM_InterruptMasked)

---

## ICM_REGION_MASK
```C
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
**Summary**:   
&nbsp;&nbsp;ICM Region Mask.

**Description**:   
&nbsp;&nbsp;This data type defines the ICM Region.  

---

## ICM_INT_MSK
```C
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
**Summary**:   
&nbsp;&nbsp;ICM Interrupt Mask.

**Description**:   
&nbsp;&nbsp;This data type defines the ICM Interrupt sources.   

---

## ICM_STATUS
```C
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
**Summary**:   
&nbsp;&nbsp;Identifies the ICM current status.

**Description**:   
&nbsp;&nbsp;This data type identifies the ICM status.   

---

## ICM_CALLBACK
```C
typedef void (*ICM_CALLBACK) (uintptr_t contextHandle);
```
**Summary**:   
&nbsp;&nbsp;ICM Callback Function Pointer.

**Description**:   
&nbsp;&nbsp;This data type defines the required function signature for the ICM callback function.   
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
void APP_ICM_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

ICM_CallbackRegister(&APP_ICM_Handler, (uintptr_t)NULL);
```
----

## ICM_OBJ
```C
typedef struct
{
    /* Transfer Event Callback */
    ICM_CALLBACK callback;

    /* Transfer Event Callback Context */
    uintptr_t context;
} ICM_OBJ;
```
**Summary**:   
&nbsp;&nbsp;ICM PLib Object structure.

**Description**:   
&nbsp;&nbsp;This data structure defines the ICM PLib Instance Object.

---

## ICM_Initialize
/* Function:
```C
void ICM_Initialize(void)
```
**Summary**:   
&nbsp;&nbsp;Initializes given instance of the ICM peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## ICMICM_SetHashStartAddress
/* Function:
```C
void ICMICM_SetHashStartAddress(void)
```
**Summary**:   
&nbsp;&nbsp;Set the ICM hash area start address register.

**Description**:   
&nbsp;&nbsp;The ICM Hash Area should be a contiguous area of system memory that the controller   
&nbsp;&nbsp;and the processor can access. This address is a multiple of 128 bytes.   
&nbsp;&nbsp;For each region, 32 bytes are used to store the computed hash.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*addr*   
&nbsp;&nbsp;&nbsp;&nbsp;The address of the ICM Hash memory location.

**Returns**:   
&nbsp;&nbsp;None

**Remarks**:   
&nbsp;&nbsp;This field points at the Hash memory location. The address must be aligned to 128 bytes.

---

## ICM_SetEndOfMonitoringDisable
/* Function:
```C
void ICM_SetEndOfMonitoringDisable(bool disable)
```
**Summary**:   
&nbsp;&nbsp;Disables/enables the ICM End of Monitoring Configuration.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*disable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, End of Monitoring is disabled. Enabled if false.  

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_WriteBackDisable
/* Function:
```C
void ICM_WriteBackDisable(bool disable)
```
**Summary**:   
&nbsp;&nbsp;Disables/enables the ICM Write Back Configuration.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*disable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, Write Back is disabled. Enabled if false.  

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_SoftwareReset
/* Function:
```C
void ICM_SoftwareReset(void)
```
**Summary**:   
&nbsp;&nbsp;Reset the ICM Peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## ICMICM_SetDescStartAddress
/* Function:
```C
void ICMICM_SetDescStartAddress(icm_descriptor_registers_t* addr)
```
**Summary**:   
&nbsp;&nbsp;Set the ICM descriptor area start address register.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*addr*   
&nbsp;&nbsp;&nbsp;&nbsp;The address of the ICM list descriptor.    

**Returns**:   
&nbsp;&nbsp;None

**Remarks**:   
&nbsp;&nbsp;The start address must be aligned with size of the data structure (64 bytes).

---

## ICM_Enable
/* Function:
```C
void ICM_Enable(void)
```
**Summary**:   
&nbsp;&nbsp;Enable the ICM Peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_Disable
/* Function:
```C
void ICM_Disable(void)
```
**Summary**:   
&nbsp;&nbsp;Disable the ICM Peripheral.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_ReComputeHash
/* Function:
```C
void ICM_ReComputeHash(ICM_REGION_MASK regions)
```
**Summary**:   
&nbsp;&nbsp;Re-compute the ICM hash area start for the given regions.

**Precondition**:   
&nbsp;&nbsp;Region monitoring should be disabled.   

**Parameters**:   
&nbsp;&nbsp;*region*   
&nbsp;&nbsp;&nbsp;&nbsp;The regions for which the digest will be re-computed.   

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_MonitorEnable
/* Function:
```C
void ICM_MonitorEnable(ICM_REGION_MASK regions)
```
**Summary**:   
&nbsp;&nbsp;Enable the ICM monitoring of the given regions.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*region*   
&nbsp;&nbsp;&nbsp;&nbsp;The regions for which the monitoring will be enabled.   

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_MonitorDisable
/* Function:
```C
void ICM_MonitorDisable(ICM_REGION_MASK regions)
```
**Summary**:   
&nbsp;&nbsp;Disable the ICM monitoring of the given regions.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;*region*   
&nbsp;&nbsp;&nbsp;&nbsp;The regions for which the monitoring will be disabled.

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_InterruptEnable
/* Function:
```C
void ICM_InterruptEnable(ICM_INT_MSK interruptMask)
```
**Summary**:   
&nbsp;&nbsp;Enables ICM Interrupt.

**Precondition**:   
&nbsp;&nbsp;ICM_Initialize must have been called for the associated ICM instance.  

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be enabled.  

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_InterruptDisable
/* Function:
```C
void ICM_InterruptDisable(ICM_INT_MSK interruptMask)
```
**Summary**:   
&nbsp;&nbsp;Disables ICM Interrupt.

**Precondition**:   
&nbsp;&nbsp;ICM_Initialize must have been called for the associated ICM instance.  

**Parameters**:   
&nbsp;&nbsp;*interruptMask*   
&nbsp;&nbsp;&nbsp;&nbsp;Interrupt to be disabled.

**Returns**:   
&nbsp;&nbsp;None

---

## ICM_CallbackRegister
/* Function:
```C
void ICM_CallbackRegister(ICM_CALLBACK callback, uintptr_t context)
```
**Summary**:   
&nbsp;&nbsp;Sets the pointer to the function (and it's context) to be called when the   
&nbsp;&nbsp;given ICM's interrupt events occur.

**Description**:   
&nbsp;&nbsp;This function sets the pointer to a client function to be called "back" when   
&nbsp;&nbsp;the given ICM's interrupt events occur. It also passes a context value   
&nbsp;&nbsp;(usually a pointer to a context structure) that is passed into the function   
&nbsp;&nbsp;when it is called. The specified callback function will be called from the   
&nbsp;&nbsp;peripheral interrupt context.

**Precondition**:   
&nbsp;&nbsp;ICM_Initialize must have been called for the associated ICM instance.   
**Parameters**:   
&nbsp;&nbsp;*callback*   
&nbsp;&nbsp;&nbsp;&nbsp;A pointer to a function with a calling signature defined by the ICM_CALLBACK data type.   
&nbsp;&nbsp;&nbsp;&nbsp;Setting this to NULL disables the callback feature.   
&nbsp;&nbsp;*contextHandle*   
&nbsp;&nbsp;&nbsp;&nbsp;A value (usually a pointer) passed (unused) into the function identified by the callback parameter.

**Returns**:   
&nbsp;&nbsp;None

**Example**: 
```C
    // Refer to the description of the ICM_CALLBACK data type for
    // example usage.
```

---

## ICM_StatusGet
/* Function:
```C
ICM_STATUS ICM_StatusGet(void)
```
**Summary**:   
&nbsp;&nbsp;Get the ICM Peripheral Status.

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;The current ICM status.

---

## ICM_InterruptGet
/* Function:
```C
ICM_INT_MSK ICM_InterruptGet(void)
```
**Summary**:   
&nbsp;&nbsp;Returns the Interrupt status.

**Precondition**:   
&nbsp;&nbsp;ICM_Initialize must have been called for the associated ICM instance.  

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Interrupts that are active.

---

## ICM_InterruptMasked
/* Function:
```C
ICM_INT_MSK ICM_InterruptMasked(void)
```
**Summary**:   
&nbsp;&nbsp;Returns the current masked Interrupts.

**Precondition**:   
&nbsp;&nbsp;ICM_Initialize must have been called for the associated ICM instance.  

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Interrupts that are currently masked.
