# IP1553 Library Interface

#### Data Types and Constants
* [IP1553_INT_MASK](##-IP1553_INT_MASK)
* [IP1553_CALLBACK](##-IP1553_CALLBACK)
* [IP1553_OBJ](##-IP1553_OBJ)
* [IP1553_DATA_TX_TYPE](##-IP1553_DATA_TX_TYPE)
* [IP1553_BUS](##-IP1553_BUS)

#### Initialization functions
* [IP1553_Initialize](##-IP1553_initialize)

#### Setup functions
* [IP1553_BuffersConfigSet](##-IP1553_buffersconfigset)
* [IP1553_ResetTxBuffersStatus](##-IP1553_resettxbuffersstatus)
* [IP1553_ResetRxBuffersStatus](##-IP1553_resetrxbuffersstatus)
* [IP1553_BcStartDataTransfer](##-IP1553_bcstartdatatransfer)
* [IP1553_GetFirstStatusWord](##-IP1553_getfirststatusword)
* [IP1553_GetSecondStatusWord](##-IP1553_getsecondstatusword)
* [IP1553_BCEnableCmdSet](##-IP1553_bcenablecmdset)
* [IP1553_SREQBitCmdSet](##-IP1553_sreqbitcmdset)
* [IP1553_BusyBitCmdSet](##-IP1553_busybitcmdset)
* [IP1553_SSBitCmdSet](##-IP1553_ssbitcmdset)
* [IP1553_TRBitCmdSet](##-IP1553_trbitcmdset)

#### Status functions
* [IP1553_GetTxBuffersStatus](##-IP1553_gettxbuffersstatus)
* [IP1553_GetRxBuffersStatus](##-IP1553_getrxbuffersstatus)
* [IP1553_IrqStatusGet](##-IP1553_irqstatusget)

---

## IP1553_INT_MASK
```C
typedef enum
{
    IP1553_INT_MASK_EMT = IP1553_IER_EMT_Msk,
    IP1553_INT_MASK_MTE = IP1553_IER_MTE_Msk,
    IP1553_INT_MASK_ERX = IP1553_IER_ERX_Msk,
    IP1553_INT_MASK_ETX = IP1553_IER_ETX_Msk, 
    IP1553_INT_MASK_ETRANS_MASK = IP1553_IER_ETRANS_Msk,
    IP1553_INT_MASK_TE = IP1553_IER_TE_Msk,
    IP1553_INT_MASK_TCE = IP1553_IER_TCE_Msk,
    IP1553_INT_MASK_TPE = IP1553_IER_TPE_Msk,
    IP1553_INT_MASK_TDE = IP1553_IER_TDE_Msk,
    IP1553_INT_MASK_TTE = IP1553_IER_TTE_Msk,
    IP1553_INT_MASK_TWE = IP1553_IER_TWE_Msk,
    IP1553_INT_MASK_BE = IP1553_IER_BE_Msk,
    IP1553_INT_MASK_ITR = IP1553_IER_ITR_Msk,
    IP1553_INT_MASK_TVR = IP1553_IER_TVR_Msk,
    IP1553_INT_MASK_DBR = IP1553_IER_DBR_Msk,
    IP1553_INT_MASK_STR = IP1553_IER_STR_Msk,
    IP1553_INT_MASK_TSR = IP1553_IER_TSR_Msk,
    IP1553_INT_MASK_OSR = IP1553_IER_OSR_Msk,
    IP1553_INT_MASK_SDR = IP1553_IER_SDR_Msk,
    IP1553_INT_MASK_SWD = IP1553_IER_SWD_Msk,
    IP1553_INT_MASK_RRT = IP1553_IER_RRT_Msk,
    IP1553_INT_MASK_ITF = IP1553_IER_ITF_Msk,
    IP1553_INT_MASK_OTF = IP1553_IER_OTF_Msk,
    IP1553_INT_MASK_IPB = IP1553_IER_IPB_Msk, 
    IP1553_INT_MASK_ERROR_MASK = ( IP1553_INT_MASK_MTE |
                                   IP1553_INT_MASK_TE |
                                   IP1553_INT_MASK_TCE |
                                   IP1553_INT_MASK_TPE |
                                   IP1553_INT_MASK_TDE |
                                   IP1553_INT_MASK_TTE |
                                   IP1553_INT_MASK_TWE |
                                   IP1553_INT_MASK_BE |
                                   IP1553_INT_MASK_ITR ),
    /* Force the compiler to reserve 32-bit memory for enum */
    IP1553_INT_MASK_INVALID = 0xFFFFFFFF
} IP1553_INT_MASK;
```

**Summary**:   
&nbsp;&nbsp;Identifies the IP1553 current interrupt status   

**Description**:   
&nbsp;&nbsp;This data type identifies the IP1553 interrupt status   

---

## IP1553_CALLBACK
```C
typedef void (*IP1553_CALLBACK) (uintptr_t contextHandle);
```

**Summary**:   
&nbsp;&nbsp;IP1553 Callback Function Pointer.

**Description**:   
&nbsp;&nbsp;This data type defines the required function signature for the IP1553 callback function.   
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
void APP_IP1553_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

IP1553_CallbackRegister(&APP_IP1553_Handler, (uintptr_t)NULL);
```

---

## IP1553_OBJ
```C
typedef struct
{
    /* Transfer Event Callback */
    IP1553_CALLBACK callback;

    /* Transfer Event Callback Context */
    uintptr_t context;
} IP1553_OBJ;
```

**Summary**:   
&nbsp;&nbsp;IP1553 PLib Object structure   

**Description**:   
&nbsp;&nbsp;This data structure defines the IP1553 PLib Instance Object   

---

## IP1553_DATA_TX_TYPE
```C
typedef enum
{
    IP1553_DATA_TX_TYPE_BC_TO_RT = 0,
    IP1553_DATA_TX_TYPE_RT_TO_BC,
    IP1553_DATA_TX_TYPE_RT_TO_RT,
} IP1553_DATA_TX_TYPE;
```
**Summary**:   
&nbsp;&nbsp;IP1553 data transfer types   

**Description**:   
&nbsp;&nbsp;This data type identifies the data transfer type that BC initiate   

---

## IP1553_BUS
```C
typedef enum
{
    IP1553_BUS_A = 0,
    IP1553_BUS_B
} IP1553_BUS;
```
**Summary**:   
&nbsp;&nbsp;IP1553 output bus selection   

**Description**:   
&nbsp;&nbsp;This data type identifies the IP1553 output bus selection   

---

## IP1553_Initialize
```C
void IP1553_Initialize(void)
```

**Summary**:   
&nbsp;&nbsp;Initializes given instance of the IP1553 peripheral   
&nbsp;&nbsp;Set the Mode (Bus Controller or Remote Terminal) and reset the instance   
&nbsp;&nbsp;In RT mode, set the RT Address   
&nbsp;&nbsp;Enable all 1553 interrupt sources   

**Precondition**:   
&nbsp;&nbsp;None   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_BuffersConfigSet
```C
void IP1553_BuffersConfigSet(uint16_t* txBuffers, uint16_t* rxBuffers)
```

**Summary**:   
&nbsp;&nbsp;Set the memory base address for emmission and reception buffers   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*txBuffers*   
&nbsp;&nbsp;&nbsp;&nbsp;Pointer to application allocated emission buffer base address.   
&nbsp;&nbsp;&nbsp;&nbsp;Application must allocate buffer from non-cached   
&nbsp;&nbsp;&nbsp;&nbsp;contiguous memory and buffer size must be   
&nbsp;&nbsp;&nbsp;&nbsp;16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM   

&nbsp;&nbsp;*rxBuffers*   
&nbsp;&nbsp;&nbsp;&nbsp;Pointer to application allocated reception buffer base address.   
&nbsp;&nbsp;&nbsp;&nbsp;Application must allocate buffer from non-cached   
&nbsp;&nbsp;&nbsp;&nbsp;contiguous memory and buffer size must be   
&nbsp;&nbsp;&nbsp;&nbsp;16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_GetTxBuffersStatus
```C
uint32_t IP1553_GetTxBuffersStatus(void)
```

**Summary**:   
&nbsp;&nbsp;Returns the transmission buffers status   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Bitfield value that indicates for each of the 32 buffers if they are   
&nbsp;&nbsp;ready to be sent (1) or are empty (0)

---

## IP1553_ResetTxBuffersStatus
```C
void IP1553_ResetTxBuffersStatus(uint32_t buffers)
```

**Summary**:   
&nbsp;&nbsp;Reset the transmission buffers status   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*buffers*   
&nbsp;&nbsp;&nbsp;&nbsp;Bitfield of buffer to be reset.   
&nbsp;&nbsp;&nbsp;&nbsp;When reset a buffer is set ready to be sent (1) in status   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_GetRxBuffersStatus
```C
uint32_t IP1553_GetRxBuffersStatus(void)
```

**Summary**:   
&nbsp;&nbsp;Returns the reception buffers status   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Bitfield value that indicates for each of the 32 buffers if they are   
&nbsp;&nbsp;free to receive data or not : empty (1) or full(0)

---

## IP1553_ResetRxBuffersStatus
```C
void IP1553_ResetRxBuffersStatus(uint32_t buffers)
```

**Summary**:   
&nbsp;&nbsp;Reset the reception buffers status   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*buffers*   
&nbsp;&nbsp;&nbsp;&nbsp;Bitfield of buffer to be reset.   
&nbsp;&nbsp;&nbsp;&nbsp;When reset a buffer is set ready to receive data (1) in status.   

**Returns**:   
&nbsp;&nbsp;None

---
## IP1553_IrqStatusGet
```C
IP1553_INT_MASK IP1553_IrqStatusGet( void )
```

**Summary**:   
&nbsp;&nbsp;Returns the IP1553 status   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Current status of instance   

---

## IP1553_BcStartDataTransfer
```C
void IP1553_BcStartDataTransfer(IP1553_DATA_TX_TYPE tranferType, uint8_t txAddr, uint8_t txSubAddr, uint8_t rxAddr, uint8_t rxSubAddr, uint8_t dataWordCount, IP1553_BUS bus )
```

**Summary**:   
&nbsp;&nbsp;Start BC command for data transfer   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   
&nbsp;&nbsp;IP1553_BuffersConfigSet must have been called to set allocated buffers   
&nbsp;&nbsp;IP1553_ResetRxBuffersStatus and IP1553_ResetTxBuffersStatus must   
&nbsp;&nbsp;have been called for the concerned buffers (sub-address) used in the command   

**Parameters**:   
&nbsp;&nbsp;*tranferType*   
&nbsp;&nbsp;&nbsp;&nbsp;Type of data tranfer command to issue   
&nbsp;&nbsp;*txAddr*   
&nbsp;&nbsp;&nbsp;&nbsp;The transmitter address : 0 if BC, RT address otherwise   
&nbsp;&nbsp;*txSubAddr*   
&nbsp;&nbsp;&nbsp;&nbsp;The transmitter sub-address   
&nbsp;&nbsp;*rxAddr*   
&nbsp;&nbsp;&nbsp;&nbsp;The receiver address : 0 if BC, RT address otherwise   
&nbsp;&nbsp;*rxSubAddr*   
&nbsp;&nbsp;&nbsp;&nbsp;The receiver sub-address   
&nbsp;&nbsp;*dataWordCount*   
&nbsp;&nbsp;&nbsp;&nbsp;Number of data word (16 bit) to read/write. 0 stand for 32 data word   
&nbsp;&nbsp;*bus*   
&nbsp;&nbsp;&nbsp;&nbsp;Indicate if the transfer uses physical BUS A or B   

**Returns**:   
&nbsp;&nbsp;None   

---

## IP1553_GetFirstStatusWord
```C
uint16_t IP1553_GetFirstStatusWord( void )
```

**Summary**:   
&nbsp;&nbsp;Returns the IP1553 transfer first status word   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Value of transfer first status word   

---

## IP1553_GetSecondStatusWord
```C
uint16_t IP1553_GetSecondStatusWord( void )
```

**Summary**:   
&nbsp;&nbsp;Returns the IP1553 transfer second status word   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;None   

**Returns**:   
&nbsp;&nbsp;Value of transfer second status word

---

## IP1553_BCEnableCmdSet
```C
void IP1553_BCEnableCmdSet(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable BCEnableCmd bit to accepts or rejects the control when the terminal   
&nbsp;&nbsp;receives a valid Dynamic Bus Control mode command. This is the value indicated   
&nbsp;&nbsp;in the Dynamic Bus Control bit of the status word sent in response to the mode command   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, The terminal accepts the bus control. If false, the terminal reject the bus control   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_SREQBitCmdSet
```C
void IP1553_SREQBitCmdSet(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable or Disable SREQBitCmd bit. Indicates the value of the Service Request   
&nbsp;&nbsp;bit to be returned in status word transfers   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, Service Request bit returned in status word transfers is 1. 0 if false   

**Returns**:   
&nbsp;&nbsp;None   

---

## IP1553_BusyBitCmdSet
```C
void IP1553_BusyBitCmdSet(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable or Disable SREQBitCmd bit. Indicates the value of the busy bit to be   
&nbsp;&nbsp;returned in status word transfers. If enabled, Inhibits the transmission of   
&nbsp;&nbsp;the data words in response to a transmit command and its corresponding interrupt   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, busy bit returned in status word transfers is 1. 0 if false   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_SSBitCmdSet
```C
void IP1553_SSBitCmdSet(bool enable)
```

**Summary**:   
&nbsp;&nbsp;Enable or Disable SSBitCmd bit. Indicates the value of the Subsystem Flag bit   
&nbsp;&nbsp;to be returned in status word transfers   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, Subsystem Flag bit returned in status word transfers is 1. 0 if false   

**Returns**:   
&nbsp;&nbsp;None

---

## IP1553_TRBitCmdSet
```C
void IP1553_TRBitCmdSet(bool enable)
```

&nbsp;&nbsp;**Summary**:   
&nbsp;&nbsp;Enable or Disable TRBitCmd bit. Indicates the value of the T/F bit to be   
&nbsp;&nbsp;returned in status word transfers   

**Precondition**:   
&nbsp;&nbsp;IP1553_Initialize must have been called for the IP1553 instance   

**Parameters**:   
&nbsp;&nbsp;*enable*   
&nbsp;&nbsp;&nbsp;&nbsp;If true, T/F bit returned in status word transfers is 1. 0 if false   

**Returns**:   
&nbsp;&nbsp;None   

**Note**:   
&nbsp;&nbsp;After reception of a valid "Inhibit T/F Bit" command the T/F bit is maintained   
&nbsp;&nbsp;at logic level 0   

