---
grand_parent: Peripheral libraries
parent: IP1553 Peripheral Library
title: IP1553 Peripheral Library Interface
has_toc: true
nav_order: 2
---

# Peripheral Library Interface
{: .no_toc }

### Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Data Types and Constants

### IP1553_INT_MASK

```c
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

**Summary**

Identifies the IP1553 current interrupt status

**Description**

This data type identifies the IP1553 interrupt status

---

### IP1553_CALLBACK

```c
typedef void (*IP1553_CALLBACK) (uintptr_t contextHandle);
```

**Summary**

IP1553 Callback Function Pointer.

**Description**

This data type defines the required function signature for the IP1553 callback function. Application must register a pointer to a callback function whose function signature (parameter and return value types) match the types specified by this function pointer in order to receive callback from the PLIB.
The parameters and return values are described here and a partial example implementation is provided.

**Parameters**

*contextHandle* Value identifying the context of the application that registered the callback function

**Remarks**

The context parameter contains the a handle to the client context, provided at the time the callback function was registered using the CallbackRegister function. This context handle value is passed back to the client as the "context" parameter. It can be any value (such as a pointer to the client's data) necessary to identify the client context or instance of the client that made the data transfer request.

The callback function executes in the PLIB's interrupt context. It is recommended of the application to not perform process intensive or blocking operations with in this function.

**Example**

```c
void APP_IP1553_Handler(uintptr_t context)
{
    //Fixable error has occurred
}

IP1553_CallbackRegister(&APP_IP1553_Handler, (uintptr_t)NULL);
```

---

### IP1553_OBJ

```c
typedef struct
{
    /* Transfer Event Callback */
    IP1553_CALLBACK callback;

    /* Transfer Event Callback Context */
    uintptr_t context;
} IP1553_OBJ;
```

**Summary**

IP1553 PLib Object structure

**Description**

This data structure defines the IP1553 PLib Instance Object

---

### IP1553_DATA_TX_TYPE

```c
typedef enum
{
    IP1553_DATA_TX_TYPE_BC_TO_RT = 0,
    IP1553_DATA_TX_TYPE_RT_TO_BC,
    IP1553_DATA_TX_TYPE_RT_TO_RT,
} IP1553_DATA_TX_TYPE;
```

**Summary**

IP1553 data transfer types

**Description**

This data type identifies the data transfer type that BC initiate

---

### IP1553_BUS

```c
typedef enum
{
    IP1553_BUS_A = 0,
    IP1553_BUS_B
} IP1553_BUS;
```

**Summary**

IP1553 output bus selection

**Description**

This data type identifies the IP1553 output bus selection

---

## Initialization functions

### IP1553_Initialize

```c
void IP1553_Initialize(void)
```

**Summary**

Initializes given instance of the IP1553 peripheral Set the Mode (Bus Controller or Remote Terminal) and reset the instance. In RT mode, set the RT Address Enable all 1553 interrupt sources

**Preconditions**

None

**Parameters**

None

**Returns**

None

---

## Setup functions

### IP1553_BuffersConfigSet

```c
void IP1553_BuffersConfigSet(uint16_t* txBuffers, uint16_t* rxBuffers)
```

**Summary**

Set the memory base address for emmission and reception buffers

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

*txBuffers* Pointer to application allocated emission buffer base address. Application must allocate buffer from non-cached contiguous memory and buffer size must be 16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM.

*rxBuffers*

Pointer to application allocated reception buffer base address. Application must allocate buffer from non-cached contiguous memory and buffer size must be 16 bit * IP1553_BUFFERS_SIZE * IP1553_BUFFERS_NUM.

**Returns**

None

---

### Status functions

#### IP1553_GetTxBuffersStatus

```c
uint32_t IP1553_GetTxBuffersStatus(void)
```

**Summary**

Returns the transmission buffers status

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

None

**Returns**

Bitfield value that indicates for each of the 32 buffers if they are ready to be sent (1) or are empty (0)

---

#### IP1553_ResetTxBuffersStatus

```c
void IP1553_ResetTxBuffersStatus(uint32_t buffers)
```

**Summary**

Reset the transmission buffers status

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

*buffers* Bitfield of buffer to be reset. When reset a buffer is set ready to be sent (1) in status.

**Returns**

None

---

#### IP1553_GetRxBuffersStatus

```c
uint32_t IP1553_GetRxBuffersStatus(void)
```

**Summary**

Returns the reception buffers status

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

None

**Returns**

Bitfield value that indicates for each of the 32 buffers if they are free to receive data or not : empty (1) or full(0).

---

#### IP1553_ResetRxBuffersStatus

```c
void IP1553_ResetRxBuffersStatus(uint32_t buffers)
```

**Summary**

Reset the reception buffers status

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

*buffers* Bitfield of buffer to be reset. When reset a buffer is set ready to receive data (1) in status.

**Returns**

None

---

#### IP1553_IrqStatusGet

```c
IP1553_INT_MASK IP1553_IrqStatusGet( void )
```

**Summary**

Returns the IP1553 status

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

None

**Returns**

Current status of instance

---

### IP1553_BcStartDataTransfer

```c
void IP1553_BcStartDataTransfer(IP1553_DATA_TX_TYPE tranferType, uint8_t txAddr, uint8_t txSubAddr, uint8_t rxAddr, uint8_t rxSubAddr, uint8_t dataWordCount, IP1553_BUS bus )
```

**Summary**

Start BC command for data transfer

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance IP1553_BuffersConfigSet must have been called to set allocated buffers IP1553_ResetRxBuffersStatus and IP1553_ResetTxBuffersStatus must have been called for the concerned buffers (sub-address) used in the command.

**Parameters**

*tranferType* Type of data tranfer command to issue
*txAddr* The transmitter address : 0 if BC, RT address otherwise
*txSubAddr* The transmitter sub-address
*rxAddr* The receiver address : 0 if BC, RT address otherwise
*rxSubAddr* The receiver sub-address
*dataWordCount* Number of data word (16 bit) to read/write. 0 stand for 32 data word
*bus* Indicate if the transfer uses physical BUS A or B

**Returns**

None

---

### IP1553_GetFirstStatusWord

```c
uint16_t IP1553_GetFirstStatusWord( void )
```

**Summary**

Returns the IP1553 transfer first status word

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

None

**Returns**

Value of transfer first status word

---

### IP1553_GetSecondStatusWord

```c
uint16_t IP1553_GetSecondStatusWord( void )
```

**Summary**

Returns the IP1553 transfer second status word

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

None

**Returns**

Value of transfer second status word

---

### IP1553_BCEnableCmdSet

```c
void IP1553_BCEnableCmdSet(bool enable)
```

**Summary**

Enable BCEnableCmd bit to accepts or rejects the control when the terminal receives a valid Dynamic Bus Control mode command. This is the value indicated in the Dynamic Bus Control bit of the status word sent in response to the mode command

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance

**Parameters**

*enable* If true, The terminal accepts the bus control. If false, the terminal reject the bus control

**Returns**

None

---

### IP1553_SREQBitCmdSet

```c
void IP1553_SREQBitCmdSet(bool enable)
```

**Summary**

Enable or Disable SREQBitCmd bit. Indicates the value of the Service Request bit to be returned in status word transfers.

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance.

**Parameters**

*enable* If true, Service Request bit returned in status word transfers is 1. 0 if false.

**Returns**

None

---

### IP1553_BusyBitCmdSet

```c
void IP1553_BusyBitCmdSet(bool enable)
```

**Summary**

Enable or Disable SREQBitCmd bit. Indicates the value of the busy bit to be returned in status word transfers. If enabled, Inhibits the transmission of the data words in response to a transmit command and its corresponding interrupt.

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance.

**Parameters**

*enable* If true, busy bit returned in status word transfers is 1. 0 if false.

**Returns**

None

---

### IP1553_SSBitCmdSet

```c
void IP1553_SSBitCmdSet(bool enable)
```

**Summary**

Enable or Disable SSBitCmd bit. Indicates the value of the Subsystem Flag bit to be returned in status word transfers.

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance.

**Parameters**

*enable* If true, Subsystem Flag bit returned in status word transfers is 1. 0 if false.

**Returns**

None

---

### IP1553_TRBitCmdSet

```c
void IP1553_TRBitCmdSet(bool enable)
```

**Summary**

Enable or Disable TRBitCmd bit. Indicates the value of the T/F bit to be returned in status word transfers.

**Preconditions**

IP1553_Initialize must have been called for the IP1553 instance.

**Parameters**

*enable* If true, T/F bit returned in status word transfers is 1. 0 if false.

**Returns**

None

**Note**:

After reception of a valid "Inhibit T/F Bit" command the T/F bit is maintained at logic level 0.
